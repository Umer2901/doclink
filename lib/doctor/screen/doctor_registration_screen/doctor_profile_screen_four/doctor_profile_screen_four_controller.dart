import 'package:doclink/doctor/common/custom_ui.dart';
import 'package:doclink/doctor/screen/registration_successful_screen.dart/registration_successful_screen.dart';
import 'package:doclink/doctor/service/doctor_pref_service.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/const_res.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DoctorProfileScreenFourController extends GetxController{
  WebViewController webController = WebViewController();
  bool isLoading = false;

  @override
  void onInit() {
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(ColorRes.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            isLoading = true;
            update();
          },
          onPageFinished: (String url) {
            isLoading = false;
            update();
          },
        ),
      )
      ..loadRequest(Uri.parse(ConstRes.termsOfUser));
    super.onInit();
  }
  update_is_agreed()async{
    CustomUi.loader();
    DoctorPrefService prefService = DoctorPrefService();
    await prefService.init();
    prefService.saveString(key: "is_agreed_term", value: "1");
    Get.to(()=>RegistrationSuccessfulScreen());
  }
}