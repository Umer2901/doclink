import 'package:flutter/material.dart';
import 'package:doclink/patient/model/doctor/fetch_doctor.dart';
import 'package:doclink/patient/screen/doctor_profile_screen/doctor_profile_screen_controller.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/my_text_style.dart';

class ExperiencePage extends StatelessWidget {
  final DoctorProfileScreenController controller;

  const ExperiencePage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      primary: false,
      itemCount: controller.doctorData?.experience?.length ?? 0,
      itemBuilder: (context, index) {
        Services? experience = controller.doctorData?.experience?[index];
        return Container(
          color: index % 2 != 0 ? ColorRes.white : ColorRes.whiteSmoke,
          padding: const EdgeInsets.all(15),
          child: Text(
            experience?.title ?? '',
            style: MyTextStyle.montserratRegular(
                color: ColorRes.davyGrey, size: 14),
          ),
        );
      },
    );
  }
}
