import 'package:doclink/doctor/common/custom_ui.dart';
import 'package:doclink/doctor/model/doctorProfile/registration/registration.dart';
import 'package:doclink/doctor/service/api_service.dart';
import 'package:doclink/utils/update_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ManageHolidayScreenController extends GetxController {
  List<Holidays>? registrationData;
  bool isLoading = false;

  @override
  void onInit() {
    fetchDoctorApiCall();
    super.onInit();
  }

  void onDatePickerOpen() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate:
          DateTime.utc(DateTime.now().year + 3, DateTime.now().month).subtract(
        const Duration(days: 1),
      ),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat(yyyyMmDd, 'en').format(pickedDate);
      DoctorApiService.instance.addHoliday(date: formattedDate).then((value) {
        if (value.status == true) {
          fetchDoctorApiCall();
          CustomUi.snackBar(
              iconData: Icons.person, positive: true, message: value.message);
        } else {
          CustomUi.snackBar(
              iconData: Icons.person, positive: true, message: value.message);
        }
      });
    } else {}
  }

  void onHolidayDeleteTap(Holidays? holidayList) {
    DoctorApiService.instance.deleteHoliday(holidayId: holidayList?.id).then((value) {
      if (value.status == true) {
        fetchDoctorApiCall();
        CustomUi.snackBar(
            iconData: Icons.person, positive: true, message: value.message);
      } else {
        CustomUi.snackBar(
            iconData: Icons.person, positive: true, message: value.message);
      }
    });
  }

  void fetchDoctorApiCall() {
    isLoading = true;
    DoctorApiService.instance.fetchMyDoctorProfile().then((value) {
      registrationData = value.data?.holidays;
      isLoading = false;
      update();
    });
  }
}
