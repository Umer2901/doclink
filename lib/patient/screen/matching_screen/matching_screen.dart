import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doclink/doctor/common/custom_ui.dart';
import 'package:doclink/doctor/model/appointment/appointment_detail.dart';
import 'package:doclink/doctor/model/doctorProfile/registration/registration.dart';
import 'package:doclink/doctor/model/user/fetch_user_detail.dart';
import 'package:doclink/patient/common/text_button_custom.dart';
import 'package:doclink/patient/model/doctor/fetch_doctor.dart';
import 'package:doclink/patient/screen/doctor_profile_screen/doctor_profile_screen.dart';
import 'package:doclink/patient/screen/home_screen/home_screen.dart';
import 'package:doclink/patient/screen/live_video_call_screen/live_video_call_screen.dart';
import 'package:doclink/patient/screen/matching_screen/matching_screen_controller.dart';
import 'package:doclink/patient/services/api_service.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/font_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MatchingScreen extends StatefulWidget {
  String documentId;
  MatchingScreen({super.key, this.documentId=''});

  @override
  State<MatchingScreen> createState() => _MatchingScreenState();
}

class _MatchingScreenState extends State<MatchingScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }
  

  void _navigateToNextScreen() {
    navigationTimer = Timer(Duration(seconds: 60), ()async{ 
     var dat = await FirebaseFirestore.instance.collection('UserRequests').doc(widget.documentId).get();
     var data = dat.data();
     Get.to(()=>SheduleAvailablity(requestData : data));
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
          if (data != null && data['acceptedBy'] == null) {
          // The field is null, do something
          return CircularLoader();
        } else {
          // The field is not null, do something else
          Doctor? doctor = Doctor.fromJson(data?['acceptedBy']);
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
class SheduleAvailablity extends StatelessWidget{
  Map<String,dynamic>? requestData;
  SheduleAvailablity({this.requestData});
  @override
  Widget build(BuildContext context) {
      return GetBuilder<MatchingScreenController>(
        init: MatchingScreenController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(onPressed: ()async{
                CustomUi.loader();
                await FirebaseFirestore.instance.collection("UserRequests").doc(requestData?['id']).delete();
                Get.back();
    Get.back();
    Get.back();
    Get.back();
    Get.back();

              }, icon: Icon(Icons.arrow_back)),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                      children: [
                        Text(
                          "No Doctor Available. Kindly shedule your availability so we can notify doctors",
                          style: TextStyle(
                                                                color: ColorRes.black,
                                                                fontFamily: FontRes.semiBold,
                                                                fontSize: 14
                                                              ),
                        ),
                        SizedBox(height: 10,),
                        Card(
                          child: ListTile(
                            title: Text(
                              'Selected Date:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              DateFormat('MMMM dd, yyyy').format(controller.selectedDate),
                            ),
                            onTap: () => controller.selectDate(context),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text(
                              'Selected Time:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              controller.selectedTime.format(context),
                            ),
                            onTap: () => controller.selectTime(context),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextButtonCustom(
                    onPressed: (){
                      controller.notifyDoctors(requestData);
                                        },
                    backgroundColor: ColorRes.tuftsBlue.withOpacity(0.2),
                    title: "Submit",
                    titleColor: ColorRes.tuftsBlue100,
                  )
                      ],
                    ),
                    ),
                  ],
                )
          ),
            ),
          );
        }
      );
  }
}
class NavigateToDoctorProfile extends StatefulWidget {
  Doctor? doctor;
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
      DateTime currentDate = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
      String formattedTime = DateFormat('HH:mm').format(currentDate);
      // Get.to(()=>LiveVideoCallSCreen(
      //   user: widget.user,
      //   doctor: widget.doctor,
      //   requestData: widget.requestData,
      // ), arguments: widget.doctor);
      Get.to(()=>DoctorProfileScreen(), arguments: [widget.doctor, widget.requestData]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
                                                      "Doctor matched we are redirectig you to doctor profile",
                                                      style: TextStyle(
                                                        color: ColorRes.battleshipGrey,
                                                        fontFamily: FontRes.semiBold,
                                                        fontSize: 18
                                                      ),
      )
      ),
    );
  }
}
class CircularLoader extends StatefulWidget {
  @override
  _CircularLoaderState createState() => _CircularLoaderState();
}

class _CircularLoaderState extends State<CircularLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

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
        _controller.forward(from: 0.0);
      }
    });

    _controller.forward();
  }

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
              height: MediaQuery.of(context).size.width, // Adjust height based on the screen width
              child: Stack(
                children: [
                  Positioned(
                    top: 50,
                    right: 0,
                    left: 0,
                    child: OvalBorder(
                      horizontalRadius: MediaQuery.of(context).size.width * 0.4,
                      verticalRadius: MediaQuery.of(context).size.width * 0.4,
                      borderThickness: 20.0,
                      borderColor: Colors.blue[900]!, // Use your desired color
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      final angle = _animation.value * 2 * pi;
                      final x = MediaQuery.of(context).size.width * 0.4 * cos(angle) + MediaQuery.of(context).size.width * 0.5;
                      final y = MediaQuery.of(context).size.width * 0.4 * sin(angle) + MediaQuery.of(context).size.width * 0.45;
                      return Positioned(
                        left: x - MediaQuery.of(context).size.width * 0.1,
                        top: y - MediaQuery.of(context).size.width * 0.1,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.width * 0.2,
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
            SizedBox(height: 20),
            Text(
              'You will meet your doctor in 15 seconds',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black, // Use your desired color
                fontWeight: FontWeight.w600,
              ),
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