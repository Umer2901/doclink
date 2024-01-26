import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/patient/model/doctor/fetch_doctor.dart';
import 'package:doclink/patient/model/home/home.dart';
import 'package:doclink/patient/screen/doctor_profile_screen/doctor_profile_screen.dart';
import 'package:doclink/patient/screen/specialists_detail_screen/widget/category_filter_list.dart';
import 'package:doclink/patient/services/api_service.dart';

class SpecialistsDetailScreenController extends GetxController {
  List<String> sortByList = [
    PS.current.feesLow,
    PS.current.feesHigh,
    PS.current.rating
  ];
  List<String> genderList = [PS.current.female, PS.current.male, PS.current.both];
  int? selectedSortBy;
  int? selectedGender;
  Categories? categories;
  List<Doctor> doctorData = [];
  ScrollController scrollController = ScrollController();
  bool isLoading = false;

  @override
  void onInit() {
    categories = Get.arguments;
    fetchScrollData();
    searchApiCall();
    super.onInit();
  }

  void onGenderTap(int index) {
    if (selectedGender == index) {
      selectedGender = null;
    } else {
      selectedGender = index;
    }
    update();
  }

  void onSortByTap(int index) {
    if (selectedSortBy == index) {
      selectedSortBy = null;
    } else {
      selectedSortBy = index;
    }
    update();
  }

  void searchApiCall() {
    isLoading = true;
    PatientApiService.instance
        .searchDoctor(
            categoryId: categories?.id,
            gender: selectedGender == 2 ? null : selectedGender,
            sortType: selectedSortBy == null ? null : (selectedSortBy! + 1),
            start: doctorData.length)
        .then((value) {
      doctorData.addAll(value.data!);
      isLoading = false;
      update();
    });
  }

  void onFilterTap({required SpecialistsDetailScreenController controller}) {
    Get.bottomSheet(
      CategoryFilterList(controller: controller),
    ).then(
      (value) {
        doctorData = [];
        searchApiCall();
      },
    );
  }

  void fetchScrollData() {
    scrollController.addListener(
      () {
        if (scrollController.offset ==
            scrollController.position.maxScrollExtent) {
          if (!isLoading) {
            searchApiCall();
          }
        }
      },
    );
  }

  void onClearAllTap() {
    selectedGender = null;
    selectedSortBy = null;
    doctorData = [];
    searchApiCall();
    update();
  }

  void onTypeRemove() {
    selectedSortBy = null;
    doctorData = [];
    searchApiCall();
    update();
  }

  void onGenderRemove() {
    selectedGender = null;
    doctorData = [];
    searchApiCall();
    update();
  }

  onDoctorCardTap(Doctor doctorData) {
    Get.to(() => const DoctorProfileScreen(), arguments: [doctorData]);
  }

  void onCloseTap() {
    doctorData = [];
    searchApiCall();
    Get.back();
  }
}
