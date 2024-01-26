import 'dart:developer';

import 'package:doclink/doctor/model/appointment/appointment_request.dart';
import 'package:doclink/doctor/model/user/fetch_user_detail.dart';
import 'package:doclink/doctor/screen/accept_reject_screen/accept_reject_screen.dart';
import 'package:doclink/doctor/screen/dashboard_screen/dashboard_screen.dart';
import 'package:doclink/doctor/screen/medical_prescription_screen/medical_prescription_screen.dart';
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

class LiveVideoCallScreenController extends GetxController{
   int uid = 0;
  int? remoteUserId;
  bool isJoined = false;
  late RtcEngine agoraEngine;
  bool isMuted = true;
  bool isVideo = true;
  bool isRemoteMutedVideo = false;
  bool isRemoteMutedAudio = false;
  int type = -1;
  Map<String,dynamic>? requestData;
  User? user;
  LiveVideoCallScreenController(this.requestData, this.user);

  @override
  void onReady()async{
    await setupVideoSDKEngine();
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
          log('🔙 $remoteUid');
          type = 1;
          update();
           Future.delayed(Duration(seconds: 2), () {
    leave();
  });
        },
        onUserMuteVideo: (connection, remoteUid, muted) {
          isRemoteMutedVideo = muted;
          update();
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
        title: '${S.current.areYouSure} ${S.current.youEndMeeting}',
        positiveText: S.current.end,
        positiveTextColor: ColorRes.lightRed,
      ));
    } else {
      channelLeave(false);
    }
  }

  void onEndBtnClick() {
    Get.dialog(ConfirmationDialog(
      onPositiveBtn: () {
        channelLeave(true);
      },
      title:
          "${S.current.areYouSure}\n${type == 0 ? S.current.youEndMeeting : S.current.onceYouLeaveChannelYouEtc}",
      positiveText: S.current.endMeeting,
      positiveTextColor: ColorRes.lightRed,
      aspectRatio: type == 0 ? 1 / 0.5 : 1 / 0.6,
    ));
  }

  channelLeave(bool value) {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    agoraEngine.leaveChannel().then((v)async{
      isJoined = false;
      remoteUserId == null;
      print(requestData);
      CustomUi.loader();
      AppointmentData? data = AppointmentData.fromJson(requestData?['appointmentData']);
      Get.delete<LiveVideoCallScreenController>();
     Future.delayed(Duration(seconds: 2), () {
  Get.to(() => MedicalPrescriptionScreen(isVideoCall: true,), arguments: data);
});
    });
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