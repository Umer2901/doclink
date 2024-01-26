import 'package:doclink/doctor/common/common_fun.dart';
import 'package:doclink/doctor/common/custom_ui.dart';
import 'package:doclink/doctor/model/appointment/appointment_request.dart';
import 'package:doclink/doctor/model/doctorProfile/registration/registration.dart';
import 'package:doclink/doctor/screen/appointment_screen/widget/select_month_dialog.dart';
import 'package:doclink/doctor/service/api_service.dart';
import 'package:doclink/doctor/service/doctor_pref_service.dart';
import 'package:doclink/utils/update_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppointmentScreenController extends GetxController {
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  int day = DateTime.now().day;
  DateTime? selectedDay;
  DateTime focusedDay = DateTime.now();
  List<AppointmentData>? acceptAppointment;
  List<AppointmentData>? filterAppointment;
  bool isLoading = false;
  DoctorPrefService prefService = DoctorPrefService();
  TextEditingController searchController = TextEditingController();

  DoctorData? doctorData;

  @override
  void onInit() {
    prefData();
    fetchAcceptedAppointsByDateApiCall(date: DateTime(year, month, day));
    super.onInit();
  }

  void onDoneClick(int month, int year) {
    CommonFun.doctorBanned(() {
      this.year = year;
      this.month = month;
      fetchAcceptedAppointsByDateApiCall(date: DateTime(year, month, day));
      update([kAppointmentDateChange]);
    });
  }

  void onSelectedDateClick(int year, int month, int day) async {
    CommonFun.doctorBanned(() {
      this.year = year;
      this.month = month;
      this.day = day;
      fetchAcceptedAppointsByDateApiCall(date: DateTime(year, month, day));
      update([kAppointmentDateChange]);
    });
  }

  void fetchAcceptedAppointsByDateApiCall({required DateTime date}) async {
    isLoading = true;
    update();
    //CustomUi.loader();
    DoctorApiService.instance
        .fetchAcceptedAppointsByDate(
            date: DateFormat(yyyyMmDd, 'en').format(date))
        .then((value) {
      acceptAppointment = value.data;
      filterAppointment = value.data;
      isLoading = false;
      update();
    });
  }

  void onSearchChanged(String value) {
    if (searchController.text.isEmpty) {
      filterAppointment = acceptAppointment;
    } else {
      filterAppointment = acceptAppointment
          ?.where((element) => (element.user?.fullname ?? '')
              .isCaseInsensitiveContains(searchController.text))
          .toList();
    }
    update();
  }

  void prefData() async {
    await prefService.init();
    doctorData = prefService.getRegistrationData();
    update();
  }

  void onAppointmentBoxTap() {
    CommonFun.doctorBanned(() {
      showDialog(
        context: Get.context!,
        builder: (context) => SelectMonthDialog(
          onDoneClick: onDoneClick,
          month: month,
          year: year,
        ),
      );
    });
  }
}
