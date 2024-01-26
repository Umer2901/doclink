class ConstRes {
  ///------------------------ Backend urls and key ------------------------///

  static const String base = 'https://www.doclinkapp.net/';
  static const String baseURL = '${base}api/';
  static const String userbaseURL = '${base}api/user/';
  static const String itemBaseURL = '${base}storage/';
  static const String privacyPolicy = '${base}privacypolicy';
  static const String termsOfUser = '${base}termsOfUse';

  static const String apiKey = '123';

  ///------------------------ Firebase FCM token And Token Id ------------------------///

  static const String authorisationKey =
      "AAAAyFyH8dc:APA91bHwHGO-vTsvNb_nFpsd68pJE6sRtlMdzSfJG6YuhX1R4W-gu8fVJqAdBmbil8AJZVEShes-WzPGLt5i2XiQlxv7vaO-qpnQF5fL_vp0PV3FYfIJkwxDEN1rd4QdcJ4qoMaIcIoF";
  static const String subscribeTopic = 'doctor';

  ///------------------------ Agora app Id ------------------------///

  static const String agoraAppId =
      "95a4e53e72054ac284e91976e63cc703";

  ///------------------------ Image quality ------------------------///
  static const int imageQuality = 40;
  static const double maxWidth = 720;
  static const double maxHeight = 720;
}
