import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doclink/patient/common/custom_ui.dart';
import 'package:doclink/patient/common/top_bar_area.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/patient/model/wallet/withdraw_request.dart';
import 'package:doclink/patient/screen/withdraw_history_screen/withdraw_history_screen_controller.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/extention.dart';
import 'package:doclink/utils/my_text_style.dart';
import 'package:doclink/utils/update_res.dart';

class WithdrawHistoryScreen extends StatelessWidget {
  const WithdrawHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WithdrawHistoryScreenController());
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: Column(
        children: [
          TopBarArea(title: PS.current.withdrawRequests),
          Expanded(
            child: GetBuilder(
              init: controller,
              builder: (context) {
                return SafeArea(
                  top: false,
                  child: controller.withdrawData == null ||
                          controller.withdrawData!.isEmpty
                      ? CustomUi.noData(
                          title: PS.current.noWithdrawRequestAvailable)
                      : ListView.builder(
                          itemCount: controller.withdrawData?.length ?? 0,
                          padding: const EdgeInsets.only(top: 3),
                          itemBuilder: (context, index) {
                            WithdrawRequestData? data =
                                controller.withdrawData?[index];
                            return Container(
                              width: double.infinity,
                              color: ColorRes.whiteSmoke,
                              margin: const EdgeInsets.symmetric(vertical: 3),
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data?.requestNumber ?? '',
                                          style: MyTextStyle.montserratSemiBold(
                                            color: ColorRes.havelockBlue,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          '${PS.current.account}: ${data?.accountNumber ?? ''}',
                                          style: MyTextStyle.montserratRegular(
                                              color: ColorRes.charcoalGrey,
                                              size: 14),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          (data?.createdAt ?? createdDate)
                                              .dateParse(ddMmmmYyyyHhMmA),
                                          style: MyTextStyle.montserratRegular(
                                              color: ColorRes.charcoalGrey,
                                              size: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        '$dollar${data?.amount ?? 0}',
                                        style: MyTextStyle.montserratBold(
                                            color: ColorRes.battleshipGrey,
                                            size: 18),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 7),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: (data?.status == 0
                                                    ? ColorRes.pastelOrange
                                                    : data?.status == 1
                                                        ? ColorRes.irishGreen
                                                        : ColorRes.lightRed)
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(
                                          data?.status == 0
                                              ? PS.current.pending
                                              : data?.status == 1
                                                  ? PS.current.completed
                                                  : PS.current.rejected,
                                          style: MyTextStyle.montserratMedium(
                                              color: data?.status == 0
                                                  ? ColorRes.pastelOrange
                                                  : data?.status == 1
                                                      ? ColorRes.irishGreen
                                                      : ColorRes.lightRed,
                                              size: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
