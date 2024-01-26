import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:doclink/doctor/common/custom_ui.dart';
import 'package:doclink/doctor/generated/l10n.dart';
import 'package:doclink/doctor/model/doctorProfile/registration/registration.dart';
import 'package:doclink/doctor/screen/dashboard_screen/dashboard_screen.dart';
import 'package:doclink/doctor/screen/doctor_registration_screen/doctor_profile_screen_four/doctor_profile_screen_four.dart';
import 'package:doclink/doctor/screen/doctor_registration_screen/doctor_profile_screen_one/doctor_profile_screen_one.dart';
import 'package:doclink/doctor/screen/doctor_registration_screen/doctor_profile_screen_three/doctor_profile_screeen_three.dart';
import 'package:doclink/doctor/screen/doctor_registration_screen/doctor_profile_screen_two/doctor_profile_screen_two.dart';
import 'package:doclink/doctor/screen/doctor_registration_screen/select_category_screen/select_category_screen.dart';
import 'package:doclink/doctor/screen/doctor_registration_screen/starting_profile_screen/starting_profile_screen.dart';
import 'package:doclink/doctor/screen/registration_successful_screen.dart/registration_successful_screen.dart';
import 'package:doclink/doctor/service/api_service.dart';
import 'package:doclink/doctor/service/doctor_pref_service.dart';
import 'package:doclink/patient/screen/complete_registration_screen/doctor_profile_screen_four/doctor_profile_screen_four.dart';
import 'package:doclink/patient/screen/complete_registration_screen/medical_history.dart';
import 'package:doclink/patient/screen/dashboard_screen/dashboard_screen.dart';
import 'package:doclink/utils/update_res.dart';
import 'package:doclink/patient/screen/complete_registration_screen/complete_registration_screen.dart';
import 'package:doclink/patient/services/api_service.dart';
import 'package:doclink/patient/services/patient_pref_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneVerificationScreenController extends GetxController {
  TextEditingController otpController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  int timerCount = 90;
  PhoneNumber? phoneNumber;
  String? _verificationId;
  Timer? _timer;
  DoctorPrefService docprefService = DoctorPrefService();
  PatientPrefService patprefService = PatientPrefService();
  DoctorData? userData;
  String? deviceToken = '';

  @override
  void onInit() {
    FirebaseMessaging.instance.getToken().then((value) {
      log('📩  ${value.toString()}');
      deviceToken = value;
    });
    phoneNumber = Get.arguments[0];
    _verificationId = Get.arguments[1];
    timerForOtp();
    super.onInit();
  }

  void verifyPhoneNumber() async {
    if (otpController.text.isEmpty) {
      CustomUi.snackBar(
          message: S.current.pleaseEnterYourOtp,
          iconData: Icons.text_fields_rounded);
      return;
    }
    if (deviceToken == null || deviceToken!.isEmpty) {
      FirebaseMessaging.instance.getToken().then((value) {
        log(value!);
        deviceToken = value;
      });
    }
    CustomUi.loader();
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: '$_verificationId', smsCode: otpController.text);
      await auth.signInWithCredential(credential).then(
        (value)async{
          PatientPrefService pPrefservice = PatientPrefService();
          await pPrefservice.init();
          DoctorPrefService dPrefservice = DoctorPrefService();
          await dPrefservice.init();
          if(pPrefservice.getString(key: 'role') != null && pPrefservice.getString(key: 'role') == 'patient'){
            print("hello");
             PatientApiService.instance.registration(
               identity:
                    '${phoneNumber?.dialCode} ${phoneNumber?.phoneNumber?.replaceAll('${phoneNumber?.dialCode}', '')}',
                deviceToken: deviceToken,
                deviceType: Platform.isAndroid ? 1 : 2,
                loginType: 1
            )
            .then((value) async {
              print(value);
          if (value.status == true) {
            Get.back();
            await patprefService.init();
            await patprefService.saveString(
                key: kRegistrationUser, value: jsonEncode(value.data));
            await patprefService.setLogin(key: kLogin, value: true);
            if (value.data?.fullname == null ||
                value.data?.dob == null ||
                value.data?.countryCode == null ||
                value.data?.gender == null) {
              Get.offAll(() => const CompleteRegistrationScreen());
            } 
            else if(value.data?.medical_history == null){
              Get.to(()=>MedicalHistory());
            }
            else {
              if(patprefService.getString(key: "is_agreed_term") == null){
                Get.to(()=>PatientTermUse());
              }else{
                Get.to(() => const PatientDashboardScreen());
              }
            }
          } else {
            Get.back();
          }
        });
          }
          if(dPrefservice.getString(key: 'role') != null && dPrefservice.getString(key: 'role') == 'doctor'){
            print('hello doctor');
            DoctorApiService.instance
              .doctorRegistration(
                  mobileNumber:
                      '${phoneNumber?.dialCode} ${phoneNumber?.phoneNumber?.replaceAll('${phoneNumber?.dialCode}', '')}',
                  deviceToken: deviceToken)
              .then(
            (value) async {
              if (value.status == true) {
                Get.back();
                await docprefService.init();
                await docprefService.setLogin(key: kLogin, value: true);
                DoctorPrefService.id = value.data?.id;
                userData = value.data;
                if (value.data?.status == 1 || value.data?.status == 2) {
                  Get.offAll(() => const DashboardScreen());
                } else {
                  navigateRoot();
                }
              } else {
                Get.back();
                CustomUi.snackBar(
                    message: value.message, iconData: Icons.person);
              }
            },
          );
          }
        },
      );
    } catch (e) {
      Get.back();
      CustomUi.snackBar(
          message: S.current.smsVerificationCodeEtc,
          iconData: Icons.verified_rounded);
    }
  }

  void navigateRoot() {
    DoctorPrefService prefService = DoctorPrefService();
    if (userData?.name == null || userData?.gender == null) {
      Get.offAll(() => const StartingProfileScreen());
    } else if (userData?.categoryId == null) {
      Get.offAll(() => const SelectCategoryScreen());
    } else if (userData?.image == null ||
        userData?.designation == null ||
        userData?.degrees == null ||
        userData?.experienceYear == null ||
        userData?.consultationFee == null) {
      Get.offAll(() => const DoctorProfileScreenOne());
    } else if (userData?.aboutYouself == null ||
        userData?.educationalJourney == null) {
      Get.offAll(() => const DoctorProfileScreenTwo());
    }  else {
      if(prefService.getString(key: "is_agreed_term") == null){
            Get.offAll(()=>DoctorProfileScreenFour());
          }else{
            Get.to(()=>RegistrationSuccessfulScreen());
          }
    }
  }

  Future<void> resendOtp() async {
    CustomUi.loader();
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber?.phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (AuthCredential authCredential) {},
      verificationFailed: (FirebaseAuthException e) {
        Get.back();
        if (e.code == 'invalid-phone-number') {
          CustomUi.snackBar(
              message: S.current.theProvidedPhoneEtc,
              iconData: Icons.not_interested_rounded);
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        Get.back();
        _timer?.cancel();
        timerCount = 90;
        timerForOtp();
      },
      codeAutoRetrievalTimeout: (String verId) {},
    );
  }

  void timerForOtp() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (timerCount != 0) {
          timerCount--;
          update([kTimerUpdate]);
        }
      },
    );
  }

  @override
  void onClose() {
    _timer?.cancel();
    otpController.dispose();
    super.onClose();
  }
}
