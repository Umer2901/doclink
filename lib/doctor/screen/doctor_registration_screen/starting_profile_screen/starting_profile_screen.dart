import 'package:doclink/doctor/common/country_drop_down.dart';
import 'package:doclink/doctor/common/doctor_reg_button.dart';
import 'package:doclink/doctor/common/top_bar_area.dart';
import 'package:doclink/doctor/generated/l10n.dart';
import 'package:doclink/doctor/screen/doctor_registration_screen/starting_profile_screen/starting_profile_screen_controller.dart';
import 'package:doclink/doctor/screen/doctor_registration_screen/starting_profile_screen/widget/drop_down_menu.dart';
import 'package:doclink/utils/asset_res.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/font_res.dart';
import 'package:doclink/utils/update_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartingProfileScreen extends StatelessWidget {
  const StartingProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StartingProfileScreenController());
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBarArea(title: S.current.doctorRegistration),
          _yourName(controller),
          DoctorRegButton(
            onTap: controller.updateDoctorDetailsApiCall,
            title: S.current.continueText,
          ),
        ],
      ),
    );
  }

  Widget _yourName(StartingProfileScreenController controller) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                S.current.yourPhoneNumberEtc,
                style: const TextStyle(
                    color: ColorRes.battleshipGrey, fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  GetBuilder(
                      init: controller,
                      builder: (context) {
                        return Text(
                          controller.userData?.mobileNumber ?? '',
                          style: const TextStyle(
                              color: ColorRes.charcoalGrey,
                              fontSize: 18,
                              fontFamily: FontRes.bold),
                        );
                      }),
                  const SizedBox(
                    width: 5,
                  ),
                  Image.asset(
                    AssetRes.icRoundVerified,
                    width: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                S.current.yourName,
                style: const TextStyle(
                  fontFamily: FontRes.regular,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: ColorRes.whiteSmoke,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    // Container(
                    //   height: 50,
                    //   padding: const EdgeInsets.symmetric(horizontal: 15),
                    //   alignment: Alignment.center,
                    //   decoration: const BoxDecoration(
                    //     color: ColorRes.charcoalGrey,
                    //     borderRadius: BorderRadius.only(
                    //       topLeft: Radius.circular(10),
                    //       bottomLeft: Radius.circular(10),
                    //     ),
                    //   ),
                    //   child: Text(
                    //     S.current.dr,
                    //     style: const TextStyle(
                    //         color: ColorRes.white,
                    //         fontFamily: FontRes.bold,
                    //         fontSize: 18),
                    //   ),
                    // ),
                    GetBuilder(
                      init: controller,
                      builder: (context) {
                        return Expanded(
                          child: TextField(
                            controller: controller.nameController,
                            focusNode: controller.nameFocusNode,
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: InputBorder.none,
                            ),
                            textCapitalization: TextCapitalization.sentences,
                            style: const TextStyle(
                              fontFamily: FontRes.bold,
                              color: ColorRes.charcoalGrey,
                              fontSize: 16,
                            ),
                            cursorHeight: 16,
                            cursorColor: ColorRes.charcoalGrey,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
                    GetBuilder<StartingProfileScreenController>(
                      init: StartingProfileScreenController(),
                      builder: (controller) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      activeColor: ColorRes.tuftsBlue,
                                      value: controller.Dr, onChanged: (value){
                                        controller.selectPrefix("Dr.");
                                    },
                                    ),
                                     Text(
                                            "Dr",
                                            style: const TextStyle(
                                              fontFamily: FontRes.regular,
                                              fontSize: 15,
                                            ),
                                          ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        activeColor: ColorRes.tuftsBlue,
                                        value: controller.Mr, onChanged: (value){
                                      controller.selectPrefix("Mr.");
                                      },
                                      ),
                                       Text(
                                                  "Mr",
                                                  style: const TextStyle(
                                                    fontFamily: FontRes.regular,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      activeColor: ColorRes.tuftsBlue,
                                      value: controller.Mrs, onChanged: (value){
                                    controller.selectPrefix("Ms.");
                                    },
                                    ),
                                     Text(
                                            "Ms",
                                            style: const TextStyle(
                                              fontFamily: FontRes.regular,
                                              fontSize: 15,
                                            ),
                                          ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        activeColor: ColorRes.tuftsBlue,
                                        value: controller.RN, onChanged: (value){
                                      controller.selectPrefix("RN.");
                                      },
                                      ),
                                       Text(
                                                  "RN",
                                                  style: const TextStyle(
                                                    fontFamily: FontRes.regular,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                    ),
              const SizedBox(
                height: 25,
              ),
              Text(
                S.current.selectCountry,
                style: const TextStyle(
                  fontFamily: FontRes.regular,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GetBuilder<StartingProfileScreenController>(
                id: kSelectCountries,
                init: controller,
                builder: (controller) => CountryDropDown(
                    countries: controller.countries?.country,
                    initialValue: controller.selectCountry,
                    onChange: controller.onCountryChange),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                S.current.selectGender,
                style: const TextStyle(
                  fontFamily: FontRes.regular,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GetBuilder<StartingProfileScreenController>(
                id: kSelectGender,
                init: controller,
                builder: (controller) => DropDownMenu(
                    items: controller.genders,
                    initialValue: controller.selectGender,
                    onChange: controller.onGenderChange),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
