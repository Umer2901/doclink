import 'dart:io';

import 'package:doclink/doctor/generated/l10n.dart';
import 'package:doclink/doctor/screen/appointment_chat_screen/appointment_chat_screen_controller.dart';
import 'package:doclink/doctor/screen/message_chat_screen/message_chat_screen_controller.dart';
import 'package:doclink/doctor/screen/request_screen/request_screen.dart';
import 'package:doclink/doctor/service/api_service.dart';
import 'package:doclink/doctor/service/doctor_pref_service.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/patient/services/api_service.dart';
import 'package:doclink/utils/const_res.dart';
import 'package:doclink/utils/update_res.dart';
import 'package:doclink/patient/services/patient_pref_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class MyAppController extends GetxController {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  DoctorPrefService prefService = DoctorPrefService();
  int notificationCount = 0;
  String languageCode = Platform.localeName.split('_')[0];
   DoctorPrefService docprefservice = DoctorPrefService();
    PatientPrefService patprefservice = PatientPrefService();
  @override
  void onInit()async{
    await docprefservice.init();
    await patprefservice.init();
    if(docprefservice.getString(key: "role") == 'doctor' && docprefservice.getString(key: "role") != null){
      fetchSettingData();
    }
    if(patprefservice.getString(key: "role") == 'patient' && patprefservice.getString(key: "role") != null){
      fetchpatSettingData();
    }
    FlutterAppBadger.removeBadge();
    saveTokenUpdate();
    super.onInit();
  }

  void fetchSettingData() {
    DoctorApiService.instance.fetchGlobalSettings().then((value) {
      dollar = value.data?.currency == null || value.data!.currency!.isEmpty
          ? '\$'
          : (value.data?.currency ?? '\$');
    });
  }

   void fetchpatSettingData() {
    PatientApiService.instance.fetchGlobalSettings().then((value) {
      dollar = value.data?.currency ?? '\$';
    });
  }
  void saveTokenUpdate() async {
     await docprefservice.init();
    await patprefservice.init();
    if(docprefservice.getString(key: "role") == 'doctor' && docprefservice.getString(key: "role") != null){
      await firebaseMessaging.subscribeToTopic('doctor');
          flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions();

    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    AndroidNotificationChannel channel = AndroidNotificationChannel(
      androidChannelId, // id
      S.current.doctor, // title
      playSound: true,
      enableLights: true,
      enableVibration: true,
      importance: Importance.max,
    );

    /// Required to display a heads up notification (For iOS)
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        if (notificationCount % 2 == 0 && Platform.isIOS) {
          return;
        }
        const AndroidInitializationSettings initializationSettingsAndroid =
            AndroidInitializationSettings('@mipmap/ic_launcher');
        const DarwinInitializationSettings initializationSettingsIOS =
            DarwinInitializationSettings();

        const InitializationSettings initializationSettings =
            InitializationSettings(
                android: initializationSettingsAndroid,
                iOS: initializationSettingsIOS);

        flutterLocalNotificationsPlugin.initialize(initializationSettings);
        RemoteNotification? notification = message.notification;
        if (message.data[nNotificationType] == '0') {
          if (message.data[senderId] != MessageChatScreenController.senderId) {
            showNotification(channel: channel, notification: notification);
          }
        }
        if (message.data[nNotificationType] == '1') {
          if (message.data[nAppointmentId] !=
              AppointmentChatScreenController.appointmentId) {
            showNotification(channel: channel, notification: notification);
          }
        }
        notificationCount++;
      },
    );

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    }
    if(patprefservice.getString(key: "role") == 'patient' && patprefservice.getString(key: "role") != null){
      await firebaseMessaging.subscribeToTopic('patient');
         flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions();
    // await firebaseMessaging.requestPermission(
    //   alert: true,
    //   announcement: false,
    //   badge: true,
    //   carPlay: false,
    //   criticalAlert: false,
    //   provisional: false,
    //   sound: true,
    // );

    AndroidNotificationChannel channel = AndroidNotificationChannel(
      androidChannelId, // id
      PS.current.patient, // title
      playSound: true,
      description: PS.current.patient,
      enableLights: true,
      enableVibration: true,
      importance: Importance.high,
    );

    /// Required to display a heads up notification (For iOS)
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // Handle the tap event when the app is in the foreground
    if(message.data['notificationType'] == 2){
      Get.to(()=>RequestScreen());
    }
    // Navigate to the appropriate screen based on the message data
  });
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        if (notificationCount & 2 == 0) {
          return;
        }
        const AndroidInitializationSettings initializationSettingsAndroid =
            AndroidInitializationSettings('@mipmap/ic_launcher');
        const DarwinInitializationSettings initializationSettingsIOS =
            DarwinInitializationSettings();

        const InitializationSettings initializationSettings =
            InitializationSettings(
                android: initializationSettingsAndroid,
                iOS: initializationSettingsIOS);

        flutterLocalNotificationsPlugin.initialize(initializationSettings);
        RemoteNotification? notification = message.notification;
        if (message.data[nNotificationType] == '0') {
          if (message.data[senderId] != MessageChatScreenController.senderId) {
            if (Platform.isIOS && notificationCount % 2 == 0) {
              showNotification(channel: channel, notification: notification);
            } else {
              showNotification(channel: channel, notification: notification);
            }
          }
        }
        notificationCount++;
        if (message.data[nNotificationType] == '1') {
          if (message.data[nAppointmentId] !=
              AppointmentChatScreenController.appointmentId) {
            showNotification(channel: channel, notification: notification);
          }
        }
        if (message.data[nNotificationType] == '2') {
          showNotification(channel: channel, notification: notification);
        }
      },
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    }
  }

  void showNotification(
      {RemoteNotification? notification,
      required AndroidNotificationChannel channel}) {
    flutterLocalNotificationsPlugin.show(
      1,
      notification?.title,
      notification?.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
        ),
        iOS: const DarwinNotificationDetails(
          presentSound: true,
          presentAlert: true,
          presentBadge: true,
        ),
      ),
    );
  }
}
