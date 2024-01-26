import 'dart:developer';

import 'package:doclink/doctor/common/text_button_custom.dart';
import 'package:doclink/doctor/model/appointment/appointment_request.dart';
import 'package:doclink/doctor/model/user/fetch_user_detail.dart';
import 'package:doclink/patient/common/close_button_custom.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/patient/model/doctor/fetch_doctor.dart';
import 'package:doclink/patient/screen/appointment_detail_screen/widget/rating_sheet.dart';
import 'package:doclink/patient/screen/dashboard_screen/dashboard_screen.dart';
import 'package:doclink/patient/screen/home_screen/home_screen.dart';
import 'package:doclink/patient/services/api_service.dart';
import 'package:doclink/utils/font_res.dart';
import 'package:doclink/utils/my_text_style.dart';
import 'package:doclink/utils/update_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:doclink/doctor/common/custom_ui.dart';
import 'package:doclink/doctor/generated/l10n.dart';
import 'package:doclink/doctor/model/chat/appointment_chat.dart';
import 'package:doclink/doctor/screen/message_chat_screen/widget/message_chat_top_bar.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/const_res.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class  PatientLiveVideoCallScreenController extends GetxController{
    int uid = 0;
  int? remoteUserId;
  bool isJoined = false;
  late RtcEngine agoraEngine;
  bool isMuted = true;
  bool isVideo = true;
  bool isRemoteMutedVideo = false;
  bool isRemoteMutedAudio = false;
  int type = 0;
   Map<String,dynamic>? requestData;
  User? user;
  Doctor? doctor;
  PatientLiveVideoCallScreenController(this.requestData,this.user, this.doctor);
  TextEditingController ratingController = TextEditingController();
  double? ratingCount;

  @override
  void onReady() {
    setupVideoSDKEngine();
    super.onReady();
  }

  Future<void> setupVideoSDKEngine() async {
    await [Permission.microphone, Permission.camera].request();
    //CustomUi.loader();
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine
        .initialize(const RtcEngineContext(appId: ConstRes.agoraAppId));
    await agoraEngine.enableVideo();

    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          isJoined = true;
          update();
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          remoteUserId = remoteUid;
          type = 0;
          update();
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          type = 1;
          update();
          leave();
        },
        onUserMuteVideo: (connection, remoteUid, muted) {
          isRemoteMutedVideo = muted;
          update();
          log('🛑 $muted');
        },
        onUserMuteAudio: (connection, remoteUid, muted) {
          isRemoteMutedAudio = muted;
          update();
        },
      ),
    );
    join();
  }

  void join() async {
    String token = requestData?['token'] ?? '';
    String channelId = requestData?['channelId'] ?? '';
    await agoraEngine.startPreview();
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    await agoraEngine.joinChannel(
      token: token,
      channelId: channelId,
      options: options,
      uid: uid,
    );
    //Get.back();
  }

  void leave() {
    if (type == 0) {
      Get.dialog(ConfirmationDialog(
        onPositiveBtn: () {
          channelLeave(true);
        },
        title: PS.current.areYouSure,
        positiveText: PS.current.exit,
        positiveTextColor: ColorRes.lightRed,
      ));
    } else if (type == 1) {
      channelLeave(true);
    } else {
      channelLeave(false);
    }
  }

  channelLeave(bool value) {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    agoraEngine.leaveChannel().then((v) {
      isJoined = false;
      remoteUserId == null;
      //Get.back(result: value);
    Get.bottomSheet(
      Wrap(
      children: [
        Container(
          padding:
              const EdgeInsets.only(top: 30, left: 15, right: 15, bottom: 10),
          margin: EdgeInsets.only(top: AppBar().preferredSize.height * 2),
          decoration: const BoxDecoration(
            color: ColorRes.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          PS.current.addRatings,
                          style: MyTextStyle.montserratExtraBold(
                              size: 20, color: ColorRes.charcoalGrey),
                        ),
                        Text(
                          PS.current.shareYourExperienceEtc,
                          style: MyTextStyle.montserratLight(
                              size: 16, color: ColorRes.davyGrey),
                        ),
                        SizedBox(height: 10,),
                         Text(
                          'Thank you for the call and the doctor will send over details/prescriptions soon.',
                          style: MyTextStyle.montserratLight(
                              size: 16, color: ColorRes.davyGrey),
                        ),
                      ],
                    ),
                  ),
                 InkWell(
      onTap: () {
      Get.dialog(BackdropFilter(
      filter: const ColorFilter.srgbToLinearGamma(),
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 50),
        child: AspectRatio(
          aspectRatio: 1 / 0.5,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                  S.current.appName,
                  style: const TextStyle(
                      fontSize: 24,
                      fontFamily: FontRes.black,
                      color: ColorRes.charcoalGrey),
                ),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                  text: const TextSpan(
                      text: "Message",
                      style: const TextStyle(
                          color: ColorRes.davyGrey,
                          fontSize: 16,
                          fontFamily: FontRes.medium),
                      children: [
                        TextSpan(
                            text: '\n Please go to appointments section to download prescription.',
                            style: const TextStyle(
                              color: ColorRes.battleshipGrey,
                              fontSize: 13,
                            )),
                      ]),
                ),
                const Spacer(),
                Row(
                  children: [
                    
                    InkWell(
                      onTap: (){
                        Get.back();
                        Get.back();
                     Get.back();
                     Get.back();
                     Get.back();
                     Get.back();
                     Get.back();
                     Get.back();
                     Get.back();
                     Get.back();
                      },
                      child: Text(
                        "OK",
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: FontRes.medium,
                          color: ColorRes.tuftsBlue,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    ));
      },
      child: Container(
        height: 37,
        width: 37,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorRes.havelockBlue.withOpacity(0.1)),
        child: const Icon(
          Icons.close_rounded,
          color: ColorRes.charcoalGrey,
          size: 18,
        ),
      ),
    )
                ],
              ),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                itemCount: 5,
                itemSize: 30,
                unratedColor: ColorRes.silverChalice,
                glowColor: Colors.transparent,
                itemPadding: const EdgeInsets.only(
                    left: 1, top: 50, right: 1, bottom: 15),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: ColorRes.mangoOrange,
                ),
                onRatingUpdate: (rating) {
                ratingCount = rating;
              },
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                          color: ColorRes.snowDrift,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: ratingController,
                        expands: true,
                        minLines: null,
                        maxLines: null,
                        maxLength: 200,
                        onChanged: onRatingChange,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(15),
                            isDense: true,
                            counterText: ''),
                        style: MyTextStyle.montserratMedium(
                            size: 15, color: ColorRes.battleshipGrey),
                        cursorColor: ColorRes.battleshipGrey,
                        cursorHeight: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${ratingController.text.length}/$ratingLength',
                      style: MyTextStyle.montserratRegular(
                          size: 17, color: ColorRes.davyGrey),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SafeArea(
                top: false,
                child: TextButtonCustom(
                    onPressed: () {
                    AppointmentData? appointmentData = AppointmentData.fromJson(requestData?['appointmentData']);
                if (ratingCount == null) {
                  return CustomUi.snackBar(
                      message: PS.current.pleaseAtLeastRatingAdd,
                      iconData: Icons.star_rate_rounded);
                }
                if (ratingController.text.isEmpty) {
                  return CustomUi.snackBar(
                      message: PS.current.pleaseAddComment,
                      iconData: Icons.comment_bank_rounded);
                }
                PatientApiService.instance
                    .addLiveCallRating(
                        appointmentId: appointmentData.id,
                        comment: ratingController.text,
                        rating: ratingCount?.toInt(),
                        userId: appointmentData.userId)
                    .then(
                  (value) {
                    if (value.status == true) {
                     Get.back();
                     Get.dialog(
                      BackdropFilter(
      filter: const ColorFilter.srgbToLinearGamma(),
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 50),
        child: AspectRatio(
          aspectRatio: 1 / 0.5,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                  S.current.appName,
                  style: const TextStyle(
                      fontSize: 24,
                      fontFamily: FontRes.black,
                      color: ColorRes.charcoalGrey),
                ),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                  text: const TextSpan(
                      text: "Message",
                      style: const TextStyle(
                          color: ColorRes.davyGrey,
                          fontSize: 16,
                          fontFamily: FontRes.medium),
                      children: [
                        TextSpan(
                            text: '\n Please go to appointments section to download prescription.',
                            style: const TextStyle(
                              color: ColorRes.battleshipGrey,
                              fontSize: 13,
                            )),
                      ]),
                ),
                const Spacer(),
                Row(
                  children: [
                    
                    InkWell(
                      onTap: (){
                        Get.back();
                         Get.back();
                     Get.back();
                     Get.back();
                     Get.back();
                     Get.back();
                     Get.back();
                     Get.back();
                                          Get.back();
                      },
                      child: Text(
                        "OK",
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: FontRes.medium,
                          color: ColorRes.tuftsBlue,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    ));
                      CustomUi.snackBar(
                        isVideoCall: true,
                          iconData: Icons.star_rate_rounded,
                          message: '${value.message}',
                          positive: true);
                      update();
                    } else {
                      CustomUi.snackBar(
                          message: value.message ?? '',
                          iconData: Icons.star_rate_rounded);
                    }
                  },
                );
              },
                    title: PS.current.submit,
                    titleColor: ColorRes.white,
                    backgroundColor: ColorRes.darkSkyBlue),
              )
            ],
          ),
        ),
      ],
    ),
    isScrollControlled: true,
    isDismissible: false
    ).then((value) {
      ratingCount = null;
      ratingController.text = '';
    });
    });
  }
  void onRatingChange(String value) {
    update();
  }
  void muteUnMute() async {
    if (isMuted) {
      isMuted = false;
      await agoraEngine.enableLocalAudio(false);
    } else {
      isMuted = true;
      await agoraEngine.enableLocalAudio(true);
    }
    update();
  }

  void videoDisable() async {
    if (isVideo) {
      isVideo = false;
      await agoraEngine.enableLocalVideo(false);
    } else {
      isVideo = true;
      await agoraEngine.enableLocalVideo(true);
    }
    update();
  }

  @override
  void onClose() async {
    await agoraEngine.leaveChannel();
    agoraEngine.release();
    super.onClose();
  }
}