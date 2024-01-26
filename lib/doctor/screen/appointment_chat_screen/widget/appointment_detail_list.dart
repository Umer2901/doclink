import 'package:doclink/doctor/common/animate_expansion.dart';
import 'package:doclink/doctor/common/common_fun.dart';
import 'package:doclink/doctor/generated/l10n.dart';
import 'package:doclink/doctor/model/appointment/appointment_request.dart';
import 'package:doclink/doctor/screen/accept_reject_screen/widget/appointment_detail_card.dart';
import 'package:doclink/doctor/screen/request_screen/widget/request_card.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/font_res.dart';
import 'package:flutter/material.dart';

class AppointmentDetailList extends StatelessWidget {
  final AppointmentData? appointmentData;

  const AppointmentDetailList({Key? key, this.appointmentData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(dividerColor: Colors.transparent),
      child: ListTileTheme(
        dense: true,
        contentPadding: const EdgeInsets.all(0),
        child: ExpansionTile(
          title: Text(
            S.current.appointmentDetails,
            style: const TextStyle(
                color: ColorRes.charcoalGrey,
                fontSize: 14,
                fontFamily: FontRes.medium),
          ),
          collapsedBackgroundColor: ColorRes.whiteSmoke,
          iconColor: ColorRes.davyGrey,
          backgroundColor: ColorRes.white,
          tilePadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          children: [
            AnimatedExpansion(
              expand: true,
              child: Column(
                children: [
                  UserCard(
                    user: appointmentData?.user,
                    onViewTap: () {},
                    appointmentData: appointmentData,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: ColorRes.whiteSmoke,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AppointmentCardFiled(
                            title: S.current.date,
                            desc:
                                CommonFun.dateFormat(appointmentData?.date, 2)),
                        AppointmentCardFiled(
                            title: S.current.time,
                            desc: CommonFun.convert24HoursInto12Hours(
                                appointmentData?.time)),
                        AppointmentCardFiled(
                            title: S.current.type,
                            desc: appointmentData?.type == 0
                                ? S.current.online
                                : S.current.atClinic),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
