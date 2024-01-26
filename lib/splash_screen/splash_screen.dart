import 'package:doclink/doctor/common/custom_ui.dart';
import 'package:doclink/doctor/common/starting_doctor_top.dart';
import 'package:doclink/doctor/common/text_button_custom.dart';
import 'package:doclink/doctor/generated/l10n.dart';
import 'package:doclink/doctor/service/doctor_pref_service.dart';
import 'package:doclink/doctor/service/local_auth_service.dart';
import 'package:doclink/patient/services/patient_pref_service.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/font_res.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/splash_screen/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _supportedState = false;
  late final LocalAuthentication auth;

  @override
  void initState() {
    auth = LocalAuthentication();
    config();

    super.initState();
  }

  config() async {
    bool isSupported = await LocalAuth.canAuthenticate();
    setState(() {
      _supportedState = isSupported;
    });
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(
      init: SplashScreenController(),
      builder: (controller) {
       return FutureBuilder(
        future: controller.prefData(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const CircularLoader();
          }else{
             return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StartingDoctorTop(),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(
                    S.current.appName,
                    style: const TextStyle(
                        fontFamily: FontRes.black, fontSize: 25),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    S.current.craftYourProfileEtc,
                    style: const TextStyle(
                        fontFamily: FontRes.light,
                        fontSize: 16,
                        color: ColorRes.charcoalGrey),
                  ),
                  const Spacer(),
                  controller.userid != null ?
                  TextButtonCustom(
                    onPressed: controller.navigatePatientRoot,
                    backgroundColor: ColorRes.tuftsBlue.withOpacity(0.2),
                    title: PS.current.continueText,
                    titleColor: ColorRes.tuftsBlue100,
                  ) : controller.doctorid != null ? TextButtonCustom(
                    onPressed: controller.navigateDoctorRoot,
                    backgroundColor: ColorRes.tuftsBlue.withOpacity(0.2),
                    title: S.current.continueText,
                    titleColor: ColorRes.tuftsBlue100,
                  ) : SignupButtons(),
                  const Spacer(),
                ],
              ),
            ),
          )
        ],
      ),
    );
          }
        },
        );
      },
      );
  }
}

class SignupButtons extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final controller = Get.put(SplashScreenController());
    return Container(
      height: 200,
      child: Column(
        children: [
          const Spacer(),
                    TextButtonCustom(
                      onPressed: controller.navigateDoctorRoot,
                      backgroundColor: ColorRes.tuftsBlue.withOpacity(0.2),
                      title: S.current.continueasDoctorText,
                      titleColor: ColorRes.tuftsBlue100,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButtonCustom(
                      onPressed: controller.navigatePatientRoot,
                      backgroundColor: ColorRes.tuftsBlue.withOpacity(0.2),
                      title: PS.current.continueasPatientText,
                      titleColor: ColorRes.tuftsBlue100,
                    ),
                    const Spacer(),
        ],
      ),
    );
  }
}
