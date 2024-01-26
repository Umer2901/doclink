import 'package:flutter/material.dart';
import 'package:doclink/patient/screen/doctor_profile_screen/doctor_profile_screen_controller.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/my_text_style.dart';

class EducationPage extends StatelessWidget {
  final DoctorProfileScreenController controller;

  const EducationPage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Text(
        controller.doctorData?.educationalJourney ?? '',
        style: MyTextStyle.montserratRegular(
            size: 15, color: ColorRes.battleshipGrey),
      ),
    );
  }
}
