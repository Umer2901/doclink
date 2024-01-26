import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:doclink/patient/common/custom_ui.dart';
import 'package:doclink/patient/model/user/registration.dart';
import 'package:doclink/patient/services/api_service.dart';
import 'package:doclink/patient/services/patient_pref_service.dart';
import 'package:doclink/utils/const_res.dart';

class EditProfileScreenController extends GetxController {
  PatientPrefService prefService = PatientPrefService();
  RegistrationData? userData;
  TextEditingController fullNameController = TextEditingController();
  String? netWorkImage;
  File? imageFile;

  @override
  void onInit() {
    prefData();
    super.onInit();
  }

  void prefData() async {
    await prefService.init();
    userData = prefService.getRegistrationData();
    fullNameController = TextEditingController(text: userData?.fullname ?? '');
    if (userData?.profileImage != null) {
      netWorkImage = userData?.profileImage;
    }
    update();
  }

  void onImageTap() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: ConstRes.imageQuality,
        maxHeight: ConstRes.maxHeight,
        maxWidth: ConstRes.maxWidth);
    if (image != null) {
      imageFile = File(image.path);
      update();
    }
  }

  void onContinueTap() {
    CustomUi.loader();
    PatientApiService.instance
        .updateUserDetails(image: imageFile, name: fullNameController.text)
        .then((value) {
      Get.back();
      if (value.status == true) {
        CustomUi.snackBar(
            iconData: Icons.person, positive: true, message: value.message);
      } else {
        CustomUi.snackBar(iconData: Icons.person, message: value.message);
      }
    });
  }
}
