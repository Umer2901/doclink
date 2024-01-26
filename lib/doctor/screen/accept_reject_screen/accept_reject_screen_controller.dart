import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doclink/doctor/common/custom_ui.dart';
import 'package:doclink/doctor/generated/l10n.dart';
import 'package:doclink/doctor/model/appointment/appointment_request.dart';
import 'package:doclink/doctor/model/custom/order_summary.dart';
import 'package:doclink/doctor/screen/accept_reject_screen/widget/mark_complete_sheet.dart';
import 'package:doclink/doctor/screen/appointment_chat_screen/appointment_chat_screen.dart';
import 'package:doclink/doctor/screen/dashboard_screen/dashboard_screen.dart';
import 'package:doclink/doctor/screen/medical_prescription_screen/medical_prescription_screen.dart';
import 'package:doclink/doctor/screen/message_chat_screen/widget/message_chat_top_bar.dart';
import 'package:doclink/doctor/screen/previous_appointment_screen/previous_appointment_screen.dart';
import 'package:doclink/doctor/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AcceptRejectScreenController extends GetxController {
  TextEditingController diagnosedController = TextEditingController();
  TextEditingController completionOtpController = TextEditingController();
  bool isLoading = false;
  bool isDiagnosed = false;
  bool isCompletionOtp = false;
  AppointmentData? appointmentData;
  bool isExpanded = false;
  OrderSummary? orderSummary;

  @override
  void onInit() {
    fetchAppointmentDetailsApiCall();
    super.onInit();
  }

  void onExpandTap(bool value) {
    isExpanded = value;
    update();
  }

  void onAcceptBtnTap(AppointmentData? data) {
    CustomUi.loader();
    DoctorApiService.instance
        .acceptAppointment(appointmentId: data?.id, doctorId: data?.doctorId)
        .then((value) {
      Get.back();
      if (value.status == true) {
        fetchAppointmentDetailsApiCall();
        CustomUi.snackBar(
            iconData: Icons.done_outline,
            message: value.message,
            positive: true);
      } else {
        CustomUi.snackBar(iconData: Icons.done_outline, message: value.message);
      }
    });
  }

  void fetchAppointmentDetailsApiCall() {
    if (Get.arguments is AppointmentData) {
      appointmentData = Get.arguments;
    }

    isLoading = true;
    DoctorApiService.instance
        .fetchAppointmentDetails(appointmentId: appointmentData?.id)
        .then((value) {
      appointmentData = value.data;
      isLoading = false;
      update();
    });
  }
  void onDeclineBtnTap(AppointmentData? data) {
    Get.dialog(
      ConfirmationDialog(
        onPositiveBtn: () {
          Get.back();
          CustomUi.loader();
          DoctorApiService.instance
              .declineAppointment(
                  appointmentId: data?.id, doctorId: data?.doctorId)
              .then((value) {
            Get.back();
            Get.back();
            if (value.status == true) {
              CustomUi.snackBar(
                  iconData: Icons.done_outline,
                  positive: true,
                  message: value.message);
            } else {
              CustomUi.snackBar(
                  iconData: Icons.done_outline, message: value.message);
            }
          });
        },
        title: S.current.areYouSure,
        title2: S.current.doYouWantToDeleteThisAppointment,
        positiveText: S.current.delete,
        aspectRatio: 1 / 0.65,
      ),
    );
  }
  void onMedicalPrescriptionTap() {
    Get.to(() => MedicalPrescriptionScreen(), arguments: appointmentData)
        ?.then((value) {
      fetchAppointmentDetailsApiCall();
    });
  }

  onMarkCompleteTap(AcceptRejectScreenController controller, bool? isVideoCall) {
    Get.bottomSheet(
            MarkCompleteSheet( controller: controller, isVideoCall: isVideoCall,),
            isScrollControlled: true)
        .then((value) {
      diagnosedController.text = '';
      completionOtpController.text = '';
      isDiagnosed = false;
      isCompletionOtp = false;
      fetchAppointmentDetailsApiCall();
    });
  }

  void completeAppointmentApiCall(bool? isVideoCall) {
    isDiagnosed = false;
    isCompletionOtp = false;
    update();
    if (diagnosedController.text.isEmpty) {
      isDiagnosed = true;
      return;
    }
    if(isVideoCall == null){
      if (completionOtpController.text.isEmpty) {
      isCompletionOtp = true;
      return;
    }
    }
    if(isVideoCall != null && isVideoCall == true){
      print(true);
     DoctorApiService.instance
        .completeAppointment(
            appointmentId: appointmentData?.id,
            doctorId: appointmentData?.doctorId,
            otp: appointmentData!.completionOtp.toString(),
            diagnoseWith: diagnosedController.text)
        .then(
      (value) {
        Get.to(()=>DashboardScreen());
        if (value.status == true) {
          CustomUi.snackBar(
              iconData: Icons.done_outline_outlined,
              message: value.message,
              positive: true);
        } else {
          CustomUi.snackBar(
              iconData: Icons.done_outline_outlined, message: value.message);
        }
      },); 
    }else{
      print(false);
      DoctorApiService.instance
        .completeAppointment(
            appointmentId: appointmentData?.id,
            doctorId: appointmentData?.doctorId,
            otp: completionOtpController.text,
            diagnoseWith: diagnosedController.text)
        .then(
      (value) {
        Get.back();
        if (value.status == true) {
          CustomUi.snackBar(
              iconData: Icons.done_outline_outlined,
              message: value.message,
              positive: true);
        } else {
          CustomUi.snackBar(
              iconData: Icons.done_outline_outlined, message: value.message);
        }
      },);
    }
  }

  void onPreviousAppointmentTap() {
    Get.to(
      () => PreviousAppointmentScreen(
        appointmentData: appointmentData,
      ),
    );
  }

  void onMessageBtnTap() {
    Get.to(() => const AppointmentChatScreen(), arguments: appointmentData);
  }
}
