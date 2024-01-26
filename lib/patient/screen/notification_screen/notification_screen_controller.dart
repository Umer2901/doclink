import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:get/get.dart';
import 'package:doclink/patient/model/notification/notification.dart';
import 'package:doclink/patient/services/api_service.dart';

class NotificationScreenController extends GetxController {
  List<NotificationData>? notifications = [];
  bool isLoading = false;
  ScrollController scrollController = ScrollController();
  int start = 0;

  @override
  void onInit() {
    notificationApiCall();
    fetchScrollData();
    super.onInit();
  }

  void notificationApiCall() {
    isLoading = true;
    PatientApiService.instance.fetchNotification(start: start).then((value) {
      if (start == 0) {
        notifications = value.data;
      } else {
        notifications?.addAll(value.data!);
      }
      start += notifications!.length;
      isLoading = false;
      update();
    });
  }

  fetchScrollData() {
    scrollController.addListener(
      () {
        if (scrollController.offset ==
            scrollController.position.maxScrollExtent) {
          if (!isLoading) {
            notificationApiCall();
          }
        }
      },
    );
  }

  @override
  void onClose() {
    FlutterAppBadger.removeBadge();
    super.onClose();
  }
}
