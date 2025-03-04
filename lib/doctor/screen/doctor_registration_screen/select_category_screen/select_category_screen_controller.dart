import 'package:doclink/doctor/common/custom_ui.dart';
import 'package:doclink/doctor/generated/l10n.dart';
import 'package:doclink/doctor/model/doctorProfile/registration/registration.dart';
import 'package:doclink/doctor/model/doctor_category/doctor_category.dart';
import 'package:doclink/doctor/screen/doctor_registration_screen/doctor_profile_screen_one/doctor_profile_screen_one.dart';
import 'package:doclink/doctor/screen/doctor_registration_screen/doctor_profile_screen_three/doctor_profile_screeen_three.dart';
import 'package:doclink/doctor/screen/doctor_registration_screen/doctor_profile_screen_two/doctor_profile_screen_two.dart';
import 'package:doclink/doctor/screen/doctor_registration_screen/select_category_screen/widget/suggest_us_sheet.dart';
import 'package:doclink/doctor/screen/registration_successful_screen.dart/registration_successful_screen.dart';
import 'package:doclink/doctor/service/api_service.dart';
import 'package:doclink/doctor/service/doctor_pref_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectCategoryScreenController extends GetxController {
  List<DoctorCategoryData>? categories = [];
  List<DoctorCategoryData>? filterList = [];
  DoctorCategoryData? selectedCategories;
  TextEditingController searchController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();
  FocusNode aboutFocusNode = FocusNode();
  DoctorPrefService prefService = DoctorPrefService();
  DoctorData? userData;

  @override
  void onInit() {
    doctorCategoryApiCall();
    super.onInit();
  }

  void onSelectedCategories(DoctorCategoryData? categories) {
    selectedCategories = categories;
    update();
  }

  void onSearchCategories(String value) {
    if (value.isEmpty) {
      filterList = categories;
    } else {
      filterList = categories
          ?.where((element) => element.title!.isCaseInsensitiveContains(value))
          .toList();
    }
    update();
  }

  void onSuggestUsTap() {
    Get.bottomSheet(
      SuggestUsSheet(controller: SelectCategoryScreenController()),
      isScrollControlled: true,
    );
  }

  void doctorCategoryApiCall() async {
    await DoctorApiService.instance.fetchDoctorCategories().then((value) {
      categories = value.data;
      filterList = value.data;
      update();
    });
    prefData();
  }

  void updateDoctorDetailsApiCall() {
    if (selectedCategories == null) {
      CustomUi.infoSnackBar(S.current.pleaseSelectCategory);
      return;
    }
    CustomUi.loader();
    DoctorApiService.instance
        .updateDoctorDetails(categoryId: selectedCategories?.id)
        .then((value) {
      if (value.status == true) {
        Get.back();
        navigateRoot();
      } else {
        Get.back();
      }
    });
  }

  void prefData() async {
    await prefService.init();
    userData = prefService.getRegistrationData();
    if (userData?.categoryId != null) {
      selectedCategories = categories?.firstWhere((element) {
        return element.id == userData?.categoryId;
      });
    }
    update();
  }

  void navigateRoot() {
    if (userData?.image == null ||
        userData?.designation == null ||
        userData?.degrees == null ||
        userData?.experienceYear == null ||
        userData?.consultationFee == null) {
      Get.off(() => const DoctorProfileScreenOne());
    } else if (userData?.aboutYouself == null ||
        userData?.educationalJourney == null) {
      Get.off(() => const DoctorProfileScreenTwo());
    } else if ((userData?.onlineConsultation == 0 &&
            userData?.clinicConsultation == 0) ||
        userData?.clinicName == null ||
        userData?.clinicAddress == null) {
      Get.off(() => const DoctorProfileScreenThree());
    } else {
      Get.offAll(() => const RegistrationSuccessfulScreen());
    }
  }

  void suggestDoctorCategoryApiCall() {
    if (titleController.text.isEmpty) {
      CustomUi.infoSnackBar(S.current.addCategoryNameForSuggestion);

      return;
    }
    if (aboutController.text.isEmpty) {
      CustomUi.infoSnackBar(S.current.pleaseExplainBrieflyEtc);
      return;
    }
    CustomUi.loader();
    DoctorApiService.instance
        .suggestDoctorCategory(
            title: titleController.text, about: aboutController.text)
        .then(
      (value) {
        if (value.status == true) {
          Get.back();
          Get.back();
          CustomUi.snackBar(
              iconData: Icons.category, positive: true, message: value.message);
        } else {
          Get.back();
          CustomUi.snackBar(
              message: value.message, iconData: Icons.category_rounded);
        }
      },
    );
  }
}
