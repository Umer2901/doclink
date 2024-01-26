import 'package:doclink/doctor/common/custom_ui.dart';
import 'package:doclink/doctor/common/top_bar_area.dart';
import 'package:doclink/doctor/screen/webview_screen/webview_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatelessWidget {
  final String title;

  const WebviewScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WebviewScreenController());
    return Scaffold(
      body: Column(
        children: [
          TopBarArea(title: title),
          Expanded(
            child: GetBuilder(
              init: controller,
              builder: (context) {
                return controller.isLoading
                    ? CustomUi.loaderWidget()
                    : WebViewWidget(controller: controller.webController);
              },
            ),
          ),
        ],
      ),
    );
  }
}
