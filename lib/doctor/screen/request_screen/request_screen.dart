import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doclink/doctor/common/custom_ui.dart';
import 'package:doclink/doctor/common/top_bar_tab.dart';
import 'package:doclink/doctor/generated/l10n.dart';
import 'package:doclink/doctor/model/appointment/appointment_request.dart';
import 'package:doclink/doctor/model/user/fetch_user_detail.dart';
import 'package:doclink/doctor/screen/dashboard_screen/dashboard_screen.dart';
import 'package:doclink/doctor/screen/request_screen/request_screen_controller.dart';
import 'package:doclink/doctor/screen/request_screen/widget/request_card.dart';
import 'package:doclink/doctor/service/doctor_pref_service.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = RequestScreenController();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorRes.whiteSmoke,
          title: Text(
          S.current.requests.toUpperCase(),
          style: const TextStyle(
            color: ColorRes.charcoalGrey,
            fontSize: 17,
          ),
        ),
        bottom: TabBar(tabs: [
          Tab(
            child: Text(
          "Booking Requests",
          style: const TextStyle(
            color: ColorRes.charcoalGrey,
            fontSize: 14,
          ),
        ),
          ),
           Tab(
            child: Text(
          "Live Requests",
          style: const TextStyle(
            color: ColorRes.charcoalGrey,
            fontSize: 14,
          ),
        ),
          )
        ]),
          elevation: 0,
        ),
        body: TabBarView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
              child:  GetBuilder(
                    init: controller,
                    builder: (context) {
                      return controller.isLoading
                          ? CustomUi.loaderWidget()
                          : controller.appointment.isEmpty
                              ? CustomUi.noDataImage(message: S.current.noRequestData)
                              : ListView.builder(
                                  controller: controller.requestController,
                                  itemCount: controller.appointment.length,
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    AppointmentData? data =
                                        controller.appointment[index];
                                    return InkWell(
                                      onTap: () {
                                         controller.onViewTap(data);
                                      },
                                      child: UserCard(
                                        isViewVisible: true,
                                        user: data.user,
                                        onViewTap: () => controller.onViewTap(data),
                                        is_matching_request: false,
                                      ),
                                    );
                                  },
                                );
                    },
                  ),
            ),
            FutureBuilder(
              future: controller.getMydDcotorData(),
              builder: (context,snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return CircularLoader();
                }else{
                  print(controller.currentDoctor!.isOnline);
                  return Container(
                    alignment: Alignment.center,
                   height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: controller.currentDoctor!.isOnline == 1 ? StreamBuilder(
                  stream: FirebaseFirestore.instance
      .collection('UserRequests')
      .where("acceptedBy", isNull: true)
      .where("cat_id", isEqualTo: controller.currentDoctor?.categoryId)
      .where("declinedBy", whereNotIn: [{DoctorPrefService.id.toString(): true},])
      .snapshots(),
                  builder: (context, snapshot) {
                    //print(controller.currentdOctor?.categoryId);
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return CircularLoader();
                    }else{
                      return snapshot.data?.docs.length == 0 ? CustomUi.noDataImage(message: S.current.noRequestData) : ListView.builder(
                                      itemCount: snapshot.data?.docs.length,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                       var pdata = snapshot.data?.docs[index].data();
                                       var data = snapshot.data?.docs[index].get('sentBy');
                                      User? user = User.fromJson(data['data']);
                                      return InkWell(
                                          onTap: () {
                                          },
                                          child: UserCard(
                                            isViewVisible: true,
                                            user: user,
                                            onViewTap: () => controller.ViewRequest(user,pdata),
                                            is_matching_request: true,
                                          ),
                                        );
                                      },
                                    );
                    }
                  },
                ) : controller.currentDoctor!.onVacation == 1 ? CustomUi.noDataImage(message: "You are in vacation mode.")
                   : controller.currentDoctor!.isOnline == 1 ? CustomUi.noDataImage(message: "You are in offline mode. Please enable it to get appointment requests.")
                   : CustomUi.noDataImage(message: S.current.noRequestData)
                );
                }
              }
            )
          ],
        ),
      ),
    );
  }
}
