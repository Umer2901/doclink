import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doclink/patient/common/custom_ui.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/patient/model/appointment/fetch_appointment.dart';
import 'package:doclink/patient/screen/appointment_screen/appointment_screen_controller.dart';
import 'package:doclink/patient/screen/appointment_screen/widget/appointment_card.dart';

class Appointments extends StatelessWidget {
  final AppointmentScreenController controller;

  const Appointments({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (controller) {
        return Expanded(
          child: controller.isLoading
              ? CustomUi.loaderWidget()
              : controller.appointmentData == null ||
                      controller.appointmentData!.isEmpty
                  ? CustomUi.noData(title: PS.current.noAppointmentsAvailable)
                  : ListView.builder(
                      itemCount: controller.appointmentData?.length ?? 0,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        AppointmentData? data =
                            controller.appointmentData?[index];
                        return InkWell(
                          onTap: () => controller.onAppointmentCardTap(data),
                          child: AppointmentCard(appointmentData: data),
                        );
                      },
                    ),
        );
      },
    );
  }
}
