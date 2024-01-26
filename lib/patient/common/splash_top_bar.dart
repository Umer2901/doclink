import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doclink/utils/asset_res.dart';
import 'package:doclink/utils/color_res.dart';

class SplashTopBar extends StatelessWidget {
  const SplashTopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height / 1.6,
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
}
