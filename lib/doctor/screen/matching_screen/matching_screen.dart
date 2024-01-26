import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doclink/doctor/model/doctorProfile/registration/registration.dart';
import 'package:doclink/doctor/model/user/fetch_user_detail.dart';
import 'package:doclink/doctor/screen/live_video_call_screen/live_video_call_screen.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/font_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorWaitingScreen extends StatefulWidget {
  String documentId;
  DoctorWaitingScreen({super.key, this.documentId=''});

  @override
  State<DoctorWaitingScreen> createState() => _DoctorWaitingScreenState();
}

class _DoctorWaitingScreenState extends State<DoctorWaitingScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    navigationTimer = Timer(Duration(seconds: 150), ()async{ 
      await FirebaseFirestore.instance.collection('UserRequests').doc(widget.documentId).delete();
      Get.back();
      Get.back();
    });
    // Future.delayed(Duration(seconds: 60),(){
    //   Get.to(()=>HomeScreen());
    // });
  }
  Timer? navigationTimer;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('UserRequests').doc(widget.documentId).snapshots(), 
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return CircularLoader();
        }else{
          final data = snapshot.data?.data();
          if (data != null && data['appointmentData'] == null) {
          // The field is null, do something
          return CircularLoader();
        } else {
          // The field is not null, do something else
          DoctorData? doctor = DoctorData.fromJson(data?['acceptedBy']);
          User? user = User.fromJson(data?['sentBy']['data']); 
          navigationTimer?.cancel();
           return NavigateToDoctorProfile(
            user: user,
            doctor: doctor,
            requestData: data,
           );
        }
        }
      },
      );
  }
}
class NavigateToDoctorProfile extends StatefulWidget {
  DoctorData? doctor;
  User? user;
  Map<String,dynamic>? requestData;
  NavigateToDoctorProfile({super.key, this.doctor, this.user, this.requestData});

  @override
  State<NavigateToDoctorProfile> createState() => _NavigateToDoctorProfileState();
}

class _NavigateToDoctorProfileState extends State<NavigateToDoctorProfile> {
   @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    Future.delayed(Duration(seconds: 2), ()async{
      // Get.to(()=>LiveVideoCallSCreen(
      //   user: widget.user,
      //   doctor: widget.doctor,
      //   requestData: widget.requestData,
      // ), arguments: widget.doctor);
      Get.to(()=>LiveVideoCallSCreen(
        requestData: widget.requestData,
        user: widget.user,
        doctor: widget.doctor,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.white
        ),
        child: Center(
          child: Text(
                                                        "Patient connected we are redirecting you to video call.",
                                                        style: TextStyle(
                                                          color: ColorRes.battleshipGrey,
                                                          fontFamily: FontRes.semiBold,
                                                          fontSize: 18
                                                        ),
        )
        ),
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
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
                    SizedBox(height: 20,),
                Text(
                  'Please wait while patient is paying charges and connected',
                  style: TextStyle(
                      fontSize: 14,
                      color: ColorRes.black,
                      fontWeight: FontWeight.w600),
                ),
            ],
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