import 'package:doclink/doctor/generated/l10n.dart';
import 'package:doclink/doctor/model/doctorProfile/registration/registration.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/font_res.dart';
import 'package:flutter/material.dart';

class EducationPage extends StatelessWidget {
  final DoctorData? doctorData;

  const EducationPage({Key? key, required this.doctorData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Text(
        doctorData?.educationalJourney ?? S.current.noData,
        style: const TextStyle(
            fontSize: 15,
            color: ColorRes.mediumGrey,
            fontFamily: FontRes.regular),
      ),
    );
  }
}
