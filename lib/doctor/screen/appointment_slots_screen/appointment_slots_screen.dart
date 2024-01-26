import 'package:doclink/doctor/common/common_fun.dart';
import 'package:doclink/doctor/common/custom_ui.dart';
import 'package:doclink/doctor/common/settings_filed_top_bar.dart';
import 'package:doclink/doctor/common/top_bar_area.dart';
import 'package:doclink/doctor/generated/l10n.dart';
import 'package:doclink/doctor/model/doctorProfile/registration/registration.dart';
import 'package:doclink/doctor/screen/appointment_slots_screen/appointment_slots_screen_controller.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/font_res.dart';
import 'package:doclink/utils/update_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentSlotsScreen extends StatelessWidget {
  const AppointmentSlotsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppointmentSlotsScreenController());
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: Column(
        children: [
          TopBarArea(title: S.current.appointmentSlots),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SettingsFiledTopBar(
                      title1: S.current.addAppointmentSlotsByWeekDays,
                      title2: S.current.ifYouHaveAddedOnlyEtc),
                  _slotCard(controller),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _slotCard(AppointmentSlotsScreenController controller) {
    return GetBuilder(
      init: controller,
      builder: (context) {
        return controller.isLoading
            ? CustomUi.loaderWidget()
            : SafeArea(
                top: false,
                child: ListView.builder(
                  itemCount: controller.appointmentSlot.length,
                  primary: false,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, weekIndex) {
                    return Container(
                      color: ColorRes.snowDrift,
                      margin: const EdgeInsets.symmetric(vertical: 7),
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                controller.appointmentSlot[weekIndex].name,
                                style: const TextStyle(
                                  fontFamily: FontRes.semiBold,
                                  fontSize: 14,
                                  letterSpacing: 0.5,
                                  color: ColorRes.charcoalGrey,
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () => controller.addBtnTap(weekIndex),
                                child: Text(
                                  S.current.add,
                                  style: const TextStyle(
                                    fontFamily: FontRes.semiBold,
                                    fontSize: 15,
                                    color: ColorRes.tuftsBlue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: controller
                                    .appointmentSlot[weekIndex].time.isEmpty
                                ? 5
                                : 10,
                          ),
                          GetBuilder(
                            id: kAppointmentDelete,
                            init: controller,
                            builder: (controller) {
                              List<Slots?> time =
                                  controller.appointmentSlot[weekIndex].time;

                              time.sort(
                                (a, b) {
                                  return a!.time!.compareTo('${b?.time}');
                                },
                              );

                              return Wrap(
                                children: List.generate(
                                  time.length,
                                  (index) {
                                    print(time[index]?.time);
                                    return FittedBox(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: ColorRes.greenWhite,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 2, vertical: 2),
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          top: 7,
                                          bottom: 7,
                                          right: 8,
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              CommonFun
                                                  .convert24HoursInto12Hours(
                                                      time[index]?.time),
                                              style: const TextStyle(
                                                  fontFamily: FontRes.bold,
                                                  fontSize: 15,
                                                  color: ColorRes.tuftsBlue),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            InkWell(
                                              onTap: () => controller
                                                  .deleteSlot(time[index]),
                                              child: Container(
                                                width: 25,
                                                height: 25,
                                                decoration: const BoxDecoration(
                                                    color:
                                                    ColorRes.charcoalGrey,
                                                    shape: BoxShape.circle),
                                                child: const Icon(
                                                  Icons.close_rounded,
                                                  color: ColorRes.white,
                                                  size: 17,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
      },
    );
  }
}
