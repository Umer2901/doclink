import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doclink/patient/common/custom_ui.dart';
import 'package:doclink/patient/common/top_bar_area.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/patient/model/doctor/fetch_doctor.dart';
import 'package:doclink/patient/screen/saved_doctor_screen/saved_doctor_screen_controller.dart';
import 'package:doclink/patient/screen/saved_doctor_screen/widget/appointment_shimmer.dart';
import 'package:doclink/patient/screen/saved_doctor_screen/widget/doctor_card.dart';

class SavedDoctorScreen extends StatelessWidget {
  const SavedDoctorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SavedDoctorScreenController());

    return Scaffold(
      body: Column(
        children: [
          TopBarArea(title: PS.current.savedDoctors),
          Expanded(
            child: GetBuilder(
              init: controller,
              builder: (context) {
                return controller.isLoading
                    ? const AppointmentShimmer()
                    : controller.favDoctor == null ||
                            controller.favDoctor!.isEmpty
                        ? CustomUi.noData()
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: controller.favDoctor?.length ?? 0,
                            itemBuilder: (context, index) {
                              Doctor? doc = controller.favDoctor?[index];
                              return DoctorCard(
                                index: index,
                                onTap: () => controller.onNavigateDoctor(doc),
                                doctors: doc,
                                isBookMarkVisible: true,
                                isBookMark: controller.isSaved,
                                onBookMarkTap: (doctorId) {
                                  controller.onBookMarkTap(doctorId);
                                },
                              );
                            },
                          );
              },
            ),
          )
        ],
      ),
    );
  }
}
