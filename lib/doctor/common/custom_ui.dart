import 'dart:math';

import 'package:doclink/doctor/generated/l10n.dart';
import 'package:doclink/utils/asset_res.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/extention.dart';
import 'package:doclink/utils/font_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomUi {
  static void snackBar({
    String? message,
    bool positive = false,
    required IconData iconData,
    bool? isVideoCall,
  }) {
    Get.rawSnackbar(
      duration: isVideoCall == true ? Duration(seconds: 3) : Duration(seconds: 2),
      messageText: Text(
        message?.capitalize ?? '',
        style: TextStyle(
            color: positive ? ColorRes.white : ColorRes.lightRed,
            fontFamily: FontRes.medium,
            fontSize: 14),
      ),
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 10,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      icon: Icon(
        iconData,
        color: positive ? ColorRes.white : ColorRes.lightRed,
        size: 24,
      ),
      backgroundColor: positive ? ColorRes.black : ColorRes.pinkLace,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    );
  }

  static void infoSnackBar(
    String msg,
  ) {
    snackBar(message: msg, iconData: Icons.info_rounded, positive: false);
  }

  static Future loader() {
    return showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) {
        return Center(child: Container(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(
            color: ColorRes.tuftsBlue,
          ),
        ));
      },
    );
  }

  static Widget loaderWidget() {
    return Center(child: Container(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(
            color: ColorRes.tuftsBlue,
          ),
        ));
  }

  static Widget userPlaceHolder({required num male, double height = 100}) {
    return Container(
      color: ColorRes.battleshipGrey.withOpacity(0.2),
      height: height,
      width: height,
      padding: const EdgeInsets.all(5),
      child: Image.asset(
        male.genderParse == 1 ? AssetRes.male : AssetRes.feMale,
        height: height,
        width: height,
        color: ColorRes.grey,
      ),
    );
  }

  static Widget doctorPlaceHolder({int? male = 1, double height = 100}) {
    return Container(
      color: ColorRes.lightGrey,
      height: height,
      width: height,
      padding: const EdgeInsets.all(5),
      child: Image.asset(
        male == 1 ? AssetRes.p1 : AssetRes.p2,
        height: height,
        width: height,
      ),
    );
  }

  static Widget noData({String? message}) {
    return Center(
      child: Text(
        message ?? S.current.noData,
        style: const TextStyle(
            color: ColorRes.battleshipGrey, fontFamily: FontRes.semiBold),
      ),
    );
  }

  static Widget noDataImage({double? size, String? message}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          AssetRes.noAppointment,
          width: size ?? Get.width / 1.5,
          height: size ?? Get.width / 1.5,
        ),
        Container(
          width: 300,
          alignment: Alignment.center,
          child: Text(
            message ?? S.current.noData,
            style: const TextStyle(
                color: ColorRes.battleshipGrey, fontFamily: FontRes.semiBold),
                softWrap: true,
          ),
        ),
      ],
    );
  }
}

class CircularLoader extends StatefulWidget {
  const CircularLoader({super.key});

  @override
  State<CircularLoader> createState() => _CircularLoaderState();
}

class _CircularLoaderState extends State<CircularLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
      //_navigateToNextScreen();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Restart the animation when it reaches the completed state.
        _controller.forward(from: 0.0);
      }
    });

    _controller.forward();
  }
  // void _navigateToNextScreen() {
  //   Future.delayed(Duration(seconds: 5), () {
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (context) => AcceptRequest(), // Replace 'YourNextScreen' with your actual next screen.
  //       ),
  //     );
  //   });
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
                 child: Container(
                        height: 400,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 50,
                              right: 0,
                              left: 0,
                              child: OvalBorder(
                                horizontalRadius: 115.0,
                                verticalRadius: 130.0,
                                borderThickness: 20.0,
                                borderColor: ColorRes.havelockBlue,
                              )
               
                            ),
               
                            AnimatedBuilder(
  animation: _animation,
  builder: (context, child) {
    // Calculate the position of the animated container along the oval border path
    final angle = _animation.value * 2 * pi;
    final x = 115.0 * cos(angle) + 180.0; // Adjust for the horizontal radius
    final y = 130.0 * sin(angle) + 175.0; // Adjust for the vertical radius

    return Positioned(
      left: x - 50, // Adjust as needed for the size of your container
      top: y - 50, // Adjust as needed for the size of your container
      child: Container(
        width: 75,
        height: 75,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 5),
          shape: BoxShape.circle,
          color: Colors.blue[900],
        ),
      ),
    );
  },
),
                          ],
                        ),
               
                            ),
               ),
    );
  }
}


class OvalBorder extends StatelessWidget {
  final double horizontalRadius;
  final double verticalRadius;
  final double borderThickness;
  final Color borderColor;

  OvalBorder({
    required this.horizontalRadius,
    required this.verticalRadius,
    required this.borderThickness,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(horizontalRadius * 2, verticalRadius * 2),
      painter: OvalBorderPainter(borderColor, borderThickness, horizontalRadius, verticalRadius),
    );
  }
}

class OvalBorderPainter extends CustomPainter {
  final Color borderColor;
  final double borderThickness;
  final double horizontalRadius;
  final double verticalRadius;

  OvalBorderPainter(
      this.borderColor,
      this.borderThickness,
      this.horizontalRadius,
      this.verticalRadius,
      );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderThickness;

    final center = Offset(size.width / 2, size.height / 2);

    // Rotate the canvas by 35 degrees (pi / 8 radians) before drawing the oval.
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(pi / 9); // 35 degrees in radians
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(0, 0),
        width: horizontalRadius * 2,
        height: verticalRadius * 2,
      ),
      paint,
    );
    canvas.restore(); // Restore the canvas to its original state
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
