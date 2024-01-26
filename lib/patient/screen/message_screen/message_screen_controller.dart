import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:doclink/patient/common/confirmation_dialog.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/patient/model/chat/chat.dart';
import 'package:doclink/patient/model/user/registration.dart';
import 'package:doclink/patient/services/patient_pref_service.dart';
import 'package:doclink/utils/extention.dart';
import 'package:doclink/utils/firebase_res.dart';

class MessageScreenController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Conversation?> userList = [];
  bool isLoading = false;
  StreamSubscription<QuerySnapshot<Conversation>>? subscription;
  PatientPrefService prefService = PatientPrefService();
  RegistrationData? userData;
  String firebaseUserIdentity = '';

  @override
  void onInit() {
    getChatUsers();
    super.onInit();
  }

  void getChatUsers() async {
    await prefService.init();
    userData = prefService.getRegistrationData();
    firebaseUserIdentity =
        '${FirebaseRes.pt}${'${userData?.identity}'.removeUnUsed}';
    isLoading = true;
    subscription = db
        .collection(FirebaseRes.userChatList)
        .doc(firebaseUserIdentity)
        .collection(FirebaseRes.userList)
        .orderBy(FirebaseRes.time, descending: true)
        .where(FirebaseRes.isDeleted, isEqualTo: false)
        .withConverter(
            fromFirestore: Conversation.fromFirestore,
            toFirestore: (Conversation value, options) => value.toFirestore())
        .snapshots()
        .listen((element) {
      userList = [];
      for (int i = 0; i < element.docs.length; i++) {
        userList.add(element.docs[i].data());
      }
      isLoading = false;
      update();
    });
  }

  void onLongPress(Conversation? conversation) {
    HapticFeedback.vibrate();
    Get.dialog(
      ConfirmationDialog(
        aspectRatio: 1 / 0.6,
        positiveText: PS.current.deleteChat,
        title: PS.current.messageWillOnlyBeRemovedEtc,
        onPositiveBtn: () {
          Get.back();
          db
              .collection(FirebaseRes.userChatList)
              .doc(firebaseUserIdentity)
              .collection(FirebaseRes.userList)
              .doc(conversation?.user?.userIdentity)
              .update({
            FirebaseRes.isDeleted: true,
            FirebaseRes.deletedId: '${DateTime.now().millisecondsSinceEpoch}',
          });
        },
      ),
    );
    update();
  }

  @override
  void onClose() {
    subscription?.cancel();
    super.onClose();
  }
}
