import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/patient/model/doctor/fetch_doctor.dart';
import 'package:doclink/patient/model/home/home.dart';
import 'package:doclink/patient/screen/doctor_profile_screen/doctor_profile_screen.dart';
import 'package:doclink/patient/screen/search_screen/widget/filter_sheet.dart';
import 'package:doclink/patient/services/api_service.dart';

class SearchScreenController extends GetxController {
  int? selectedSortBy;
  int? selectedGender;
  int? selectCategoryIndex;
  bool isLoading = false;
  Categories? catId;
  List<String> sortByList = [
    PS.current.feesLow,
    PS.current.feesHigh,
    PS.current.rating
  ];
  List<String> genderList = [PS.current.female, PS.current.male, PS.current.both];
  TextEditingController keywordController = TextEditingController();
  List<String> filterList = [];
  List<Categories>? categories;
  List<Doctor> doctors = [];
  ScrollController scrollController = ScrollController();
  int start = 0;

  @override
  void onInit() {
    fetchHomePageDataApiCall();
    searchApiCall();
    scrollToFetchData();
    super.onInit();
  }

  void onSortByTap(int index) {
    if (selectedSortBy == index) {
      selectedSortBy = null;
    } else {
      selectedSortBy = index;
    }
    update();
  }

  void onGenderTap(int value) {
    if (selectedGender == value) {
      selectedGender = null;
    } else {
      selectedGender = value;
    }
    update();
  }

  void onCategoryTap(int? index, Categories? catId) {
    if (selectCategoryIndex == index) {
      selectCategoryIndex = null;
      this.catId = null;
    } else {
      selectCategoryIndex = index;
      this.catId = catId;
    }
    update();
  }

  void fetchHomePageDataApiCall() async {
    PatientApiService.instance.fetchHomePageData().then((value) {
      categories = value.categories;
      update();
    });
  }

  void onFilterSheetOpen(SearchScreenController controller) {
    Get.bottomSheet(FilterSheet(controller: controller),
            isScrollControlled: true)
        .then(
      (value) {
        doctors = [];
        searchApiCall();
      },
    );
  }

  void onKeyWordChange(String value) {
    doctors = [];
    if (keywordController.text.isNotEmpty) {
      searchApiCall();
    } else {
      keywordController.clear();
      searchApiCall();
    }
  }

  void searchApiCall() {
    isLoading = true;
    PatientApiService.instance
        .searchDoctor(
            keyword: keywordController.text,
            gender: selectedGender == 2 ? null : selectedGender,
            categoryId: catId?.id,
            sortType: selectedSortBy == null ? null : (selectedSortBy! + 1),
            start: doctors.length)
        .then((value) {
      List<String> list = doctors.map((e) => e.id?.toString() ?? '').toList();
      value.data?.forEach((element) {
        if (!list.contains(element.id?.toString())) {
          doctors.add(element);
        }
      });
      isLoading = false;
      update();
    });
  }

  void scrollToFetchData() {
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

  void onRemoveGender() {
    selectedGender = null;
    doctors = [];
    searchApiCall();
    update();
  }

  void onRemoveSortList() {
    selectedSortBy = null;
    doctors = [];
    searchApiCall();
    update();
  }

  void onRemoveCategory() {
    selectCategoryIndex = null;
    catId = null;
    doctors = [];
    searchApiCall();
    update();
  }

  onDoctorCardTap(Doctor doctor) {
    Get.to(
      () => const DoctorProfileScreen(),
      arguments: doctor,
    );
  }
}
