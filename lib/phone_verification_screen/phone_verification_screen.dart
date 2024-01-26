import 'package:doclink/doctor/common/text_button_custom.dart';
import 'package:doclink/doctor/common/top_bar_area.dart';
import 'package:doclink/doctor/generated/l10n.dart';
import 'package:doclink/phone_verification_screen/phone_verification_screen_controller.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/font_res.dart';
import 'package:doclink/utils/update_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneVerificationScreen extends StatelessWidget {
  const PhoneVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PhoneVerificationScreenController controller =
        Get.put(PhoneVerificationScreenController());
    return Scaffold(
      body: Column(
        children: [
          TopBarArea(title: S.current.phoneVerification),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      S.current.weHaveSentOtpEtc,
                      style: const TextStyle(
                          fontSize: 16, color: ColorRes.battleshipGrey),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    GetBuilder(
                      init: controller,
                      builder: (context) {
                        return Text(
                          '${controller.phoneNumber?.dialCode} ${controller.phoneNumber?.phoneNumber?.replaceAll('${controller.phoneNumber?.dialCode}', '')}',
                          style: const TextStyle(
                              fontFamily: FontRes.bold,
                              fontSize: 22,
                              color: ColorRes.charcoalGrey),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          color: ColorRes.whiteSmoke,
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.center,
                      child: TextField(
                        controller: controller.otpController,
                        textAlign: TextAlign.center,
                        maxLength: 6,
                        decoration: InputDecoration(
                          isDense: true,
                          counterText: '',
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          hintText: S.current.enterYourOtp,
                          hintStyle: const TextStyle(
                              fontFamily: FontRes.semiBold,
                              color: ColorRes.silverChalice),
                        ),
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          color: ColorRes.charcoalGrey,
                          fontFamily: FontRes.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextButtonCustom(
                      onPressed: controller.verifyPhoneNumber,
                      backgroundColor: ColorRes.darkSkyBlue,
                      titleColor: ColorRes.white,
                      title: S.current.submit,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          GetBuilder(
                            id: kTimerUpdate,
                            init: controller,
                            builder: (context) {
                              String strDigits(int n) =>
                                  n.toString().padLeft(2, '0');
                              return Text(
                                "00:${strDigits(controller.timerCount)}",
                                style: const TextStyle(
                                    color: ColorRes.battleshipGrey,
                                    fontFamily: FontRes.semiBold,
                                    fontSize: 15),
                              );
                            },
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              if (controller.timerCount == 0) {
                                controller.resendOtp();
                              }
                            },
                            child: GetBuilder(
                                id: kTimerUpdate,
                                init: controller,
                                builder: (context) {
                                  return Text(
                                    S.current.reSend,
                                    style: TextStyle(
                                      color: controller.timerCount == 0
                                          ? ColorRes.battleshipGrey
                                          : ColorRes.nobel,
                                      fontFamily: FontRes.semiBold,
                                      fontSize: 15,
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
