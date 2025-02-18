import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doclink/patient/common/chat_widget/chat_date_formate.dart';
import 'package:doclink/patient/common/chat_widget/chat_image_card.dart';
import 'package:doclink/patient/common/chat_widget/chat_video_card.dart';
import 'package:doclink/patient/common/chat_widget/msg_text_card.dart';
import 'package:doclink/patient/model/chat/appointment_chat.dart';
import 'package:doclink/patient/model/user/registration.dart';
import 'package:doclink/patient/screen/appointment_chat_screen/widget/video_call_card.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/firebase_res.dart';

class CenterAreaChat extends StatelessWidget {
  final ScrollController scrollController;
  final List<AppointmentChat> chatData;
  final RegistrationData? user;
  final Function(AppointmentChat data) onJoinMeeting;

  const CenterAreaChat(
      {Key? key,
      required this.scrollController,
      required this.chatData,
      this.user,
      required this.onJoinMeeting})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            itemCount: chatData.length,
            padding: EdgeInsets.zero,
            reverse: true,
            itemBuilder: (context, index) {
              AppointmentChat data = chatData[index];
              return data.senderUser?.identity ==
                      '${FirebaseRes.pt}${user?.identity}'
                  ? _yourMsg(data)
                  : _otherMsg(
                      data,
                    );
            },
          ),
        ),
      ),
    );
  }

  _yourMsg(AppointmentChat data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        data.msgType == FirebaseRes.text
            ? MsgTextCard(
                msg: data.msg ?? '',
                cardColor: ColorRes.whiteSmoke,
                textColor: ColorRes.davyGrey)
            : data.msgType == FirebaseRes.image
                ? ChatImageCard(
                    imageUrl: data.image,
                    time: data.id,
                    imageCardColor: ColorRes.whiteSmoke,
                    margin: EdgeInsets.only(
                      left: Get.width / 2.3,
                    ),
                    msg: data.msg,
                    imageTextColor: ColorRes.davyGrey)
                : ChatVideoCard(
                    imageUrl: data.image,
                    time: data.id,
                    margin: EdgeInsets.only(
                      left: Get.width / 2.3,
                    ),
                    msg: data.msg,
                    videoUrl: data.video,
                    imageCardColor: ColorRes.whiteSmoke,
                    imageTextColor: ColorRes.davyGrey),
        ChatDateFormat(time: data.id ?? '')
      ],
    );
  }

  _otherMsg(
    AppointmentChat data,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        data.msgType == FirebaseRes.text
            ? MsgTextCard(
                msg: data.msg ?? '',
                cardColor: ColorRes.havelockBlue,
                textColor: ColorRes.white)
            : data.msgType == FirebaseRes.image
                ? ChatImageCard(
                    imageUrl: data.image,
                    time: data.id,
                    msg: data.msg,
                    imageCardColor: ColorRes.havelockBlue,
                    margin: EdgeInsets.only(
                      right: Get.width / 2.3,
                    ),
                    imageTextColor: ColorRes.white)
                : data.msgType == FirebaseRes.video
                    ? ChatVideoCard(
                        imageUrl: data.image,
                        time: data.id,
                        msg: data.msg,
                        margin: EdgeInsets.only(
                          right: Get.width / 2.3,
                        ),
                        videoUrl: data.video,
                        imageCardColor: ColorRes.havelockBlue,
                        imageTextColor: ColorRes.white)
                    : VideoCallCard(data: data, onJoinMeeting: onJoinMeeting),
        ChatDateFormat(time: data.id ?? '')
      ],
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
