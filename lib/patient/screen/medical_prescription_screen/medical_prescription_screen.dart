import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doclink/patient/common/top_bar_area.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/patient/model/custom/categories.dart';
import 'package:doclink/patient/screen/medical_prescription_screen/medical_prescription_screen_controller.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/my_text_style.dart';

class MedicalPrescriptionScreen extends StatelessWidget {
  const MedicalPrescriptionScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MedicalPrescriptionScreenController());
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBarArea(title: PS.current.medicalPrescription),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    itemCount:
                        controller.medicalPrescription?.addMedicine?.length ??
                            0,
                    primary: false,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      AddMedicine? data =
                          controller.medicalPrescription?.addMedicine?[index];
                      return Container(
                        color: index % 2 != 0
                            ? ColorRes.snowDrift
                            : ColorRes.whiteSmoke,
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data?.title ?? '',
                                        style: MyTextStyle.montserratSemiBold(
                                            size: 15,
                                            color: ColorRes.charcoalGrey),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        data?.mealTime == 0
                                            ? PS.current.afterMeal
                                            : PS.current.beforeMeal,
                                        style: MyTextStyle.montserratSemiBold(
                                            size: 13,
                                            color: ColorRes.battleshipGrey),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        data?.dosage ?? '',
                                        style: MyTextStyle.montserratRegular(
                                            size: 13,
                                            color: ColorRes.battleshipGrey),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${data?.quantity ?? 0}',
                                      style: MyTextStyle.montserratBold(
                                          size: 24,
                                          color: ColorRes.charcoalGrey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Visibility(
                              visible:
                                  (data?.notes == null || data!.notes!.isEmpty)
                                      ? false
                                      : true,
                              child: Container(
                                margin: const EdgeInsets.only(top: 8),
                                child: Text(
                                  data?.notes == null
                                      ? ''
                                      : '${PS.current.notes} :- ${data?.notes}',
                                  style: MyTextStyle.montserratRegular(
                                      size: 13, color: ColorRes.tuftsBlue),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  Visibility(
                    visible: (controller.medicalPrescription?.notes == null ||
                            controller.medicalPrescription!.notes!.isEmpty)
                        ? false
                        : true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            PS.current.notes,
                            style: MyTextStyle.montserratSemiBold(
                                size: 15, color: ColorRes.charcoalGrey),
                          ),
                        ),
                        Container(
                          color: ColorRes.snowDrift,
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            controller.medicalPrescription?.notes ?? '',
                            style: MyTextStyle.montserratMedium(
                              color: ColorRes.nobel,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          GetBuilder(
              init: controller,
              builder: (context) {
                return InkWell(
                  onTap: controller.createPdf,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    decoration: const BoxDecoration(
                        gradient: MyTextStyle.linearTopGradient),
                    alignment: Alignment.center,
                    child: SafeArea(
                      top: false,
                      child: Text(
                        PS.current.downloadPrescription,
                        style: MyTextStyle.montserratSemiBold(
                            size: 17, color: ColorRes.white),
                      ),
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
