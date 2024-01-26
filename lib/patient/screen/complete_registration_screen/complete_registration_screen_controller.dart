import 'package:doclink/patient/screen/complete_registration_screen/medical_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:doclink/patient/common/custom_ui.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/patient/model/custom/countries.dart';
import 'package:doclink/patient/model/user/registration.dart';
import 'package:doclink/patient/screen/complete_registration_screen/widget/country_sheet.dart';
import 'package:doclink/patient/screen/dashboard_screen/dashboard_screen.dart';
import 'package:doclink/patient/services/api_service.dart';
import 'package:doclink/patient/services/patient_pref_service.dart';
import 'package:doclink/utils/extention.dart';
import 'package:doclink/utils/update_res.dart';

class CompleteRegistrationScreenController extends GetxController {
  final genders = [PS.current.male, PS.current.female];
  String selectGender = PS.current.male;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController dateController =
      TextEditingController(text: DateTime.now().formatDateTime(ddMMMYyyy));
  DateTime selectedDate = DateTime.now();
  PatientPrefService prefService = PatientPrefService();
  RegistrationData? userData;
  List<Country> countries = [];
  List<Country> filterCountry = [];
  Country? selectCountry;
  bool isName = false;
  String countryName = '';

  @override
  void onInit() {
    prefData();
    super.onInit();
  }

  void onGenderChange(String? value) {
    selectGender = value!;
    update();
  }

  void selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.utc(DateTime.now().year, DateTime.now().month,
          DateTime.utc(DateTime.now().year, DateTime.now().month + 1, 0).day),
      builder: (context, child) {
        return Container(
          child: child,
        );
      },
    );

    if (newSelectedDate != null) {
      selectedDate = newSelectedDate;
      dateController
        ..text = selectedDate.formatDateTime(ddMMMYyyy)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: dateController.text.length,
            affinity: TextAffinity.upstream));
    }
    update([kChangeDate]);
  }

  void prefData() async {
    await prefService.init();

    countries = prefService.getCountries()?.country ?? [];
    filterCountry = prefService.getCountries()?.country ?? [];
    selectCountry = countries.first;     
    countryName = countries.first.countryName ?? '';
    userData = prefService.getRegistrationData();
    fullNameController = TextEditingController(text: userData?.fullname ?? '');
    if (userData?.gender != null) {
      selectGender = userData?.gender == 1 ? PS.current.male : PS.current.female;
    }
    if (userData?.dob != null) {
      dateController =
          TextEditingController(text: CustomUi.dateFormat(userData?.dob));
    }
    if (userData?.countryCode != null) {
      selectCountry = countries.firstWhere((element) {
        return element.countryCode == userData?.countryCode.toString();
      });
    }
    update();
  }

  void onSubmitBtnClick() async {
    isName = false;
    if (fullNameController.text.isEmpty) {
      isName = true;
      return;
    }
    CustomUi.loader();
    PatientApiService.instance
        .updateUserDetails(
            name: fullNameController.text,
            countryCode: selectCountry?.phoneCode,
            gender: selectGender == PS.current.male ? 1 : 0,
            dob: DateFormat(yyyyMMDd).format(selectedDate))
        .then(
      (value) {
        if (value.status == true) {
          Get.back();
          CustomUi.snackBar(
              message: value.message ?? '',
              iconData: Icons.person,
              positive: true);
          Get.offAll(() => const MedicalHistory());
        } else {
          Get.back();
          CustomUi.snackBar(
              message: value.message ?? '', iconData: Icons.person);
        }
      },
    );
  }

  @override
  void onClose() {
    fullNameController.dispose();
    dateController.dispose();
    super.onClose();
  }

  void countryBottomSheet() {
    Get.bottomSheet(
      GetBuilder<CompleteRegistrationScreenController>(builder: (context) {
        return CountrySheet(
            country: filterCountry,
            onCountryChange: onCountryChange,
            onCountryTap: onCountryTap,
            controller: countryController);
      }),
      isScrollControlled: true,
    ).then((value) {
      countryController.clear();
      filterCountry = countries;
    });
  }

  onCountryTap(Country value) {
    countryName = value.countryName ?? '';
    selectCountry = value;
    update();
    Get.back();
  }

  void onCountryChange(String value) {
    filterCountry = countries.where((element) {
      return (element.countryName ?? '')
          .isCaseInsensitiveContains(countryController.text);
    }).toList();
    update();
  }
}
