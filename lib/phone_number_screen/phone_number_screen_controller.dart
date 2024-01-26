import 'dart:developer';

import 'package:doclink/doctor/common/custom_ui.dart';
import 'package:doclink/doctor/generated/l10n.dart';
import 'package:doclink/phone_verification_screen/phone_verification_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberScreenController extends GetxController {
  FocusNode phoneFocusNode = FocusNode();
  PhoneNumber? phoneNumber;

  Future<void> verifyPhoneNumber() async {
    if (phoneNumber?.phoneNumber == null) {
      CustomUi.snackBar(
          message: S.current.pleaseEnterMobileNumber,
          iconData: Icons.phone_enabled_rounded);
      return;
    }
    CustomUi.loader();
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber!.phoneNumber,
        timeout: const Duration(seconds: 120),
        verificationCompleted: (AuthCredential authCredential) {
          Get.back();
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            Get.back();
            CustomUi.snackBar(
                message: S.current.theProvidedPhoneEtc,
                iconData: Icons.not_interested_rounded);
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          //Get.back();
          Get.to(() => const PhoneVerificationScreen(),
              arguments: [phoneNumber, verificationId]);
        },
        codeAutoRetrievalTimeout: (String verId) {
          Get.back();
        },
      );
      print(phoneNumber!.phoneNumber);
    } catch (e) {
      Get.back();
      log(e.toString());
    }
  }
}
