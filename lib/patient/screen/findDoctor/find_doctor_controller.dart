import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doclink/doctor/common/custom_ui.dart';
import 'package:doclink/patient/screen/matching_screen/matching_screen.dart';
import 'package:doclink/patient/services/api_service.dart';
import 'package:doclink/patient/services/patient_pref_service.dart';
import 'package:get/get.dart';

class FindDoctorController extends GetxController{
  List<dynamic>? patient_symptoms;
  Future<void> finddoctor(int? cat_id)async{
    CustomUi.loader();
    var currentUser = await PatientApiService.instance.fetchMyUserDetails();
    var documentId = '${DateTime.now().millisecondsSinceEpoch}';
    var token = await PatientApiService.instance.getAgoraToken(channelName: 'request_${documentId}');
    Map<String, dynamic> data = {
      'id' : documentId,
      'sentBy' : currentUser.toJson(),
      'acceptedBy' : null,
      'declinedBy' : {},
      "isvalid" : true,
      'patient_symptoms' : patient_symptoms ?? [],
      'token' : token.token,
      'channelId' : 'request_${documentId}',
      'cat_id' : cat_id,
    };
    await FirebaseFirestore.instance.collection('UserRequests').doc(documentId).set(data);
    var response = await PatientApiService.instance.findDoctor(cat_id);
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
    var request = await PatientApiService.instance.sendRequest("${currentUser.data?.fullname} needs a doctor", notidata, 'Doctor Needed', device_tokens);
    print(request);
    Get.to(()=>MatchingScreen(documentId: documentId,));
    }
  }
}