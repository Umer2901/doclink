import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/utils/asset_res.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/my_text_style.dart';
import 'package:doclink/utils/update_res.dart';

class CustomUi {
  static void snackBar({
    String? message,
    bool positive = false,
    required IconData iconData,
  }) {
    Get.rawSnackbar(
      messageText: Text(
        message ?? '',
        style: MyTextStyle.montserratMedium(
            color: positive ? ColorRes.white : ColorRes.lightRed, size: 14),
      ),
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 10,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      icon: Icon(
        iconData,
        color: positive ? ColorRes.white : ColorRes.lightRed,
        size: 24,
      ),
      backgroundColor: positive ? ColorRes.havelockBlue : ColorRes.pinkLace,
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
        return Center(child: CircularProgressIndicator(
            color: ColorRes.tuftsBlue,
          ),);
      },
    );
  }

  static Widget loaderWidget() {
    return Center(child: CircularProgressIndicator(
            color: ColorRes.tuftsBlue,
          ),);
  }

  static Widget userPlaceHolder({int gender = 0, double height = 100}) {
    return Container(
      height: height,
      width: height,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: ColorRes.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.asset(
        gender == 0 ? AssetRes.female : AssetRes.male,
        color: ColorRes.grey,
      ),
    );
  }

  static Widget ratingIndicator(
      {required double rating, required double ratingSize}) {
    return RatingBarIndicator(
      itemCount: 5,
      itemSize: ratingSize,
      rating: rating,
      itemBuilder: (context, index) {
        return Icon(
          Icons.star_rate_rounded,
          color: ColorRes.mangoOrange,
          size: ratingSize,
        );
      },
    );
  }

  static Widget doctorPlaceHolder(
      {int? gender = 0, double height = 100, double radius = 10}) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        color: ColorRes.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Image.asset(
        gender == 0 ? AssetRes.dFemale : AssetRes.dMale,
        color: ColorRes.grey,
      ),
    );
  }

  static String convert24HoursInto12Hours(String? value) {
    DateTime dateTime = DateTime(
      DateTime.now().year,
      1,
      1,
      int.parse(value?.substring(0, 2) ?? '0'),
      int.parse(value?.substring(2, 4) ?? '0'),
    );
    return DateFormat(hhMmA, 'en').format(dateTime);
  }

  static String dateFormat(String? date) {
    DateTime parseDate = DateFormat(yyyyMMDd, 'en').parse(date ?? '');
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat(ddMMMYyyy, 'en');
    String outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  static Widget noData({String? title}) {
    return Center(
      child: Text(
        title ?? PS.current.noData,
        style: MyTextStyle.montserratMedium(
            color: ColorRes.battleshipGrey, size: 16),
      ),
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
                                // Calculate the position of the animated container along the circle path
                                final angle = _animation.value * 2  * pi;
                                final x = 130.0 * cos(angle) + 180.0;
                                final y = 130.0 * sin(angle) + 175.0;
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