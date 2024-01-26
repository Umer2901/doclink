import 'package:doclink/doctor/common/custom_ui.dart';
import 'package:doclink/doctor/generated/l10n.dart';
import 'package:doclink/doctor/model/appointment_slot/appointment_slot.dart';
import 'package:doclink/doctor/model/doctorProfile/registration/registration.dart';
import 'package:doclink/doctor/service/api_service.dart';
import 'package:doclink/utils/update_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppointmentSlotsScreenController extends GetxController {
  List<AppointmentSlot> appointmentSlot = [
    AppointmentSlot(S.current.monday, []),
    AppointmentSlot(S.current.tuesday, []),
    AppointmentSlot(S.current.wednesday, []),
    AppointmentSlot(S.current.thursday, []),
    AppointmentSlot(S.current.friday, []),
    AppointmentSlot(S.current.saturday, []),
    AppointmentSlot(S.current.sunday, [])
  ];

  bool isLoading = false;
  DoctorData? registrationData;
  final now = DateTime.now();

  @override
  void onInit() {
    fetchDoctorApiCall();
    super.onInit();
  }

  void fetchDoctorApiCall() {
    isLoading = true;
    DoctorApiService.instance.fetchMyDoctorProfile().then((value) {
      registrationData = value.data;
      registrationData?.slots?.forEach((element) {
        appointmentSlot[(element.weekday! - 1)].time.add(element);
      });
      isLoading = false;
      update();
    });
  }

  void addAppointmentSlot(String? time, int weekDay) {
    DoctorApiService.instance
        .addAppointmentSlots(time: time, weekday: weekDay)
        .then((value) {
      if (value.status == true) {
        Slots? s = value.data?.last;
        appointmentSlot[weekDay - 1].time.add(s);
      } else {
        CustomUi.snackBar(
            message: value.message, iconData: Icons.laptop_chromebook_rounded);
      }
      update();
    });
  }

  void addBtnTap(int slotIndex) {
    showTimePicker(context: Get.context!, initialTime: TimeOfDay.now())
        .then((value) {
      if (value != null) {
        DateTime time =
            DateTime(now.year, now.month, now.day, value.hour, value.minute);
        addAppointmentSlot(
            DateFormat(hhMm, 'en').format(time), (slotIndex + 1));
      }
    });
  }

  void deleteSlot(Slots? time) {
    DoctorApiService.instance.deleteAppointmentSlot(slotId: time?.id).then((value) {
      appointmentSlot[time!.weekday! - 1].time.removeWhere((element) {
        return element?.time == time.time;
      });
      update([kAppointmentDelete]);
    });
  }
}
