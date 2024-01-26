import 'package:doclink/doctor/common/custom_ui.dart';
import 'package:doclink/doctor/common/text_button_custom.dart';
import 'package:doclink/doctor/common/top_bar_area.dart';
import 'package:doclink/doctor/generated/l10n.dart';
import 'package:doclink/doctor/model/appointment/appointment_request.dart';
import 'package:doclink/doctor/model/user/fetch_user_detail.dart';
import 'package:doclink/doctor/screen/accept_reject_screen/accept_reject_screen_controller.dart';
import 'package:doclink/doctor/screen/accept_reject_screen/live_request_accept_reject_controller.dart';
import 'package:doclink/doctor/screen/accept_reject_screen/widget/appointment_detail_card.dart';
import 'package:doclink/doctor/screen/accept_reject_screen/widget/attachment_card.dart';
import 'package:doclink/doctor/screen/accept_reject_screen/widget/previous_appointment.dart';
import 'package:doclink/doctor/screen/accept_reject_screen/widget/problem_card.dart';
import 'package:doclink/doctor/screen/request_screen/widget/request_card.dart';
import 'package:doclink/doctor/service/api_service.dart';
import 'package:doclink/patient/model/doctor/fetch_doctor.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/font_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class LiveRequestAcceptRejectScreen extends StatelessWidget {
  User? user;
  Map<String,dynamic>? requestData;
  LiveRequestAcceptRejectScreen({Key? key, this.user, this.requestData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = LiveRequestController();
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: GetBuilder(
        init: controller,
        builder: (controller){
          var  medical_history = user?.medical_history;
          //print(medical_history);
          var list = user?.medical_history?['Suffer from:'];
          var symptomsList =  requestData?['patient_symptoms'];
          print(symptomsList)
;          return SafeArea(
            top: false,
            child: Column(
              children: [
                TopBarArea(title: user!.fullname.toString()),
                Expanded(
                  child: controller.isLoading
                      ? CustomUi.loaderWidget()
                      : SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              UserCard(
                                  is_matching_request: true,
                                  user: user,
                                   onViewTap: () {}),
                              Container(
                                margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ColorRes.snowDrift,
        borderRadius: BorderRadius.circular(15),
      ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pregnant",
                style: TextStyle(
                  color: ColorRes.battleshipGrey,
                  fontFamily: FontRes.medium,
                  fontSize: 16,
                ),
              ),
              Text(
                medical_history?['Are you pregnant?'] ?? '',
                style: TextStyle(
                  color: ColorRes.tuftsBlue,
                  fontFamily: FontRes.medium,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Receiving Treatment from Doctor:",
                style: TextStyle(
                  color: ColorRes.battleshipGrey,
                  fontFamily: FontRes.medium,
                  fontSize: 16,
                ),
              ),
              Text(
                medical_history?['Recieving treatment from a:'] ?? '',
                style: TextStyle(
                  color: ColorRes.tuftsBlue,
                  fontFamily: FontRes.medium,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    SizedBox(height: 20),
    Text(
      "Other Information:",
      style: TextStyle(
        color: ColorRes.battleshipGrey,
        fontFamily: FontRes.medium,
        fontSize: 16,
      ),
    ),
    Text(
      medical_history?['Other information'] ?? '',
      style: TextStyle(
        color: ColorRes.tuftsBlue,
        fontFamily: FontRes.medium,
        fontSize: 16,
      ),
    ),
    SizedBox(height: 20),
    Text(
      "Suffer From:",
      style: TextStyle(
        color: ColorRes.battleshipGrey,
        fontFamily: FontRes.medium,
        fontSize: 16,
      ),
    ),
    Container(
      height: 200,
      child: list.length == 0
          ? Container()
          : list.length == null
              ? Container()
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
                    crossAxisSpacing: 10,
                    childAspectRatio: 3,
                  ),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 50,
                      child: Text(
                        list?[index] ?? '',
                        style: TextStyle(
                          color: ColorRes.tuftsBlue,
                          fontFamily: FontRes.medium,
                          fontSize: 16,
                        ),
                      ),
                    );
                  },
                ),
    ),
    Text(
      "Symptoms:",
      style: TextStyle(
        color: ColorRes.battleshipGrey,
        fontFamily: FontRes.medium,
        fontSize: 16,
      ),
    ),
    Container(
      height: 200,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
          crossAxisSpacing: 10,
          childAspectRatio: 3,
        ),
        itemCount: symptomsList?.length,
        itemBuilder: (context, index) {
          return Container(
            height: 50,
            child: Text(
              symptomsList?[index] ?? '',
              style: TextStyle(
                color: ColorRes.tuftsBlue,
                fontFamily: FontRes.medium,
                fontSize: 16,
              ),
            ),
          );
        },
      ),
    ),
    SizedBox(height: 10),
  ],
),
                                ),
                              ),
                              
                              // ProblemCard(
                              //     title: S.current.problem,
                              //     description: user?.problem ?? ''),
                            ],
                          ),
                        ),
                ),
                Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 20),
                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: _acceptRejectButton(controller)),
                                          )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _acceptRejectButton(LiveRequestController controller) {
    User? user = User.fromJson(requestData?['sentBy']['data']);
    return Visibility(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: TextButtonCustom(
                      onPressed: () {
                        controller.onRequestDeclineBtnTap(requestData?['id'], requestData?['declinedBy']);
                      },
                      title: S.current.decline,
                      titleColor: ColorRes.lightRed,
                      backgroundColor: ColorRes.pinkLace),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextButtonCustom(
                    onPressed: ()async{
                      var doctor = await DoctorApiService.instance.fetchMyDoctorProfile();
                        controller.onRequestAcceptBtnTap(requestData?['id'], requestData, user,);
                    },
                    title: S.current.accept,
                    titleColor: ColorRes.irishGreen,
                    backgroundColor: ColorRes.irishGreen.withOpacity(0.12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
