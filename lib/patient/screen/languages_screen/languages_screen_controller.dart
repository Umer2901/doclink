import 'dart:io';

import 'package:get/get.dart';
import 'package:doclink/main.dart';
import 'package:doclink/patient/services/patient_pref_service.dart';
import 'package:doclink/utils/update_res.dart';

class LanguagesScreenController extends GetxController {
  int? value = 0;
  List<String> languages = [
    'عربي',
    'dansk',
    'Nederlands',
    'English',
    'Français',
    'Deutsch',
    'Ελληνικά',
    'हिंदी',
    'bahasa Indonesia',
    'Italiano',
    '日本',
    '한국인',
    'Norsk Bokmal',
    'Polski',
    'Português',
    'Русский',
    '简体中文',
    'Español',
    'แบบไทย',
    'Türkçe',
    'Tiếng Việt',
  ];
  List<String> subLanguage = [
    'Arabic',
    'Danish',
    'Dutch',
    'English',
    'French',
    'German',
    'Greek',
    'Hindi',
    'Indonesian',
    'Italian',
    'Japanese',
    'Korean',
    'Norwegian Bokmal',
    'Polish',
    'Portuguese',
    'Russian',
    'Simplified Chinese',
    'Spanish',
    'Thai',
    'Turkish',
    'Vietnamese',
  ];
  List languageCode = [
    'ar',
    'da',
    'nl',
    'en',
    'fr',
    'de',
    'el',
    'hi',
    'id',
    'it',
    'ja',
    'ko',
    'nb',
    'pl',
    'pt',
    'ru',
    'zh',
    'es',
    'th',
    'tr',
    'vi',
  ];

  static String selectedLanguage = Platform.localeName.split('_')[0];
  PatientPrefService prefService = PatientPrefService();

  @override
  void onInit() {
    prefData();
    super.onInit();
  }

  void onLanguageChange(int? value) async {
    this.value = value;
    await prefService.saveString(
        key: kLanguage, value: languageCode[value ?? 0]);
    selectedLanguage = languageCode[value ?? 0];
    RestartWidget.restartApp(Get.context!);
    update();
  }

  void prefData() async {
    await prefService.init();
    selectedLanguage = prefService.getString(key: kLanguage) ??
        Platform.localeName.split('_')[0];
    value = languageCode.indexOf(selectedLanguage);
    update();
  }
}
