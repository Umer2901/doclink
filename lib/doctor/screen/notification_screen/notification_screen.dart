import 'package:doclink/doctor/common/custom_ui.dart';
import 'package:doclink/doctor/common/top_bar_tab.dart';
import 'package:doclink/doctor/generated/l10n.dart';
import 'package:doclink/doctor/screen/notification_screen/notification_screen_controller.dart';
import 'package:doclink/doctor/screen/notification_screen/widget/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationScreenController());
    return Column(
      children: [
        TopBarTab(title: S.current.notifications),
        const SizedBox(
          height: 5,
        ),
        Expanded(
          child: GetBuilder(
            init: controller,
            builder: (context) {
              return controller.isLoading
                  ? CustomUi.loaderWidget()
                  : controller.notifications == null ||
                          controller.notifications!.isEmpty
                      ? CustomUi.noDataImage(message: S.current.noData)
                      : ListView.builder(
                          controller: controller.notificationController,
                          itemCount: controller.notifications?.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) => NotificationCard(
                              data: controller.notifications?[index]),
                        );
            },
          ),
        )
      ],
    );
  }
}
