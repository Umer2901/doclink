import 'package:doclink/doctor/model/notification/notification.dart';
import 'package:doclink/doctor/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreenController extends GetxController {
  List<NotificationData>? notifications = [];
  int? start = 0;
  bool isLoading = false;
  ScrollController notificationController = ScrollController();

  @override
  void onInit() {
    notificationApiCall();
    fetchNotificationData();
    super.onInit();
  }

  void notificationApiCall() {
    isLoading = true;
    DoctorApiService.instance.fetchDoctorNotifications(start: start).then((value) {
      if (start == 0) {
        notifications = value.data;
      } else {
        notifications?.addAll(value.data!);
      }
      start = notifications?.length;
      isLoading = false;
      update();
    });
  }

  void fetchNotificationData() {
    notificationController.addListener(
      () {
        if (notificationController.offset ==
            notificationController.position.maxScrollExtent) {
          if (!isLoading) {
            notificationApiCall();
          }
        }
      },
    );
  }
}
