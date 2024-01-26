import 'package:doclink/doctor/common/custom_ui.dart';
import 'package:doclink/doctor/common/top_bar_area.dart';
import 'package:doclink/doctor/generated/l10n.dart';
import 'package:doclink/patient/screen/complete_registration_screen/doctor_profile_screen_four/doctor_profile_screen_four_controller.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/font_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PatientTermUse extends StatelessWidget {
  const PatientTermUse({super.key});

  @override
  Widget build(BuildContext context) {
     final controller = Get.put(DoctorProfileScreenFourController());
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.05,
          ),
          child: Column(
            children: [
             Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
        children: [
          TopBarArea(title: S.current.termsOfUse),
          Expanded(
            child: GetBuilder(
              init: DoctorProfileScreenFourController(),
              builder: (controller) {
                return controller.isLoading
                    ? CustomUi.loaderWidget()
                    : WebViewWidget(controller: controller.webController);
              },
            ),
          ),
        ],
      ),
              )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: (){
                      controller.update_is_agreed();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        color: ColorRes.tuftsBlue,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Text(
                          "I have read all terms and conditions",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: FontRes.medium
                          ),          
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}