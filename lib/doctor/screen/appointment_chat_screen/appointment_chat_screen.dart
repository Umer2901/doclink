import 'package:doclink/doctor/common/chat_widget/chat_bottom_text_filed.dart';
import 'package:doclink/doctor/common/fancy_button.dart';
import 'package:doclink/doctor/common/top_bar_area.dart';
import 'package:doclink/doctor/screen/appointment_chat_screen/appointment_chat_screen_controller.dart';
import 'package:doclink/doctor/screen/appointment_chat_screen/widget/appointment_detail_list.dart';
import 'package:doclink/doctor/screen/appointment_chat_screen/widget/center_area_chat.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AppointmentChatScreen extends StatelessWidget {
  const AppointmentChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppointmentChatScreenController());

    return Scaffold(
      backgroundColor: ColorRes.white,
      body: GestureDetector(
        onTap: controller.allScreenTap,
        child: Stack(
          children: [
            Column(
              children: [
                TopBarArea(
                  title: controller.appointmentData?.appointmentNumber ?? '',
                  isMoreBtnVisible: true,
                  onVideoCallTap: controller.onVideoCallBtnTap,
                ),
                const SizedBox(
                  height: 5,
                ),
                AppointmentDetailList(
                    appointmentData: controller.appointmentData),
                GetBuilder(
                  init: controller,
                  builder: (context) {
                    return CenterAreaChat(
                      chatData: controller.chatData,
                      scrollController: controller.scrollController,
                      doctorData: controller.appointmentData?.doctor,
                      onJoinMeeting: controller.onJoinMeeting,
                    );
                  },
                ),
                ChatBottomTextFiled(
                  onSendTap: controller.sendTextMsg,
                  onTextFiledTap: controller.onTextFiledTap,
                  msgController: controller.msgController,
                  msgFocusNode: controller.msgFocusNode,
                ),
              ],
            ),
            Positioned(
              right: Directionality.of(context) == TextDirection.rtl ? null : 6,
              bottom: 3,
              left: Directionality.of(context) == TextDirection.rtl ? 6 : null,
              child: SafeArea(
                top: false,
                child: GetBuilder(
                  init: controller,
                  builder: (context) {
                    return FancyButton(
                      key: controller.key,
                      onCameraTap: () =>
                          controller.onImageTap(source: ImageSource.camera),
                      onGalleryTap: () =>
                          controller.onImageTap(source: ImageSource.gallery),
                      onVideoTap: controller.onVideoTap,
                      msgFocusNode: controller.msgFocusNode,
                      isOpen: controller.isOpen,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
