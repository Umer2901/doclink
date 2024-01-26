import 'dart:io';

import 'package:doclink/doctor/common/custom_ui.dart';
import 'package:doclink/doctor/generated/l10n.dart';
import 'package:doclink/doctor/model/countries/countries.dart';
import 'package:doclink/doctor/model/doctorProfile/registration/registration.dart';
import 'package:doclink/doctor/model/doctor_category/doctor_category.dart';
import 'package:doclink/doctor/screen/personal_information_screen/otp_sheet/otp_sheet.dart';
import 'package:doclink/doctor/screen/personal_information_screen/widget/mobile_number_change_sheet.dart';
import 'package:doclink/doctor/service/api_service.dart';
import 'package:doclink/doctor/service/doctor_pref_service.dart';
import 'package:doclink/utils/const_res.dart';
import 'package:doclink/utils/update_res.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PersonalInformationScreenController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController feesController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  Countries? countries;
  Country? selectCountry;
  DoctorCategoryData? selectCategory;
  DoctorPrefService prefService = DoctorPrefService();
  DoctorData? doctorData;
  String? netWorkProfileImage;
  File? profileImage;
  List<DoctorCategoryData>? categoryData;
  bool isLoading = false;

  FocusNode phoneFocusNode = FocusNode();
  PhoneNumber? phoneNumber;
  FocusNode nameFocusNode = FocusNode();
  FocusNode designationFocusNode = FocusNode();
  FocusNode degreeFocusNode = FocusNode();
  FocusNode languageFocusNode = FocusNode();
  FocusNode yearFocusNode = FocusNode();
  FocusNode feesFocusNode = FocusNode();

  @override
  void onInit() {
    fetchCategoryApiCall();
    getCountryData();
    super.onInit();
  }

  void onCountryChange(Country? value) {
    selectCountry = value!;
    update();
  }

  void prefData() async {
    await prefService.init();
    doctorData = prefService.getRegistrationData();
    if (doctorData != null) {
      mobileController =
          TextEditingController(text: doctorData?.mobileNumber ?? '');
      netWorkProfileImage = doctorData?.image;
      nameController =
          TextEditingController(text: doctorData?.name ?? S.current.unKnown);
      designationController = TextEditingController(
          text: doctorData?.designation ?? S.current.addYourDesignation);
      degreeController = TextEditingController(
          text: doctorData?.degrees ?? S.current.addYourDegreesEtc);
      languageController =
          TextEditingController(text: doctorData?.languagesSpoken ?? '');
      yearController = TextEditingController(
          text: doctorData?.experienceYear.toString() ?? '');
      feesController = TextEditingController(
          text: NumberFormat(numberFormat).format(doctorData?.consultationFee));
      selectCategory = categoryData?.firstWhere((element) {
        return element.id == doctorData?.categoryId;
      });
      if (doctorData?.countryCode != null) {
        selectCountry = countries?.country?.firstWhere((element) {
          return element.countryCode == doctorData?.countryCode;
        });
      } else {
        selectCountry = countries?.country?.first;
      }
      update();
    }
  }

  void unFocusFiled() {
    nameFocusNode.unfocus();
    designationFocusNode.unfocus();
    degreeFocusNode.unfocus();
    languageFocusNode.unfocus();
    yearFocusNode.unfocus();
    feesFocusNode.unfocus();
  }

  void onCategoryChange(DoctorCategoryData? value) {
    selectCategory = value!;
    update();
  }

  void getCountryData() async {
    await prefService.init();
    countries = prefService.getCountries();
    update();
  }

  void fetchCategoryApiCall() async {
    isLoading = true;
    await DoctorApiService.instance.fetchDoctorCategories().then((value) {
      categoryData = value.data;
      isLoading = false;
      update();
    });
    prefData();
  }

  void onDesignationChange(String value) {
    update();
  }

  void onDegreeChange(String value) {
    update();
  }

  void updateProfileApiCall() {
    if (profileImage == null && netWorkProfileImage == null) {
      CustomUi.snackBar(
          message: S.current.pleaseSelectProfileImage, iconData: Icons.image);
      return;
    }
    if (nameController.text.isEmpty) {
      CustomUi.snackBar(
          message: S.current.pleaseEnterName,
          iconData: Icons.text_fields_rounded);
      return;
    }
    if (designationController.text.isEmpty) {
      CustomUi.snackBar(
          message: S.current.pleaseEnterDesignation,
          iconData: Icons.text_fields_rounded);
      return;
    }
    if (degreeController.text.isEmpty) {
      CustomUi.snackBar(
          message: S.current.pleaseEnterDegree,
          iconData: Icons.text_fields_rounded);
      return;
    }
    if (languageController.text.isEmpty) {
      CustomUi.snackBar(
          message: S.current.pleaseEnterLanguages,
          iconData: Icons.language_rounded);
      return;
    }
    if (yearController.text.isEmpty) {
      CustomUi.snackBar(
          message: S.current.pleaseEnterYearOfExperience,
          iconData: Icons.text_fields_rounded);
      return;
    }
    if (feesController.text.isEmpty) {
      CustomUi.snackBar(
          message: S.current.pleaseEnterConsultationFee,
          iconData: Icons.text_fields_rounded);
      return;
    }
    unFocusFiled();
    CustomUi.loader();
    DoctorApiService.instance
        .updateDoctorDetails(
      name: nameController.text,
      categoryId: selectCategory?.id,
      countryCode: selectCountry?.countryCode,
      image: profileImage,
      designation: designationController.text,
      degrees: degreeController.text,
      languagesSpoken: languageController.text,
      experienceYear: yearController.text,
      consultationFee: feesController.text.replaceAll(',', ''),
    )
        .then((value) {
      Get.back();
      if (value.status == true) {
        CustomUi.snackBar(
            iconData: Icons.person, positive: true, message: value.message);
      } else {
        CustomUi.snackBar(iconData: Icons.person, message: value.message);
      }
    });
  }

  void onNameChange(String value) {
    update();
  }

  void onImagePick() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: ConstRes.imageQuality,
        maxWidth: ConstRes.maxWidth,
        maxHeight: ConstRes.maxHeight);
    if (image != null) {
      profileImage = File(image.path);
    }
    update();
  }

  void onChangeTap(PersonalInformationScreenController controller) {
    Get.bottomSheet(MobileNumberChangeSheet(controller: controller),
            isScrollControlled: true)
        .then((value) {
      phoneNumber = null;
      update();
    });
  }

  void verifyPhoneNumber(PersonalInformationScreenController controller) {
    if (phoneNumber == null) {
      CustomUi.snackBar(
          message: S.current.pleaseEnterMobileNumber,
          iconData: Icons.phone_iphone_rounded);
      return;
    }
    DoctorApiService.instance
        .checkMobileNumberExists(
            mobileNumber:
                '${phoneNumber?.dialCode} ${phoneNumber?.phoneNumber?.replaceAll('${phoneNumber?.dialCode}', '')}')
        .then((value) async {
      if (value.status == true) {
        CustomUi.loader();
        try {
          await FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: '${phoneNumber?.phoneNumber}',
            timeout: const Duration(seconds: 60),
            verificationCompleted: (AuthCredential authCredential) {
              Get.back();
            },
            verificationFailed: (FirebaseAuthException e) {
              if (e.code == 'invalid-phone-number') {
                Get.back();
                CustomUi.snackBar(
                    message: S.current.theProvidedPhoneEtc,
                    iconData: Icons.not_interested_rounded);
              }
            },
            codeSent: (String verificationId, int? resendToken) {
              Get.back();
              Get.back();
              Get.bottomSheet(const OtpSheet(),
                  isScrollControlled: true,
                  isDismissible: false,
                  enableDrag: false,
                  settings: RouteSettings(
                      arguments: [phoneNumber, verificationId])).then((value) {
                prefData();
              });
            },
            codeAutoRetrievalTimeout: (String verId) {
              Get.back();
            },
          );
        } catch (e) {
          Get.back();
        }
      } else {
        CustomUi.snackBar(message: value.message, iconData: Icons.stop_rounded);
      }
    });
  }
}
