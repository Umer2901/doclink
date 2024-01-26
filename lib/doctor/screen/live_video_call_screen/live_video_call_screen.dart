import 'dart:ui';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:doclink/doctor/common/custom_ui.dart';
import 'package:doclink/doctor/model/doctorProfile/registration/registration.dart';
import 'package:doclink/doctor/model/user/fetch_user_detail.dart';
import 'package:doclink/doctor/screen/live_video_call_screen/live_video_call_screen_controller.dart';
import 'package:doclink/doctor/screen/live_video_call_screen/widget/bottom_buttom_area.dart';
import 'package:doclink/doctor/screen/live_video_call_screen/widget/top_bar_name_card.dart';
import 'package:doclink/doctor/screen/video_call_screen/widget/video_call_placeholder.dart';
import 'package:doclink/patient/model/doctor/fetch_doctor.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/const_res.dart';
import 'package:doclink/utils/font_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LiveVideoCallSCreen extends StatefulWidget {

  Map<String,dynamic>? requestData;
  User? user;
  DoctorData? doctor;
  LiveVideoCallSCreen({super.key, this.requestData, this.user, this.doctor});

  @override
  State<LiveVideoCallSCreen> createState() => _LiveVideoCallSCreenState();
}

class _LiveVideoCallSCreenState extends State<LiveVideoCallSCreen> {
  @override
  void initState(){
    if(widget.requestData == null){
      CustomUi.snackBar(
                  iconData: Icons.cancel_outlined,
                  positive: false,
                  message: "Request does not exist.");
    }
  }
  @override
  void dispose(){
    super.dispose();
    Get.delete<LiveVideoCallScreenController>();
  }
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LiveVideoCallScreenController(widget.requestData,widget.user));
    return Scaffold(
      backgroundColor: ColorRes.black,
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: GetBuilder(
          init: controller,
          builder: (controller) {
            return Stack(
              children: [
                SizedBox(
                  width: Get.width,
                  height: Get.height,
                  child: controller.remoteUserId != null
                      ? Stack(
                          children: [
                            controller.isRemoteMutedVideo ||
                                    controller.type == 1

                                /// If remote user mute video and left the meeting ///
                                ? RemotePlaceHolder(
                                    image: widget.user?.profileImage ??
                                        '',
                                    name: widget.user?.fullname ??
                                        '',
                                    widget: const SizedBox())

                                /// If Remote User enter ///
                                : AgoraVideoView(
                                    controller: VideoViewController.remote(
                                      rtcEngine: controller.agoraEngine,
                                      canvas: VideoCanvas(
                                          uid: controller.remoteUserId),
                                      connection: RtcConnection(
                                          channelId: widget.requestData?['channelId']
                                          ),
                                    ),
                                  ),

                            /// Remote user mute video, left meeting, and mute audio ///
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Row(),
                                controller.isRemoteMutedVideo
                                    ? ClipOval(
                                        child: Image.network(
                                          '${ConstRes.itemBaseURL}${widget.user?.profileImage}',
                                          width: 100,
                                          height: 100,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return BlurImageTextCard(
                                                name: widget.user?.fullname ??
                                                    '');
                                          },
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : const SizedBox(),
                                const SizedBox(
                                  height: 10,
                                ),
                                controller.type == 1
                                    ? BlurTextCard(
                                        name:
                                            '${widget.user?.fullname ?? ''} Left the meeting')
                                    : !controller.isRemoteMutedAudio
                                        ? const SizedBox()
                                        : BlurTextCard(
                                            name:
                                                '${widget.user?.fullname ?? ''} Mute the Audio'),
                              ],
                            )
                          ],
                        )

                      /// If remote user not enter the meeting ///
                      : RemotePlaceHolder(
                          image: widget.user?.profileImage ?? '',
                          name:
                              widget.user?.fullname ?? '',
                          widget: BlurTextCard(
                              name:
                                  'Waiting for ${widget.user?.fullname ?? ''}')),
                ),
                SafeArea(
                  child: Column(
                    children: [
                      TopBarNameCard(controller: controller),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 105,
                          height: 138,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: controller.isJoined

                              /// I am enter the meeting ///
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: controller.isVideo
                                      ? AgoraVideoView(
                                          controller: VideoViewController(
                                            rtcEngine: controller.agoraEngine,
                                            canvas: const VideoCanvas(uid: 0),
                                          ),
                                        )
                                      : LocalPlaceHolder(
                                          image:
                                              '${widget.doctor?.image}',
                                          name: widget.doctor?.name
                                                  ?.replaceAll('Dr.', '')
                                                  .trim()[0] ??
                                              ''),
                                )

                              /// I am not enter the meeting ///
                              : LocalPlaceHolder(
                                  image: '${widget.doctor?.name}',
                                  name: widget.doctor?.name
                                          ?.replaceAll('Dr.', '')
                                          .trim()[0] ??
                                      ''),
                        ),
                      ),
                      const Spacer(),
                      BottomButtonArea(controller: controller)
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class BlurImageTextCard extends StatelessWidget {
  final String name;

  const BlurImageTextCard({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: ColorRes.grey.withOpacity(0.5)),
      alignment: Alignment.center,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Text(
          name,
          // style: MyTextStyle.montserratBlack(color: ColorRes.white, size: 35),
          style: const TextStyle(
              color: ColorRes.white, fontSize: 35, fontFamily: FontRes.black),
        ),
      ),
    );
  }
}

class BlurTextCard extends StatelessWidget {
  final String name;

  const BlurTextCard({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(color: ColorRes.grey.withOpacity(0.5)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Text(
            name,
            style: const TextStyle(
                fontFamily: FontRes.light, color: ColorRes.white, fontSize: 12),
          ),
        ),
      ),
    );
  }
}