import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doclink/patient/common/custom_ui.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/patient/model/appointment/fetch_appointment.dart';
import 'package:doclink/patient/screen/medical_prescription_screen/medical_prescription_screen.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/my_text_style.dart';

class MedicalPrescriptionCard extends StatelessWidget {
  final AppointmentData? appointmentData;

  const MedicalPrescriptionCard({Key? key, required this.appointmentData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? medicine = appointmentData?.prescription?.medicine;
    return InkWell(
      onTap: () {
        medicine == null || medicine.isEmpty
            ? CustomUi.snackBar(
                message: PS.current.noMedicalPrescriptionAdd,
                iconData: Icons.medical_information_rounded)
            : Get.to(() => const MedicalPrescriptionScreen(),
                arguments: [medicine, appointmentData, appointmentData?.user]);
      },
      child: Container(
        color: ColorRes.snowDrift,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    PS.current.medicalPrescription,
                    style: MyTextStyle.montserratSemiBold(
                        size: 15, color: ColorRes.charcoalGrey),
                  ),
                  Text(
                    PS.current.drHasSentYouEtc,
                    style: MyTextStyle.montserratRegular(
                        size: 12, color: ColorRes.battleshipGrey),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: ColorRes.tuftsBlue,
            )
          ],
        ),
      ),
    );
  }
}
