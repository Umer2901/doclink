import 'package:doclink/doctor/common/custom_ui.dart';
import 'package:doclink/doctor/model/appointment/appointment_request.dart';
import 'package:doclink/doctor/model/doctorProfile/registration/registration.dart';
import 'package:doclink/doctor/model/user/fetch_user_detail.dart';
import 'package:doclink/doctor/screen/accept_reject_screen/accept_reject_screen.dart';
import 'package:doclink/doctor/screen/accept_reject_screen/live_request_accept_reject.dart';
import 'package:doclink/doctor/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestScreenController extends GetxController {
  int? start = 0;
  bool isLoading = false;
  ScrollController requestController = ScrollController();

  List<AppointmentData> appointment = [];

  @override
  void onInit()async{
    fetchAppointmentRequestApiCall();
    scrollToFetchData();
    await getMydDcotorData();
    super.onInit();
  }
  DoctorData? currentDoctor;
  Future<void> getMydDcotorData()async{
    var data = await DoctorApiService.instance.fetchMyDoctorProfile();
    currentDoctor = data.data;
    update();
  }
  void fetchAppointmentRequestApiCall() {
    isLoading = true;
    DoctorApiService.instance.fetchAppointmentRequests(start: start).then((value) {
      if (start == 0) {
        appointment = value.data ?? [];
      } else {
        appointment.addAll(value.data!);
      }
      start = appointment.length;
      isLoading = false;
      update();
    });
  }

  void scrollToFetchData() {
    if (requestController.hasClients) {
      requestController.addListener(
        () {
          if (requestController.offset ==
              requestController.position.maxScrollExtent) {
            if (!isLoading) {
              fetchAppointmentRequestApiCall();
            }
          }
        },
      );
    }
  }

  void onViewTap(AppointmentData? data) {
    Get.to(() => AcceptRejectScreen(), arguments: data)?.then((value) {
      start = 0;
      fetchAppointmentRequestApiCall();
    });
  }
  void ViewRequest(User? user, Map<String,dynamic>? requestdata){
    Get.to(()=>LiveRequestAcceptRejectScreen(user: user, requestData: requestdata,));
  }
  bool isvisible = false;
  updateVisibility(bool isVisible){
    isvisible = isVisible;
    update();
  }
}
