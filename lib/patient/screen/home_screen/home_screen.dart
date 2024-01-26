import 'package:doclink/patient/screen/specialists_screen/specialists_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doclink/patient/common/category_card.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/patient/model/doctor/fetch_doctor.dart';
import 'package:doclink/patient/screen/home_screen/home_screen_controller.dart';
import 'package:doclink/patient/screen/home_screen/widget/best_doctor_profile_card.dart';
import 'package:doclink/patient/screen/home_screen/widget/home_top_area.dart';
import 'package:doclink/patient/screen/home_screen/widget/today_appointment.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/my_text_style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController());
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GetBuilder(
            init: controller,
            builder: (context) {
              return HomeTopArea(
                userData: controller.userData,
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GetBuilder(
                      init: controller,
                      builder: (context) {
                        return TodayAppointment(
                          appointments: controller.appointments,
                        );
                      }),
                  GetBuilder(
                      init: controller,
                      builder: (context) {
                        return _categoryTitle(
                            title: PS.current.findBySpecialities,
                            onTap: () {
                              Get.to(()=>SpecialistsScreen());
                            },
                            viewAllVisibility: false);
                      }),
                  GetBuilder(
                    init: controller,
                    builder: (controller) {
                      return GridView.builder(
                        itemCount: (controller.categories?.length ?? 0) > 4
                            ? 4
                            : controller.categories?.length,
                        shrinkWrap: true,
                        primary: false,
                        padding: const EdgeInsets.all(7),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 180
                                ),
                        itemBuilder: (context, index) {
                          return CategoryCard(
                            onTap: () =>
                                controller.onSpecialistsDetailScreenNavigate(
                                    controller.categories?[index]),
                            categories: controller.categories?[index],
                          );
                        },
                      );
                    },
                  ),
                   Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: ()async{
                           await controller.finddoctor();
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Adjust the radius as needed
                            ),
                            backgroundColor: ColorRes.havelockBlue),
                        child: Text(
                          'Find A Doctor',
                          style: TextStyle(
                            fontSize: 18,
                            color: ColorRes.white,

                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                ),
                  GetBuilder(
                    init: controller,
                    builder: (context) {
                      return ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: controller.categories?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Visibility(
                            visible: (controller.categories?[index].doctors ==
                                        null ||
                                    controller
                                        .categories![index].doctors!.isEmpty)
                                ? false
                                : true,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                _categoryTitle(
                                    title:
                                        (controller.categories?[index].title ??
                                                    '')
                                                .capitalizeFirst ??
                                            '',
                                    onTap: () => controller
                                        .onSpecialistsDetailScreenNavigate(
                                            controller.categories?[index]),
                                    viewAllVisibility: (controller
                                                    .categories?[index]
                                                    .doctors
                                                    ?.length ??
                                                0) >
                                            2
                                        ? true
                                        : false),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: Get.width / 1.8,
                                  width: double.infinity,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: controller.categories?[index]
                                            .doctors?.length ??
                                        0,
                                    itemBuilder: (context, doctorIndex) {
                                      Doctor? d = controller.categories?[index]
                                          .doctors?[doctorIndex];
                                      return BestDoctorProfileCard(
                                        doctor: d,
                                        onDoctorCardTap:
                                            controller.onDoctorCardTap,
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryTitle(
      {required String title,
      required VoidCallback onTap,
      bool viewAllVisibility = true}) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              style: MyTextStyle.montserratRegular(
                  size: 15, color: ColorRes.battleshipGrey),
            ),
          ),
          Visibility(
            visible: viewAllVisibility,
            child: InkWell(
              onTap: onTap,
              child: Text(
                PS.current.viewAll,
                style: MyTextStyle.montserratSemiBold(
                    size: 15, color: ColorRes.charcoalGrey),
              ),
            ),
          )
        ],
      ),
    );
  }
}
