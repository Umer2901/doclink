import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doclink/patient/common/custom_ui.dart';
import 'package:doclink/patient/common/dashboard_top_bar_title.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/patient/screen/appointments_profile_screen/appointments_profile_screen.dart';
import 'package:doclink/patient/screen/help_and_faq_screen/help_and_faq_screen.dart';
import 'package:doclink/patient/screen/languages_screen/languages_screen.dart';
import 'package:doclink/patient/screen/manage_patient_screen/manage_patient_screen.dart';
import 'package:doclink/patient/screen/notification_screen/notification_screen.dart';
import 'package:doclink/patient/screen/prescription_screen/prescription_screen.dart';
import 'package:doclink/patient/screen/profile_screen/profile_screen_controller.dart';
import 'package:doclink/patient/screen/profile_screen/widget/delete_account_sheet.dart';
import 'package:doclink/patient/screen/profile_screen/widget/profile_card.dart';
import 'package:doclink/patient/screen/profile_screen/widget/switch_card.dart';
import 'package:doclink/patient/screen/saved_doctor_screen/saved_doctor_screen.dart';
import 'package:doclink/patient/screen/wallet_screen/wallet_screen.dart';
import 'package:doclink/patient/screen/webview_screen/webview_screen.dart';
import 'package:doclink/patient/screen/withdraw_history_screen/withdraw_history_screen.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/const_res.dart';
import 'package:doclink/utils/my_text_style.dart';
import 'package:doclink/utils/update_res.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileScreenController());
    return Column(
      children: [
        GetBuilder(
            init: controller,
            builder: (context) {
              return DashboardTopBarTitle(title: PS.current.profile);
            }),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  color: ColorRes.whiteSmoke,
                  child: GetBuilder(
                    id: kProfileUpdate,
                    init: controller,
                    builder: (context) {
                      return Row(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: controller.userData?.profileImage != null
                                  ? CachedNetworkImage(
                                      imageUrl:
                                          '${ConstRes.itemBaseURL}${controller.userData?.profileImage}',
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                      errorWidget:
                                          (context, error, stackTrace) {
                                        return CustomUi.userPlaceHolder(
                                            gender:
                                                controller.userData?.gender ??
                                                    0,
                                            height: 100);
                                      },
                                    )
                                  : CustomUi.userPlaceHolder(
                                      gender: controller.userData?.gender ?? 0,
                                      height: 100)),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.userData?.fullname ??
                                      PS.current.unKnown,
                                  style: MyTextStyle.montserratExtraBold(
                                    size: 19,
                                    color: ColorRes.davyGrey,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  controller.userData?.identity ?? '',
                                  style: MyTextStyle.montserratLight(
                                    size: 15,
                                    color: ColorRes.davyGrey,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                InkWell(
                                  onTap: controller.onEditProfileNavigate,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: ColorRes.battleshipGrey
                                            .withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Text(
                                      PS.current.editDetails,
                                      style: MyTextStyle.montserratMedium(
                                          size: 13, color: ColorRes.tuftsBlue),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 5),
                GetBuilder(
                  id: kNotificationUpdate,
                  init: controller,
                  builder: (controller) {
                    return SwitchCard(
                      title: PS.current.pushNotification,
                      title2: PS.current.keepItOnIfYou,
                      alignment: controller.isNotification
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      enable: controller.isNotification,
                      onTap: controller.onNotificationTap,
                      onNotificationTap: () {
                        Get.to(
                          () => const NotificationScreen(),
                        );
                      },
                    );
                  },
                ),
                GetBuilder(
                    init: controller,
                    builder: (context) {
                      return Column(
                        children: [
                          ProfileCard(
                            title: PS.current.savedDoctors,
                            onTap: () {
                              Get.to(() => const SavedDoctorScreen());
                            },
                          ),
                          ProfileCard(
                            title: PS.current.wallet,
                            onTap: () {
                              Get.to(() => const WalletScreen());
                            },
                          ),
                          ProfileCard(
                            title: PS.current.withdrawRequests,
                            onTap: () {
                              Get.to(() => const WithdrawHistoryScreen());
                            },
                          ),
                          ProfileCard(
                            title: PS.current.appointments,
                            onTap: () {
                              Get.to(
                                () => const AppointmentsProfileScreen(),
                              );
                            },
                          ),
                          ProfileCard(
                            title: PS.current.managePatients,
                            onTap: () {
                              Get.to(() => const ManagePatientScreen());
                            },
                          ),
                          ProfileCard(
                            title: PS.current.prescriptions,
                            onTap: () {
                              Get.to(() => const PrescriptionScreen());
                            },
                          ),
                          ProfileCard(
                            title: PS.current.languages.capitalize ?? '',
                            onTap: () {
                              Get.to(() => const LanguagesScreen());
                            },
                          ),
                          ProfileCard(
                            title: PS.current.termsOfUse,
                            onTap: () {
                              Get.to(
                                  () => WebviewScreen(
                                      title: PS.current.termsOfUse),
                                  arguments: ConstRes.termsOfUser);
                            },
                          ),
                          ProfileCard(
                            title: PS.current.privacyPolicy,
                            onTap: () {
                              Get.to(
                                  () => WebviewScreen(
                                      title: PS.current.privacyPolicy),
                                  arguments: ConstRes.privacyPolicy);
                            },
                          ),
                          ProfileCard(
                            title: PS.current.helpAndFAQ,
                            onTap: () {
                              Get.to(() => const HelpAndFaqScreen());
                            },
                          ),
                          ProfileCard(
                            title: PS.current.logout,
                            cardColor: ColorRes.mangoOrange.withOpacity(0.15),
                            textColor: ColorRes.mangoOrange,
                            onTap: () {
                              Get.bottomSheet(
                                  DeleteAccountSheet(
                                    onDeleteContinueTap: controller.onLogoutTap,
                                    title: PS.current.logout,
                                    description:
                                        PS.current.doYouReallyWantToLogoutEtc,
                                  ),
                                  isScrollControlled: true);
                            },
                          ),
                          ProfileCard(
                            title: PS.current.deleteMyAccount,
                            cardColor: ColorRes.bittersweet.withOpacity(0.15),
                            textColor: ColorRes.bittersweet,
                            onTap: () {
                              Get.bottomSheet(
                                  DeleteAccountSheet(
                                    onDeleteContinueTap:
                                        controller.onDeleteContinueTap,
                                    title: PS.current.deleteMyAccount,
                                    description: PS.current.doYouReallyWantToEtc,
                                  ),
                                  isScrollControlled: true);
                            },
                          ),
                        ],
                      );
                    }),
                const SizedBox(height: 10)
              ],
            ),
          ),
        )
      ],
    );
  }
}
