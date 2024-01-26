import 'package:doclink/doctor/generated/l10n.dart';
import 'package:doclink/doctor/screen/appointment_screen/appointment_screen.dart';
import 'package:doclink/doctor/screen/dashboard_screen/dashboard_screen_controller.dart';
import 'package:doclink/doctor/screen/dashboard_screen/widget/custom_animated_bottom_bar.dart';
import 'package:doclink/doctor/screen/message_screen/message_screen.dart';
import 'package:doclink/doctor/screen/notification_screen/notification_screen.dart';
import 'package:doclink/doctor/screen/profile_screen/profile_screen.dart';
import 'package:doclink/doctor/screen/request_screen/request_screen.dart';
import 'package:doclink/utils/asset_res.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const bottomSheetStyle = TextStyle(fontSize: 12);

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardScreenController());
    return GetBuilder(
      init: controller,
      builder: (context) {
        return Scaffold(
          backgroundColor: ColorRes.white,
          bottomNavigationBar: _buildBottomBar(controller),
          body: controller.currentIndex == 0
              ? const AppointmentScreen()
              : controller.currentIndex == 1
                  ? RequestScreen()
                  : controller.currentIndex == 2
                      ? const MessageScreen()
                          : const ProfileScreen(),
        );
      },
    );
  }

  Widget _buildBottomBar(DashboardScreenController controller) {
    return CustomAnimatedBottomBar(
      containerHeight: 60,
      selectedIndex: controller.currentIndex,
      showElevation: true,
      curve: Curves.easeIn,
      onItemSelected: controller.onItemSelected,
      items: [
        BottomNavyBarItem(
          image: Icon(
            Icons.playlist_add_check_rounded,
            size: 28,
            color: controller.currentIndex == 0
                ? ColorRes.white
                : ColorRes.starDust,
          ),
          title: Text(
            S.current.appointments,
            style: bottomSheetStyle,
          ),
        ),
        BottomNavyBarItem(
          image: Image.asset(
            AssetRes.listMinus,
            width: 25,
            color: controller.currentIndex == 1
                ? ColorRes.white
                : ColorRes.starDust,
          ),
          title: Text(S.current.requests, style: bottomSheetStyle),
        ),
        BottomNavyBarItem(
          image: Image.asset(
            AssetRes.chatQuote,
            width: 22,
            color: controller.currentIndex == 2
                ? ColorRes.white
                : ColorRes.starDust,
          ),
          title: Text(S.current.message, style: bottomSheetStyle),
        ),
        BottomNavyBarItem(
          image: Icon(
            Icons.person,
            size: 28,
            color: controller.currentIndex == 3
                ? ColorRes.white
                : ColorRes.starDust,
          ),
          title: Text(S.current.profile, style: bottomSheetStyle),
        ),
      ],
    );
  }
}
