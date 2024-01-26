
import 'package:doclink/utils/color_res.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreenController extends GetxController {
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
      ..loadRequest(Uri.parse(Get.arguments));
    super.onInit();
  }
}
