import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/patient/screen/appointment_screen/appointment_screen.dart';
import 'package:doclink/patient/screen/dashboard_screen/dashboard_screen_controller.dart';
import 'package:doclink/patient/screen/dashboard_screen/widget/custom_animated_bottom_bar.dart';
import 'package:doclink/patient/screen/home_screen/home_screen.dart';
import 'package:doclink/patient/screen/message_screen/message_screen.dart';
import 'package:doclink/patient/screen/profile_screen/profile_screen.dart';
import 'package:doclink/patient/screen/specialists_screen/specialists_screen.dart';
import 'package:doclink/utils/asset_res.dart';
import 'package:doclink/utils/color_res.dart';

const bottomSheetStyle = TextStyle(fontSize: 12);

class PatientDashboardScreen extends StatelessWidget {
  const PatientDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PatientDashboardScreenController());
    return GetBuilder(
      init: controller,
      builder: (context) {
        return Scaffold(
          backgroundColor: ColorRes.white,
          bottomNavigationBar: _buildBottomBar(controller),
          body: controller.currentIndex == 0
              ? const HomeScreen()
              : controller.currentIndex == 1
                  ? const SpecialistsScreen()
                  : controller.currentIndex == 2
                      ? const AppointmentScreen()
                      : controller.currentIndex == 3
                          ? const MessageScreen()
                          : const ProfileScreen(),
        );
      },
    );
  }

   Widget _buildBottomBar(PatientDashboardScreenController controller) {
  return CustomAnimatedBottomBar(
    containerHeight: 60,
    selectedIndex: controller.currentIndex,
    showElevation: true,
    curve: Curves.easeIn,
    onItemSelected: controller.onItemSelected,
    items: [
      _buildNavItem(
        icon: Icons.home,
        title: PS.current.home,
        currentIndex: 0,
        controller: controller,
      ),
      _buildNavItem(
        icon: Icons.medical_services_rounded,
        title: PS.current.specialists,
        currentIndex: 1,
        controller: controller,
      ),
      _buildNavItem(
        icon: Icons.playlist_add_check,
        title: PS.current.appointments,
        currentIndex: 2,
        controller: controller,
        iconSize: 30,
      ),
      _buildNavItem(
        imageAsset: AssetRes.icQuote,
        title: PS.current.messages,
        currentIndex: 3,
        controller: controller,
        imageWidth: 20,
      ),
      _buildNavItem(
        icon: Icons.person,
        title: PS.current.profile,
        currentIndex: 4,
        controller: controller,
        iconSize: 28,
      ),
    ],
  );
}

BottomNavyBarItem _buildNavItem({
  IconData? icon,
  String? imageAsset,
  double iconSize = 24,
  double imageWidth = 24,
  required String title,
  required int currentIndex,
  required PatientDashboardScreenController controller,
}) {
  bool isSelected = controller.currentIndex == currentIndex;
  return BottomNavyBarItem(
    image: icon != null
        ? Icon(
            icon,
            size: iconSize,
            color: isSelected ? ColorRes.white : ColorRes.grey,
          )
        : Image.asset(
            imageAsset!,
            width: imageWidth,
            color: isSelected ? ColorRes.white : ColorRes.grey,
          ),
    title: Text(title, style: bottomSheetStyle),
  );
}
}
