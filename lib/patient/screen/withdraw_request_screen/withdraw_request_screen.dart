import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doclink/patient/common/patient_text_filed.dart';
import 'package:doclink/patient/common/text_button_custom.dart';
import 'package:doclink/patient/common/top_bar_area.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/patient/screen/withdraw_request_screen/withdraw_request_screen_controller.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/my_text_style.dart';
import 'package:doclink/utils/update_res.dart';

class WithdrawRequestScreen extends StatelessWidget {
  const WithdrawRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WithdrawRequestScreenController());
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: Column(
        children: [
          TopBarArea(title: PS.current.withdrawRequest),
          Expanded(
            child: SingleChildScrollView(
              child: GetBuilder(
                init: controller,
                builder: (context) {
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(),
                            Text(
                              PS.current.amount,
                              style: MyTextStyle.montserratRegular(
                                  size: 15, color: ColorRes.darkJungleGreen),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '$dollar${controller.wallet}',
                              style: MyTextStyle.montserratRegular(
                                  size: 29, color: ColorRes.tuftsBlue),
                            ),
                          ],
                        ),
                      ),
                      PatientTextField(
                        title: PS.current.bankName,
                        exampleTitle: "",
                        hintTitle: "",
                        controller: controller.bankNameController,
                        titleTextStyle: MyTextStyle.montserratSemiBold(
                          size: 15,
                          color: ColorRes.charcoalGrey,
                        ),
                        errorColor: controller.isBankName
                            ? ColorRes.bittersweet.withOpacity(0.2)
                            : ColorRes.whiteSmoke,
                      ),
                      PatientTextField(
                        title: PS.current.accountNumber,
                        exampleTitle: "",
                        hintTitle: "",
                        controller: controller.accountNumberController,
                        titleTextStyle: MyTextStyle.montserratSemiBold(
                            size: 15, color: ColorRes.charcoalGrey),
                        errorColor: controller.isAccountNumber
                            ? ColorRes.bittersweet.withOpacity(0.2)
                            : ColorRes.whiteSmoke,
                        textInputType: TextInputType.number,
                      ),
                      PatientTextField(
                        title: PS.current.reEnterAccountNumber,
                        exampleTitle: "",
                        hintTitle: "",
                        controller: controller.reAccountNumberController,
                        titleTextStyle: MyTextStyle.montserratSemiBold(
                            size: 15, color: ColorRes.charcoalGrey),
                        errorColor: controller.isReAccountNumber
                            ? ColorRes.bittersweet.withOpacity(0.2)
                            : ColorRes.whiteSmoke,
                        textInputType: TextInputType.number,
                      ),
                      PatientTextField(
                        title: PS.current.holdersName,
                        exampleTitle: "",
                        hintTitle: "",
                        controller: controller.holderNameController,
                        titleTextStyle: MyTextStyle.montserratSemiBold(
                            size: 15, color: ColorRes.charcoalGrey),
                        errorColor: controller.isHolderName
                            ? ColorRes.bittersweet.withOpacity(0.2)
                            : ColorRes.whiteSmoke,
                      ),
                      PatientTextField(
                        title: PS.current.swiftCode,
                        exampleTitle: "",
                        hintTitle: "",
                        controller: controller.swiftCodeController,
                        titleTextStyle: MyTextStyle.montserratSemiBold(
                            size: 15, color: ColorRes.charcoalGrey),
                        errorColor: controller.isSwiftCode
                            ? ColorRes.bittersweet.withOpacity(0.2)
                            : ColorRes.whiteSmoke,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: TextButtonCustom(
                onPressed: controller.onSubmitTap,
                title: PS.current.submit,
                titleColor: ColorRes.white,
                backgroundColor: ColorRes.darkSkyBlue),
          )
        ],
      ),
    );
  }
}
