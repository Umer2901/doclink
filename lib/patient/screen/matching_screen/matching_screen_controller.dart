import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doclink/doctor/common/custom_ui.dart';
import 'package:doclink/patient/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MatchingScreenController extends GetxController{
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2024),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      update();
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      selectedTime = picked;
      update();
    }
  }

  notifyDoctors(Map<String,dynamic>? requestData)async{
    CustomUi.loader();
    var currentUser = await PatientApiService.instance.fetchMyUserDetails();
    var response = await PatientApiService.instance.findDoctor(requestData?["cat_id"]);
    await FirebaseFirestore.instance.collection("UserRequests").doc(requestData?['id']).delete();
    var pushTokens = response['data'] as List<dynamic>;
    List<String> device_tokens = [];
    if(pushTokens.length > 0){
      for(int i=0; i< pushTokens.length; i++){
      var token = pushTokens[i]['device_token'] ?? '';
      device_tokens.add(token);
    }
    Map<String,dynamic> notidata = {
      "notificationType" : '2',
    };
    var request = await PatientApiService.instance.sendRequest("${currentUser.data?.fullname} needs a doctor on ${selectedTime}, ${selectedDate}", notidata, 'Doctor Needed', device_tokens);
    Get.back();
    Get.back();
    Get.back();
    Get.back();
    Get.back();
  }
}
}