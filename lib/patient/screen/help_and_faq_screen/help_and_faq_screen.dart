import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doclink/patient/common/custom_ui.dart';
import 'package:doclink/patient/common/top_bar_area.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/patient/screen/help_and_faq_screen/help_and_faq_screen_controller.dart';
import 'package:doclink/patient/screen/help_and_faq_screen/widget/center_area.dart';
import 'package:doclink/patient/screen/help_and_faq_screen/widget/list_of_category.dart';

class HelpAndFaqScreen extends StatelessWidget {
  const HelpAndFaqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HelpAndFaqScreenController());
    return Scaffold(
      body: GetBuilder(
        init: controller,
        builder: (context) {
          return Column(
            children: [
              TopBarArea(title: PS.current.helpAndFAQ),
              controller.isLoading
                  ? CustomUi.loaderWidget()
                  : Expanded(
                      child: Column(
                        children: [
                          ListOfCategory(
                              faqs: controller.faqs,
                              onCategoryChange: controller.onCategoryChange,
                              selectedCategory: controller.selectedCategory),
                          CenterArea(
                            faqs: controller
                                    .faqs[controller.selectedCategory].faqs ??
                                [],
                          ),
                        ],
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
