import 'package:doclink/doctor/common/text_button_custom.dart';
import 'package:doclink/doctor/generated/l10n.dart';
import 'package:doclink/doctor/screen/personal_information_screen/personal_information_screen_controller.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/font_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class MobileNumberChangeSheet extends StatelessWidget {
  final PersonalInformationScreenController controller;

  const MobileNumberChangeSheet({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Wrap(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height / 30,
                ),
                Text(
                  S.current.enterYourPhoneNumberEtc,
                  style: const TextStyle(
                    fontFamily: FontRes.light,
                    fontSize: 16,
                    color: ColorRes.charcoalGrey,
                  ),
                ),
                SizedBox(
                  height: Get.height / 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: ColorRes.silverChalice.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: Get.width / 4,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: ColorRes.charcoalGrey,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                        ),
                      ),
                      InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          controller.phoneNumber = number;
                        },
                        countrySelectorScrollControlled: true,
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.DIALOG,
                          leadingPadding: 5,
                          trailingSpace: true,
                          showFlags: true,
                          useEmoji: true,
                        ),
                        selectorTextStyle: const TextStyle(
                          color: ColorRes.white,
                          fontFamily: FontRes.semiBold,
                          fontSize: 18,
                          overflow: TextOverflow.ellipsis,
                        ),
                        textStyle: const TextStyle(
                          fontFamily: FontRes.bold,
                          fontSize: 16,
                          color: ColorRes.charcoalGrey,
                        ),
                        cursorColor: ColorRes.battleshipGrey,
                        focusNode: controller.phoneFocusNode,
                        keyboardAction: TextInputAction.done,
                        initialValue: PhoneNumber(isoCode: "IN"),
                        formatInput: true,
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        inputDecoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          hintText: S.current.enterMobileNumber,
                          contentPadding: const EdgeInsets.only(left: 5),
                          hintStyle: TextStyle(
                            color: ColorRes.battleshipGrey.withOpacity(0.5),
                            fontFamily: FontRes.medium,
                          ),
                          isCollapsed: false,
                          counterText: "",
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextButtonCustom(
                  onPressed: () => controller.verifyPhoneNumber(controller),
                  backgroundColor: ColorRes.tuftsBlue.withOpacity(0.2),
                  title: S.current.continueText,
                  titleColor: ColorRes.tuftsBlue100,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
