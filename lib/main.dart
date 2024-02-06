import 'dart:io';
import 'package:device_preview/device_preview.dart';
import 'package:doclink/doctor/screen/languages_screen/languages_screen_controller.dart';
import 'package:doclink/doctor/service/doctor_pref_service.dart';
import 'package:doclink/firebase_options.dart';
import 'package:doclink/my_app/my_app.dart';
import 'package:doclink/patient/services/patient_pref_service.dart';
import 'package:doclink/utils/update_res.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timezone/data/latest.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  HttpOverrides.global = MyHttpOverrides();
  initializeTimeZones();
  DoctorPrefService prefService = DoctorPrefService();
  await prefService.init();
  PatientPrefService patprefservice = PatientPrefService();
  await patprefservice.init();
  if(prefService.getString(key: 'role') != null && prefService.getString(key: 'role') == 'doctor'){
    LanguagesScreenController.selectedLanguage =
      prefService.getString(key: 'languageCode') ??
          Platform.localeName.split('_')[0];
  }
  if(prefService.getString(key: 'role') != null && prefService.getString(key: 'role') == 'patient'){
    LanguagesScreenController.selectedLanguage =
      prefService.getString(key: kLanguage) ??
          Platform.localeName.split('_')[0];
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) {
    runApp(
      DevicePreview(builder: (context)=> const RestartWidget(
        child: MyApp(),
      ),
      enabled: !kReleaseMode
      )
    );
  });
}

class RestartWidget extends StatefulWidget {
  const RestartWidget({super.key, required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  State<RestartWidget> createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
