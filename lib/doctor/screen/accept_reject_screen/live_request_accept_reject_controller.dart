import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doclink/doctor/common/custom_ui.dart';
import 'package:doclink/doctor/model/user/fetch_user_detail.dart';
import 'package:doclink/doctor/screen/matching_screen/matching_screen.dart';
import 'package:doclink/doctor/screen/request_screen/request_screen.dart';
import 'package:doclink/doctor/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LiveRequestController extends GetxController{
  bool isLoading = false;
  // void onRequestDeclineBtnTap(String documentId, List<dynamic> declinedBy)async{
  //   CustomUi.loader();
  //   var data = await DoctorApiService.instance.fetchMyDoctorProfile();
  //   declinedBy.add(data.data?.id);
  //   await FirebaseFirestore.instance.collection('UserRequests').doc(documentId).update({'declinedBy': {'doctorId': 'yourDoctorId'}});
  //   CustomUi.snackBar(
  //                 iconData: Icons.done_outline,
  //                 positive: true,
  //                 message: "Request Declined Successfully.");
  //   Get.to(()=>RequestScreen());
  // }

  void onRequestDeclineBtnTap(String documentId, Map<String,dynamic> declinedBy) async {
  try {
    CustomUi.loader();

    // Fetch the current doctor's profile
    var data = await DoctorApiService.instance.fetchMyDoctorProfile();
    int? currentDoctorId = data.data?.id;

    // Check if the declinedBy list is null or empty
    if (declinedBy == null) {
      declinedBy = {};
    }

    // Add the current doctor's ID to the declinedBy list
    declinedBy.addAll({currentDoctorId.toString() : true});

    // Update the document in Firebase
    await FirebaseFirestore.instance
        .collection('UserRequests')
        .doc(documentId)
        .update({'declinedBy': declinedBy});

    CustomUi.snackBar(
      iconData: Icons.done_outline,
      positive: true,
      message: "Request Declined Successfully.",
    );

    // Navigate to the RequestScreen
    Get.to(() => RequestScreen());
  } catch (error) {
    print("Error in onRequestDeclineBtnTap: $error");
    // Handle error as needed
  }
}
  void onRequestAcceptBtnTap(String documentId, Map<String,dynamic>? requestData, User? user)async{
    CustomUi.loader();
    var data = await DoctorApiService.instance.fetchMyDoctorProfile();
    await FirebaseFirestore.instance.collection('UserRequests').doc(documentId).update({
      "acceptedBy" : data.data?.toJson(),
    });
    CustomUi.snackBar(
                  iconData: Icons.done_outline,
                  positive: true,
                  message: "Request Accepted Successfully.");
   Get.to(()=>DoctorWaitingScreen(
    documentId: documentId,
   ));
  }
}