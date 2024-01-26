import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doclink/patient/common/top_bar_area.dart';
import 'package:doclink/patient/screen/webview_screen/webview_screen_controller.dart';
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
          Expanded(child: WebViewWidget(controller: controller.controller)),
        ],
      ),
    );
  }
}
