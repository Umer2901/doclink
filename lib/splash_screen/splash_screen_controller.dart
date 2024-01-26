import 'dart:convert';

import 'package:doclink/doctor/common/custom_ui.dart';
import 'package:doclink/doctor/model/appointment/appointment_request.dart';
import 'package:doclink/doctor/model/countries/countries.dart';
import 'package:doclink/doctor/model/doctorProfile/registration/registration.dart';
import 'package:doclink/doctor/screen/dashboard_screen/dashboard_screen.dart';
import 'package:doclink/doctor/screen/doctor_registration_screen/doctor_profile_screen_four/doctor_profile_screen_four.dart';
import 'package:doclink/doctor/service/local_auth_service.dart';
import 'package:doclink/patient/screen/complete_registration_screen/doctor_profile_screen_four/doctor_profile_screen_four.dart';
import 'package:doclink/patient/screen/complete_registration_screen/medical_history.dart';
import 'package:doclink/patient/screen/dashboard_screen/dashboard_screen.dart';
import 'package:doclink/doctor/screen/doctor_registration_screen/doctor_profile_screen_one/doctor_profile_screen_one.dart';
import 'package:doclink/doctor/screen/doctor_registration_screen/doctor_profile_screen_three/doctor_profile_screeen_three.dart';
import 'package:doclink/doctor/screen/doctor_registration_screen/doctor_profile_screen_two/doctor_profile_screen_two.dart';
import 'package:doclink/doctor/screen/doctor_registration_screen/select_category_screen/select_category_screen.dart';
import 'package:doclink/doctor/screen/doctor_registration_screen/starting_profile_screen/starting_profile_screen.dart';
import 'package:doclink/doctor/screen/registration_successful_screen.dart/registration_successful_screen.dart';
import 'package:doclink/doctor/service/api_service.dart';
import 'package:doclink/doctor/service/doctor_pref_service.dart';
import 'package:doclink/patient/model/user/registration.dart';
import 'package:doclink/utils/asset_res.dart';
import 'package:doclink/utils/const_res.dart';
import 'package:doclink/utils/update_res.dart';
import 'package:doclink/patient/screen/complete_registration_screen/complete_registration_screen.dart';
import 'package:doclink/patient/services/api_service.dart';
import 'package:doclink/patient/services/patient_pref_service.dart';
import 'package:doclink/phone_number_screen/phone_number_screen.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends GetxController {
  DoctorPrefService prefService = DoctorPrefService();
  PatientPrefService patientPrefService = PatientPrefService();
  bool isLogin = false;
  DoctorData? doctorData;
  Countries? country;
  RegistrationData? userData;
  int? userid;
  int? doctorid;

  @override
  void onInit()async{
    await prefData();
    super.onInit();
  }

  void countryData() async {
    String response = await rootBundle.loadString(AssetRes.countryJson);
    country = Countries.fromJson(jsonDecode(response));
    String encode = jsonEncode(country?.toJson());
    prefService.saveString(key: kCountries, value: encode);
  }

  Future<void> prefData() async {
    var service = await SharedPreferences.getInstance();
    if(service.getString("role") == 'patient'){
      await patientPrefService.init();
      countryData();
      isLogin = await patientPrefService.getBool(key: kLogin) ?? false;
      userData = patientPrefService.getRegistrationData();
      PatientPrefService.userId = userData?.id;
      PatientPrefService.identity = userData?.identity;
      userid = userData?.id;
      //navigatePatientRoot();
    }else{
      await prefService.init();
    countryData();
    isLogin = prefService.getLogin(key: kLogin);
    DoctorPrefService.id = prefService.getRegistrationData()?.id;
    print(DoctorPrefService.id);
    doctorid = DoctorPrefService.id;
    //navigateDoctorRoot();
    }
  }

  Future<void> navigateDoctorRoot() async {
     DoctorPrefService prefService = DoctorPrefService();
     await prefService.init();
    await prefService.saveString(key: "role", value: 'doctor',);
    if (DoctorPrefService.id != null && isLogin) {
      CustomUi.loader();
      bool isAuthenticate = await LocalAuth.authenticate();
      DoctorApiService.instance.fetchMyDoctorProfile().then((value) {
        Get.back();
        if (value.data?.status == 0) {
          if (value.data?.name == null || value.data?.gender == null) {
            Get.to(() => const StartingProfileScreen());
          } else if (value.data?.categoryId == null) {
            Get.to(() => const SelectCategoryScreen());
          } else if (value.data?.image == null ||
              value.data?.designation == null ||
              value.data?.degrees == null ||
              value.data?.experienceYear == null ||
              value.data?.consultationFee == null) {
            Get.to(() => const DoctorProfileScreenOne());
          } else if (value.data?.aboutYouself == null ||
              value.data?.educationalJourney == null) {
            Get.to(() => const DoctorProfileScreenTwo());
          } else {
            if(prefService.getString(key: "is_agreed_term") == null){
            Get.offAll(()=>DoctorProfileScreenFour());
          }else{
            Get.to(()=>RegistrationSuccessfulScreen());
          }
          }
        } else if (value.data?.status == 1 || value.data?.status == 2) {
          Get.to(()=>DashboardScreen());
        }
      });
    } else {
      Get.off(() => const PhoneNumberScreen());
    }
  }
  void navigatePatientRoot() async {
    PatientPrefService prefService = PatientPrefService();
    await prefService.init();
    await prefService.saveString(key: "role", value: 'patient');
    if (isLogin) {
      bool isAuthenticate = await LocalAuth.authenticate();
      if (PatientPrefService.userId != null) {
        CustomUi.loader();
        PatientApiService.instance.fetchMyUserDetails().then(
          (value) {
            if (value.data?.fullname == null ||
                value.data?.dob == null ||
                value.data?.countryCode == null ||
                value.data?.gender == null) {
              Get.to(() => const CompleteRegistrationScreen());
            } else if(value.data?.medical_history == null){
              Get.to(()=>MedicalHistory());
            }
            else {
              if(prefService.getString(key: "is_agreed_term") == null){
                Get.to(()=>PatientTermUse());
              }else{
                Get.to(() => const PatientDashboardScreen());
              }
            }
          },
        );
      } else {
        Get.off(() => const PhoneNumberScreen());
      }
    } else {
      Get.off(() => const PhoneNumberScreen());
    }
  }
  late final LocalAuthentication auth;
  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availabeBiometrics =
    await auth.getAvailableBiometrics();
    // then we call set state
  }
}
