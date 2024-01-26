import 'package:doclink/doctor/common/custom_ui.dart';
import 'package:doclink/doctor/generated/l10n.dart';
import 'package:doclink/doctor/model/doctorProfile/registration/registration.dart';
import 'package:doclink/doctor/service/doctor_pref_service.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DashboardScreenController extends GetxController {
  int currentIndex = 0;
  final inactiveColor = ColorRes.grey;
  DoctorPrefService prefService = DoctorPrefService();

  DoctorData? doctorData;

  @override
  void onInit() {
    prefData();
    super.onInit();
  }

  void onItemSelected(int value) {
    if (doctorData?.status == 2) {
      HapticFeedback.heavyImpact();
      if ([1, 2, 3].any((element) {
        return element == value;
      })) {
        CustomUi.snackBar(
            message: S.current.doctorBlockByAdmin,
            iconData: Icons.dangerous_rounded);
        return;
      }
    }
    currentIndex = value;
    update();
  }

  Future<void> prefData() async {
    await prefService.init();
    doctorData = prefService.getRegistrationData();
    update();
  }
}
