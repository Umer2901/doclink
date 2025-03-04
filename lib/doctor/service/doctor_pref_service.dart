import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doclink/doctor/generated/l10n.dart';
import 'package:doclink/doctor/model/chat/chat.dart';
import 'package:doclink/doctor/model/countries/countries.dart';
import 'package:doclink/doctor/model/doctorProfile/registration/registration.dart';
import 'package:doclink/doctor/model/global/global_setting.dart';
import 'package:doclink/utils/extention.dart';
import 'package:doclink/utils/firebase_res.dart';
import 'package:doclink/utils/update_res.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorPrefService {
  SharedPreferences? preferences;
  static int? id;

  Future init() async {
    preferences = await SharedPreferences.getInstance();
    return preferences;
  }

  Future<void> saveString({required String key, required String value}) async {
    await preferences?.setString(key, value);
    id = getRegistrationData()?.id;
    log('👉 $id 👈');
  }

  String? getString({required String key}) {
    return preferences?.getString(key);
  }

  Future<void> setLogin({required String key, required bool value}) async {
    await preferences?.setBool(key, value);
  }

  bool getLogin({required String key}) {
    return preferences?.getBool(key) ?? false;
  }

  DoctorData? getRegistrationData() {
    if (getString(key: kRegistrationUser) == null) return null;
    return DoctorData.fromJson(jsonDecode(getString(key: kRegistrationUser)!));
  }

  GlobalSettingData? getSettingData() {
    if (getString(key: kGlobalSetting) == null) return null;
    return GlobalSettingData.fromJson(
        jsonDecode(getString(key: kGlobalSetting)!));
  }

  Countries? getCountries() {
    if (getString(key: kCountries) == null) return null;
    return Countries.fromJson(jsonDecode(getString(key: kCountries)!));
  }

  void updateFirebaseProfile() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    DoctorData? userData = getRegistrationData();
    String doctorIdentity =
        '${FirebaseRes.dr}${'${userData?.mobileNumber}'.removeUnUsed}';
    db
        .collection(FirebaseRes.userChatList)
        .doc(doctorIdentity)
        .collection(FirebaseRes.userList)
        .withConverter(
          fromFirestore: Conversation.fromFirestore,
          toFirestore: (Conversation value, options) {
            return value.toFirestore();
          },
        )
        .get()
        .then((value) {
      for (var element in value.docs) {
        db
            .collection(FirebaseRes.userChatList)
            .doc(element.data().user?.userIdentity)
            .collection(FirebaseRes.userList)
            .doc(doctorIdentity)
            .withConverter(
              fromFirestore: Conversation.fromFirestore,
              toFirestore: (Conversation value, options) {
                return value.toFirestore();
              },
            )
            .get()
            .then((value) {
          ChatUser? user = value.data()?.user;
          user?.username = userData?.name ?? S.current.unKnown;
          user?.image = userData?.image;
          user?.designation = userData?.designation;
          user?.userid = userData?.id;
          db
              .collection(FirebaseRes.userChatList)
              .doc(element.data().user?.userIdentity)
              .collection(FirebaseRes.userList)
              .doc(doctorIdentity)
              .update({FirebaseRes.user: user?.toJson()});
        });
      }
    });
  }
}
