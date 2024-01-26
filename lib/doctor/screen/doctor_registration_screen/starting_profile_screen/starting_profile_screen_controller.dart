import 'dart:convert';

import 'package:doclink/doctor/common/custom_ui.dart';
import 'package:doclink/doctor/generated/l10n.dart';
import 'package:doclink/doctor/model/countries/countries.dart';
import 'package:doclink/doctor/model/doctorProfile/registration/registration.dart';
import 'package:doclink/doctor/screen/doctor_registration_screen/doctor_profile_screen_one/doctor_profile_screen_one.dart';
import 'package:doclink/doctor/screen/doctor_registration_screen/doctor_profile_screen_three/doctor_profile_screeen_three.dart';
import 'package:doclink/doctor/screen/doctor_registration_screen/doctor_profile_screen_two/doctor_profile_screen_two.dart';
import 'package:doclink/doctor/screen/doctor_registration_screen/select_category_screen/select_category_screen.dart';
import 'package:doclink/doctor/screen/registration_successful_screen.dart/registration_successful_screen.dart';
import 'package:doclink/doctor/service/api_service.dart';
import 'package:doclink/doctor/service/doctor_pref_service.dart';
import 'package:doclink/utils/asset_res.dart';
import 'package:doclink/utils/update_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class StartingProfileScreenController extends GetxController {
  Countries? countries;
  final genders = [S.current.male, S.current.feMale];
  Country? selectCountry;
  String selectGender = S.current.male;
  DoctorData? userData;
  DoctorPrefService prefService = DoctorPrefService();
  TextEditingController nameController = TextEditingController();
  bool Mr = false;
  bool Mrs = false;
  bool RN = false;
  bool Dr = true;
  FocusNode nameFocusNode = FocusNode();

  @override
  void onInit() {
    readJson();
    super.onInit();
  }

  void onCountryChange(Country? value) {
    selectCountry = value;
    update([kSelectCountries]);
  }

  void onGenderChange(String? value) {
    selectGender = value!;
    update([kSelectGender]);
  }
  String prfix = "Dr.";
  void selectPrefix(String prefix){
    if(prefix == "Dr."){
      Dr = !Dr;
      Mr = false;
      Mrs = false;
      RN = false;
      prfix = "Dr.";
      update();
    }else if(prefix == "Mr."){
       Dr = false;
      Mr = !Mr;
      Mrs = false;
      RN = false;
      prfix = "Mr.";
      update();
    }else if(prefix == "Ms."){
       Dr = false;
      Mr = false;
      Mrs = !Mrs;
      RN = false;
      prfix = "Ms.";
      update();
    }else if(prefix == "RN."){
       Dr = false;
      Mr = false;
      Mrs = false;
      RN = !RN;
      prfix = "Rn.";
      update();
    }
  }
  Future<void> readJson() async {
    final String response = await rootBundle.loadString(AssetRes.countryJson);
    countries = Countries.fromJson(json.decode(response));
    selectCountry = countries?.country?.first;
    prefData();
    update([kSelectCountries]);
  }

  void prefData() async {
    await prefService.init();
    userData = prefService.getRegistrationData();
    nameController = TextEditingController(
        text: userData?.name?.replaceAll('${S.current.dr} ', '') ?? '');
    if (userData?.countryCode != null) {
      selectCountry = countries?.country?.firstWhere((element) {
        return element.countryCode == userData?.countryCode;
      });
    } else if (userData?.mobileNumber != null) {
      selectCountry = countries?.country?.firstWhere((element) {
        return element.phoneCode == userData?.mobileNumber?.split(' ')[0];
      });
    }
    selectGender = userData?.gender == 1 ? S.current.male : S.current.feMale;
    update();
  }

  void updateDoctorDetailsApiCall() {
    nameFocusNode.unfocus();
    if (nameController.text.isEmpty) {
      CustomUi.snackBar(
        message: S.current.pleaseEnterName,
        iconData: Icons.drive_file_rename_outline_rounded,
      );
      return;
    }
    CustomUi.loader();
    DoctorApiService.instance
        .updateDoctorDetails(
            name: '${prfix} ${nameController.text}',
            countryCode: selectCountry?.countryCode ?? '',
            gender: selectGender == S.current.male ? 1 : 0)
        .then((value) {
      if (value.status == true) {
        Get.back();
        navigateRoot();
      } else {
        Get.back();
      }
    });
  }

  void navigateRoot() {
    if (userData?.categoryId == null) {
      Get.off(() => const SelectCategoryScreen());
    } else if (userData?.image == null ||
        userData?.designation == null ||
        userData?.degrees == null ||
        userData?.experienceYear == null ||
        userData?.consultationFee == null) {
      Get.off(() => const DoctorProfileScreenOne());
    } else if (userData?.aboutYouself == null ||
        userData?.educationalJourney == null) {
      Get.off(() => const DoctorProfileScreenTwo());
    }  else {
      Get.offAll(() => const RegistrationSuccessfulScreen());
    }
  }
}
