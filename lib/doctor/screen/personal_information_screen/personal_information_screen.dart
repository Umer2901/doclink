import 'dart:ui';

import 'package:doclink/doctor/common/custom_ui.dart';
import 'package:doclink/doctor/common/doctor_profile_text_filed.dart';
import 'package:doclink/doctor/common/doctor_reg_button.dart';
import 'package:doclink/doctor/common/top_bar_area.dart';
import 'package:doclink/doctor/generated/l10n.dart';
import 'package:doclink/doctor/screen/personal_information_screen/personal_information_screen_controller.dart';
import 'package:doclink/utils/asset_res.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/const_res.dart';
import 'package:doclink/utils/font_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PersonalInformationScreenController());
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: Column(
        children: [
          TopBarArea(title: S.current.personalInformation),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: GetBuilder(
                init: controller,
                builder: (context) {
                  return controller.isLoading
                      ? CustomUi.loaderWidget()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: ColorRes.whiteSmoke,
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: controller.onImagePick,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: GetBuilder(
                                            init: controller,
                                            builder: (context) {
                                              return controller.profileImage !=
                                                      null
                                                  ? Image(
                                                      image: FileImage(
                                                          controller
                                                              .profileImage!),
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : controller.netWorkProfileImage !=
                                                          null
                                                      ? Image(
                                                          image: NetworkImage(
                                                            '${ConstRes.itemBaseURL}${controller.netWorkProfileImage}',
                                                          ),
                                                          height: 100,
                                                          width: 100,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : CustomUi.userPlaceHolder(
                                                          male: controller
                                                                  .doctorData
                                                                  ?.gender ??
                                                              0,
                                                          height: 100);
                                            },
                                          ),
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 7, sigmaY: 7),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                  color: ColorRes.charcoalGrey
                                                      .withOpacity(0.4),
                                                  shape: BoxShape.circle),
                                              child: Image.asset(
                                                  AssetRes.messageEditBox),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.nameController.text,
                                          style: const TextStyle(
                                            fontFamily: FontRes.extraBold,
                                            fontSize: 19,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              AssetRes.stethoscope,
                                              width: 18,
                                              height: 18,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                              child: Text(
                                                controller
                                                    .designationController.text,
                                                style: const TextStyle(
                                                    color:
                                                        ColorRes.havelockBlue,
                                                    fontSize: 15,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          controller.degreeController.text,
                                          style: const TextStyle(
                                              fontSize: 14.5,
                                              color: ColorRes.mediumGrey),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 15, bottom: 5),
                              child: Text(
                                S.current.phoneNumber,
                                style: const TextStyle(
                                    fontFamily: FontRes.semiBold,
                                    color: ColorRes.charcoalGrey,
                                    fontSize: 15),
                              ),
                            ),
                            Container(
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              color: ColorRes.whiteSmoke,
                              child: Row(
                                children: [
                                  GetBuilder(
                                    init: controller,
                                    builder: (context) {
                                      return Text(
                                        controller.mobileController.text,
                                        style: const TextStyle(
                                            color: ColorRes.mediumGrey,
                                            fontFamily: FontRes.bold,
                                            fontSize: 15),
                                      );
                                    },
                                  ),
                                  Image.asset(
                                    AssetRes.icRoundVerified,
                                    width: 15,
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () =>
                                        controller.onChangeTap(controller),
                                    child: Text(
                                      S.current.change,
                                      style: const TextStyle(
                                          fontFamily: FontRes.semiBold,
                                          fontSize: 15,
                                          color: ColorRes.tuftsBlue),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            GetBuilder(
                                init: controller,
                                builder: (context) {
                                  return DoctorProfileTextField(
                                    isExample: false,
                                    title: S.current.yourName,
                                    exampleTitle: "",
                                    onChange: controller.onNameChange,
                                    textFieldColor: ColorRes.mediumGrey,
                                    textFieldFontFamily: FontRes.medium,
                                    hintTitle: S.current.enterYourName,
                                    controller: controller.nameController,
                                    focusNode: controller.nameFocusNode,
                                  );
                                }),
                            GetBuilder(
                                init: controller,
                                builder: (context) {
                                  return DoctorProfileTextField(
                                    isExample: false,
                                    title: S.current.designationEtc,
                                    exampleTitle: "",
                                    onChange: controller.onDesignationChange,
                                    textFieldColor: ColorRes.mediumGrey,
                                    textFieldFontFamily: FontRes.medium,
                                    hintTitle: S.current.enterDesignation,
                                    controller:
                                        controller.designationController,
                                    focusNode: controller.designationFocusNode,
                                  );
                                }),
                            GetBuilder(
                                init: controller,
                                builder: (context) {
                                  return DoctorProfileTextField(
                                    title: S.current.enterYourDegreesEtc,
                                    exampleTitle: S.current.exampleMsEtc,
                                    onChange: controller.onDegreeChange,
                                    hintTitle: S.current.enterDesignation,
                                    textFieldColor: ColorRes.mediumGrey,
                                    textFieldFontFamily: FontRes.medium,
                                    controller: controller.degreeController,
                                    focusNode: controller.degreeFocusNode,
                                    textFieldHeight: 100,
                                    isExpand: true,
                                  );
                                }),
                            GetBuilder(
                                init: controller,
                                builder: (context) {
                                  return DoctorProfileTextField(
                                    title: S.current.languagesYouSpeakEtc,
                                    exampleTitle: S.current.exampleLanguage,
                                    hintTitle: S.current.enterLanguages,
                                    textFieldColor: ColorRes.mediumGrey,
                                    textFieldFontFamily: FontRes.medium,
                                    controller: controller.languageController,
                                    focusNode: controller.languageFocusNode,
                                  );
                                }),
                            GetBuilder(
                                init: controller,
                                builder: (context) {
                                  return DoctorProfileTextField(
                                    title: S.current.yearsOfExperience,
                                    isExample: false,
                                    exampleTitle: "",
                                    textFieldColor: ColorRes.mediumGrey,
                                    textFieldFontFamily: FontRes.medium,
                                    hintTitle: S.current.numberOfYears,
                                    controller: controller.yearController,
                                    textInputType: TextInputType.number,
                                    focusNode: controller.yearFocusNode,
                                  );
                                }),
                            GetBuilder(
                              init: controller,
                              builder: (context) {
                                return DoctorProfileTextField(
                                  title: S.current.consultationFee,
                                  exampleTitle: S.current.youCanChangeThisEtc,
                                  hintTitle: '00',
                                  textFieldColor: ColorRes.mediumGrey,
                                  textFieldFontFamily: FontRes.medium,
                                  controller: controller.feesController,
                                  textInputType: TextInputType.number,
                                  focusNode: controller.feesFocusNode,
                                  isDollar: true,
                                );
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        );
                },
              ),
            ),
          ),
          DoctorRegButton(
            onTap: controller.updateProfileApiCall,
            title: S.current.continueText,
          ),
        ],
      ),
    );
  }
}
