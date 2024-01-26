import 'package:doclink/patient/common/custom_ui.dart';
import 'package:doclink/patient/screen/complete_registration_screen/doctor_profile_screen_four/doctor_profile_screen_four.dart';
import 'package:doclink/patient/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicalHistoryController extends GetxController{
  void onSubmitbtn(Map<String,dynamic> medical_history)async{
    PatientApiService.instance
        .updateUserDetails(
          medical_history: medical_history
           )
        .then(
      (value) {
        if (value.status == true) {
          Get.back();
          CustomUi.snackBar(
              message: value.message ?? '',
              iconData: Icons.person,
              positive: true);
          Get.offAll(() => PatientTermUse());
        } else {
          Get.back();
          CustomUi.snackBar(
              message: value.message ?? '', iconData: Icons.person);
        }
      },
    );
  }
}