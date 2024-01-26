import 'package:flutter/material.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/patient/model/doctor/fetch_doctor.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/font_res.dart';

class Languages extends StatelessWidget {
  final Doctor? doctorData;

  const Languages({Key? key, this.doctorData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorRes.snowDrift,
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),
          Text(
            PS.current.languages,
            style: const TextStyle(
                fontSize: 14,
                fontFamily: FontRes.semiBold,
                color: ColorRes.charcoalGrey,
                letterSpacing: 1),
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
            children: List.generate(
              doctorData?.languagesSpoken?.split(',').length ?? 0,
              (index) {
                return Container(
                  margin: const EdgeInsets.all(3),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 9),
                  decoration: BoxDecoration(
                    color: ColorRes.softPeach,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    doctorData?.languagesSpoken?.split(',')[index].toString() ??
                        '',
                    style: const TextStyle(
                        color: ColorRes.tuftsBlue,
                        fontFamily: FontRes.semiBold),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
