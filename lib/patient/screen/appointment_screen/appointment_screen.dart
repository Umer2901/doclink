import 'package:flutter/material.dart';
import 'package:doclink/patient/common/dashboard_top_bar_title.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/patient/screen/appointment_screen/appointment_screen_controller.dart';
import 'package:doclink/patient/screen/appointment_screen/widget/appointments.dart';
import 'package:doclink/utils/color_res.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = AppointmentScreenController();
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: Column(
        children: [
          DashboardTopBarTitle(title: PS.current.appointments),
          Appointments(controller: controller)
        ],
      ),
    );
  }
}
