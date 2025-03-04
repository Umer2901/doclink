import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:doclink/patient/common/chat_widget/chat_bottom_text_filed.dart';
import 'package:doclink/patient/common/fancy_button.dart';
import 'package:doclink/patient/screen/message_chat_screen/message_chat_screen_controller.dart';
import 'package:doclink/patient/screen/message_chat_screen/widget/message_center_area.dart';
import 'package:doclink/utils/color_res.dart';

import 'widget/message_chat_top_bar.dart';

class MessageChatScreen extends StatelessWidget {
  const MessageChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MessageChatScreenController());
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: GestureDetector(
        onTap: controller.allScreenTap,
        child: Stack(
          children: [
            Column(
              children: [
                GetBuilder(
                    init: controller,
                    builder: (context) {
                      return MessageChatTopBar(
                        conversation: controller.conversation,
                        controller: controller,
                      );
                    }),
                GetBuilder(
                  init: controller,
                  builder: (context) {
                    return MessageCenterArea(
                      scrollController: controller.scrollController,
                      chatData: controller.chatData,
                      userData: controller.userData,
                      onLongPress: controller.onLongPress,
                      timeStamp: controller.timeStamp,
                    );
                  },
                ),
                ChatBottomTextFiled(
                  msgController: controller.msgController,
                  onSendTap: controller.onSendBtnTap,
                  onTextFiledTap: controller.onTextFiledTap,
                ),
              ],
            ),
            Positioned(
              right: Directionality.of(context) == TextDirection.rtl ? null : 6,
              bottom: 4,
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
