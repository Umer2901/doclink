import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doclink/patient/common/drop_down_menu.dart';
import 'package:doclink/patient/common/text_button_custom.dart';
import 'package:doclink/patient/common/top_bar_area.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/patient/screen/complete_registration_screen/complete_registration_screen_controller.dart';
import 'package:doclink/patient/services/patient_pref_service.dart';
import 'package:doclink/utils/asset_res.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/my_text_style.dart';
import 'package:doclink/utils/update_res.dart';

class CompleteRegistrationScreen extends StatelessWidget {
  const CompleteRegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CompleteRegistrationScreenController());
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBarArea(title: PS.current.completeRegistration),
          CenterArea(controller: controller),
          SafeArea(
            top: false,
            child: TextButtonCustom(
                onPressed: controller.onSubmitBtnClick,
                title: PS.current.submit,
                titleColor: ColorRes.white,
                backgroundColor: ColorRes.darkSkyBlue),
          )
        ],
      ),
    );
  }
}

class CenterArea extends StatelessWidget {
  final CompleteRegistrationScreenController controller;

  const CenterArea({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                PS.current.yourPhoneNumberHasEtc,
                style: const TextStyle(
                    color: ColorRes.battleshipGrey, fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(PatientPrefService.identity ?? '',
                      style: MyTextStyle.montserratBold(
                          size: 16, color: ColorRes.charcoalGrey)),
                  const SizedBox(
                    width: 5,
                  ),
                  Image.asset(
                    AssetRes.icVerified,
                    width: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                PS.current.yourFullname,
                style: MyTextStyle.montserratRegular(
                    size: 15, color: ColorRes.battleshipGrey),
              ),
              const SizedBox(
                height: 10,
              ),
              GetBuilder(
                  init: controller,
                  builder: (context) {
                    return Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: controller.isName
                              ? ColorRes.bittersweet.withOpacity(0.2)
                              : ColorRes.whiteSmoke,
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.center,
                      child: TextField(
                        controller: controller.fullNameController,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          hintText: controller.isName
                              ? PS.current.pleaseEnterFullName
                              : '',
                          hintStyle: MyTextStyle.montserratMedium(
                              color: ColorRes.bittersweet, size: 14),
                          border: InputBorder.none,
                        ),
                        textCapitalization: TextCapitalization.sentences,
                        style: MyTextStyle.montserratBold(
                            size: 16, color: ColorRes.charcoalGrey),
                        cursorHeight: 16,
                        cursorColor: ColorRes.charcoalGrey,
                      ),
                    );
                  }),
              const SizedBox(
                height: 25,
              ),
              Text(
                PS.current.selectCountry,
                style: MyTextStyle.montserratRegular(
                    size: 15, color: ColorRes.battleshipGrey),
              ),
              const SizedBox(
                height: 10,
              ),
              // GetBuilder(
              //   init: controller,
              //   builder: (controller) => CountryDropDown(
              //       countries: controller.countries?.country,
              //       initialValue: controller.selectCountry,
              //       onChange: controller.onCountryChange),
              // ),

              GetBuilder(
                  init: controller,
                  builder: (context) {
                    return InkWell(
                      onTap: controller.countryBottomSheet,
                      child: Container(
                        height: 45,
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: ColorRes.whiteSmoke,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Text(
                              controller.countryName,
                              style: MyTextStyle.montserratBold(
                                  size: 15, color: ColorRes.charcoalGrey),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_drop_down,
                              color: ColorRes.charcoalGrey,
                              size: 30,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
              const SizedBox(
                height: 25,
              ),
              Text(
                PS.current.selectGender,
                style: MyTextStyle.montserratRegular(
                    size: 15, color: ColorRes.battleshipGrey),
              ),
              const SizedBox(
                height: 10,
              ),
              GetBuilder(
                init: controller,
                builder: (controller) => DropDownMenu(
                    items: controller.genders,
                    initialValue: controller.selectGender,
                    onChange: controller.onGenderChange),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                PS.current.dateOfBirth,
                style: MyTextStyle.montserratRegular(
                    size: 15, color: ColorRes.battleshipGrey),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () => controller.selectDate(Get.context!),
                child: Container(
                  height: 47,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                      color: ColorRes.whiteSmoke,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      GetBuilder(
                          id: kChangeDate,
                          init: controller,
                          builder: (context) {
                            return Expanded(
                              child: Text(
                                controller.dateController.text,
                                style: MyTextStyle.montserratBold(
                                    size: 17, color: ColorRes.charcoalGrey),
                              ),
                            );
                          }),
                      Image.asset(
                        AssetRes.calender,
                        width: 20,
                      )
                    ],
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
