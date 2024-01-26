import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doclink/patient/common/custom_ui.dart';
import 'package:doclink/patient/model/user/registration.dart';
import 'package:doclink/patient/screen/edit_profile_screen/edit_profile_screen.dart';
import 'package:doclink/splash_screen/splash_screen.dart';
import 'package:doclink/patient/services/api_service.dart';
import 'package:doclink/patient/services/patient_pref_service.dart';
import 'package:doclink/utils/extention.dart';
import 'package:doclink/utils/firebase_res.dart';
import 'package:doclink/utils/update_res.dart';

class ProfileScreenController extends GetxController {
  bool isNotification = false;
  PatientPrefService prefService = PatientPrefService();
  RegistrationData? userData;

  @override
  void onInit() {
    fetchPatientApiCall();
    prefData();
    super.onInit();
  }

  void onNotificationTap() {
    CustomUi.loader();
    PatientApiService.instance
        .updateUserDetails(isNotification: isNotification ? 0 : 1)
        .then((value) {
      isNotification = value.data?.isNotification == 1;
      Get.back();
      update([kNotificationUpdate]);
    });
  }

  void prefData() async {
    await prefService.init();
    userData = prefService.getRegistrationData();
    isNotification = userData?.isNotification == 1;
    update([kProfileUpdate, kNotificationUpdate]);
  }

  void onEditProfileNavigate() {
    Get.to(() => const EditProfileScreen())?.then((value) {
      userData = prefService.getRegistrationData();
      update([kProfileUpdate]);
    });
  }

  void onLogoutTap() {
    CustomUi.loader();
    PatientApiService.instance.logOut().then((value) async {
      if (value.status == true) {
        await prefService.preferences?.clear();
        PatientPrefService.userId = null;
        PatientPrefService.identity = null;
        CustomUi.snackBar(
            iconData: Icons.logout_rounded,
            message: value.message,
            positive: true);
        Get.offAll(() => const SplashScreen());
      } else {
        CustomUi.snackBar(
            iconData: Icons.logout_rounded, message: value.message);
      }
    });
  }

  void fetchPatientApiCall() {
    PatientApiService.instance.fetchPatient();
  }

  void onDeleteContinueTap() {
    CustomUi.loader();
    PatientApiService.instance.deleteUserAccount().then((value) async {
      if (value.status == true) {
        await deleteFirebaseUser();
        await prefService.preferences?.clear();
        PatientPrefService.userId = null;
        PatientPrefService.identity = null;
        Get.back();
        CustomUi.snackBar(
            message: value.message ?? '',
            iconData: Icons.delete_rounded,
            positive: true);
        Get.offAll(() => const SplashScreen());
      } else {
        Get.back();
        CustomUi.snackBar(
            message: value.message ?? '', iconData: Icons.delete_rounded);
      }
    });
  }

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> deleteFirebaseUser() async {
    String userIdentity =
        '${FirebaseRes.pt}${'${userData?.identity}'.removeUnUsed}';
    String time = DateTime.now().millisecondsSinceEpoch.toString();
    await db
        .collection(FirebaseRes.userChatList)
        .doc(userIdentity)
        .collection(FirebaseRes.userList)
        .get()
        .then((value) {
      for (var element in value.docs) {
        db
            .collection(FirebaseRes.userChatList)
            .doc(element.id)
            .collection(FirebaseRes.userList)
            .doc(userIdentity)
            .update({
          FirebaseRes.isDeleted: true,
          FirebaseRes.deletedId: time,
        });
        db
            .collection(FirebaseRes.userChatList)
            .doc(userIdentity)
            .collection(FirebaseRes.userList)
            .doc(element.id)
            .update({
          FirebaseRes.isDeleted: true,
          FirebaseRes.deletedId: time,
        });
      }
    });
  }
}
