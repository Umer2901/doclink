import 'package:cached_network_image/cached_network_image.dart';
import 'package:doclink/doctor/common/common_fun.dart';
import 'package:doclink/doctor/common/custom_ui.dart';
import 'package:doclink/doctor/generated/l10n.dart';
import 'package:doclink/doctor/model/appointment/appointment_request.dart';
import 'package:doclink/doctor/model/user/fetch_user_detail.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/const_res.dart';
import 'package:doclink/utils/extention.dart';
import 'package:doclink/utils/font_res.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final bool isViewVisible;
  final User? user;
  final AppointmentData? appointmentData;
  final VoidCallback onViewTap;
  bool is_medical_history = false;
  bool is_matching_request = false;
  UserCard(
      {Key? key,
      this.isViewVisible = false,
      this.appointmentData,
      this.is_medical_history = false,
      this.user,
      this.is_matching_request = false,
      required this.onViewTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var medical_history = user?.medical_history;
    var suffer_from = medical_history?['Suffer from:'] as List;
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: ColorRes.whiteSmoke, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: user?.profileImage == null ||
                        user!.profileImage!.isEmpty
                    ? CustomUi.userPlaceHolder(
                        height: 70,
                        male: user?.gender ?? 0,
                      )
                    : CachedNetworkImage(
                        imageUrl:
                            '${ConstRes.itemBaseURL}${user?.profileImage}',
                        height: 70,
                        width: 70,
                        fit: BoxFit.cover,
                        errorWidget: (context, error, stackTrace) {
                          return CustomUi.userPlaceHolder(
                            height: 70,
                            male: user?.gender ?? 0,
                          );
                        },
                      ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user?.fullname ?? S.current.unKnown,
                      style: const TextStyle(
                          color: ColorRes.charcoalGrey,
                          fontFamily: FontRes.extraBold,
                          fontSize: 18,
                          overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${user?.dob == null ? '0' : CommonFun.calculateAge(user?.dob ?? '')} ${S.current.years}: ${user?.gender == 1 ? S.current.male : S.current.feMale}",
                      style: const TextStyle(
                          fontFamily: FontRes.medium,
                          color: ColorRes.battleshipGrey,
                          fontSize: 13,
                          overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    is_matching_request == true ? Container() : Text(
                      '${(appointmentData?.date ?? '')} ${(appointmentData?.time ?? '')}',
                      style: const TextStyle(
                          fontFamily: FontRes.medium,
                          color: ColorRes.battleshipGrey,
                          fontSize: 13,
                          overflow: TextOverflow.ellipsis),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: isViewVisible,
                child: InkWell(
                  onTap: onViewTap,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                    decoration: BoxDecoration(
                        color: ColorRes.greenWhite,
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      S.current.view,
                      style: const TextStyle(
                        color: ColorRes.tuftsBlue,
                        fontFamily: FontRes.semiBold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
