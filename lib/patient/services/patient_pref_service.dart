import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/patient/model/chat/chat.dart';
import 'package:doclink/patient/model/custom/countries.dart';
import 'package:doclink/patient/model/global/global_setting.dart';
import 'package:doclink/patient/model/user/registration.dart';
import 'package:doclink/utils/extention.dart';
import 'package:doclink/utils/firebase_res.dart';
import 'package:doclink/utils/update_res.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientPrefService {
  SharedPreferences? preferences;
  static int? userId;
  static String? identity;

  Future init() async {
    preferences = await SharedPreferences.getInstance();
    return preferences;
  }

  Future<void> saveString({required String key, required String value}) async {
    await preferences?.setString(key, value);
    userId = getRegistrationData()?.id;
    log('👉 $userId 👈');
    identity = getRegistrationData()?.identity;
  }

  Future<void> saveList(
      {required String key, required List<String> value}) async {
    await preferences?.setStringList(key, value);
  }

  String? getString({required String key}) {
    return preferences?.getString(key);
  }

  Future<void> setLogin({required String key, required bool value}) async {
    await preferences?.setBool(key, value);
  }

  Future<bool?> getBool({required String key}) async {
    preferences = await SharedPreferences.getInstance();
    return preferences?.getBool(key);
  }

  RegistrationData? getRegistrationData() {
    if (getString(key: kRegistrationUser) == null) return null;
    print(jsonDecode(getString(key: kRegistrationUser)!));
    return RegistrationData.fromJson(
        jsonDecode(getString(key: kRegistrationUser)!));
  }

  GlobalSettingData? getSettings() {
    if (getString(key: kGlobalSetting) == null) return null;
    return GlobalSettingData.fromJson(
      jsonDecode(getString(key: kGlobalSetting)!),
    );
  }

  Countries? getCountries() {
    if (getString(key: kCountries) == null) return null;
    return Countries.fromJson(jsonDecode(getString(key: kCountries)!));
  }

  void updateFirebaseProfile() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    RegistrationData? userData = getRegistrationData();
    String userIdentity =
        '${FirebaseRes.pt}${'${userData?.identity}'.removeUnUsed}';
    db
        .collection(FirebaseRes.userChatList)
        .doc(userIdentity)
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
            .doc(userIdentity)
            .withConverter(
              fromFirestore: Conversation.fromFirestore,
              toFirestore: (Conversation value, options) {
                return value.toFirestore();
              },
            )
            .get()
            .then((value) {
          ChatUser? user = value.data()?.user;
          user?.username = userData?.fullname ?? PS.current.unKnown;
          user?.image = userData?.profileImage;
          user?.userid = userData?.id;
          db
              .collection(FirebaseRes.userChatList)
              .doc(element.data().user?.userIdentity)
              .collection(FirebaseRes.userList)
              .doc(userIdentity)
              .update({FirebaseRes.user: user?.toJson()});
        });
      }
    });
  }
}
