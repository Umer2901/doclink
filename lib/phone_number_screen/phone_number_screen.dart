import 'package:doclink/doctor/common/starting_doctor_top.dart';
import 'package:doclink/doctor/common/text_button_custom.dart';
import 'package:doclink/doctor/generated/l10n.dart';
import 'package:doclink/phone_number_screen/phone_number_screen_controller.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/font_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberScreen extends StatelessWidget {
  const  PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PhoneNumberScreenController controller =
        Get.put(PhoneNumberScreenController());
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        controller.phoneFocusNode.unfocus();
                      },
                      child: const StartingDoctorTop()),
                  _bottomArea(controller),
                ],
              ),
            ),
          ),
          TextButtonCustom(
            onPressed: controller.verifyPhoneNumber,
            backgroundColor: ColorRes.tuftsBlue.withOpacity(0.2),
            title: S.current.continueText, 
            titleColor: ColorRes.tuftsBlue100,
            bottomMargin: 20,
          ),
        ],
      ),
    );
  }

  Widget _bottomArea(PhoneNumberScreenController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.height / 20,
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
                  decoration: BoxDecoration(
                    color: ColorRes.charcoalGrey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                          Directionality.of(Get.context!) == TextDirection.rtl
                              ? 0
                              : 10),
                      bottomLeft: Radius.circular(
                        Directionality.of(Get.context!) == TextDirection.rtl
                            ? 0
                            : 10,
                      ),
                      topRight: Radius.circular(
                          Directionality.of(Get.context!) == TextDirection.rtl
                              ? 10
                              : 0),
                      bottomRight: Radius.circular(
                        Directionality.of(Get.context!) == TextDirection.rtl
                            ? 10
                            : 0,
                      ),
                    ),
                  ),
                ),
                InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    controller.phoneNumber = number;
                  },
                  countrySelectorScrollControlled: true,
                  selectorConfig: SelectorConfig(
                    selectorType: PhoneInputSelectorType.DIALOG,
                    leadingPadding: 5,
                    trailingSpace:
                        Directionality.of(Get.context!) == TextDirection.rtl
                            ? false
                            : true,
                    showFlags: true,
                    useEmoji: true,
                  ),
                  textAlign:
                      Directionality.of(Get.context!) == TextDirection.rtl
                          ? TextAlign.end
                          : TextAlign.start,
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
                  keyboardType: const TextInputType.numberWithOptions(),
                  inputDecoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    hintText: S.current.enterMobileNumber,
                    hintTextDirection: TextDirection.ltr,
                    contentPadding: EdgeInsets.only(
                        left:
                            Directionality.of(Get.context!) != TextDirection.rtl
                                ? 0
                                : 5,
                        right:
                            Directionality.of(Get.context!) != TextDirection.rtl
                                ? 0
                                : 15),
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
            height: 10,
          ),
        ],
      ),
    );
  }
}
