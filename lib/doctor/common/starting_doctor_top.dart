import 'package:doclink/utils/asset_res.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartingDoctorTop extends StatelessWidget {
  const StartingDoctorTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        double sizedBoxHeight;

      // Determine the screen size and set the SizedBox height accordingly
      if (constraint.maxWidth < 425) {
        // Small device
        sizedBoxHeight = Get.height / 3;
      }else if (constraint.maxWidth < 000) {
      sizedBoxHeight = Get.height / 2; 
      }else if (constraint.maxWidth < 960) {
        // Medium device
        sizedBoxHeight = Get.height / 1.7;
      } else {
        // Large device
        sizedBoxHeight = Get.height / 1.6;
      }
        return SizedBox(
          height: sizedBoxHeight,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ColorRes.crystalBlue,
                      ColorRes.tuftsBlue100,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Image(
                image: const AssetImage(
                  AssetRes.doctor1,
                ),
                height: Get.height / 2.2,
                fit: BoxFit.fitHeight,
              ),
            ],
          ),
        );
      }
    );
  }
}
