import 'package:flutter/material.dart';
import 'package:doclink/patient/common/appointment_payment_filed.dart';
import 'package:doclink/patient/common/custom_ui.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/patient/model/appointment/coupon.dart';
import 'package:doclink/patient/model/custom/categories.dart';
import 'package:doclink/patient/model/global/taxes.dart';
import 'package:doclink/patient/screen/confirm_booking_screen/confirm_booking_screen_controller.dart';
import 'package:doclink/patient/screen/confirm_booking_screen/widget/booking_top_card.dart';
import 'package:doclink/utils/asset_res.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/extention.dart';
import 'package:doclink/utils/my_text_style.dart';
import 'package:doclink/utils/update_res.dart';

class AppointmentBookingCard extends StatelessWidget {
  final bool isApplyCouponVisible;
  final AppointmentDetail? detail;
  final List<CouponData>? coupons;
  final ConfirmBookingScreenController? controller;

  const AppointmentBookingCard({
    Key? key,
    this.isApplyCouponVisible = true,
    this.coupons,
    this.detail,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: ColorRes.snowDrift,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BookingTopCard(
                  title: PS.current.date,
                  value: CustomUi.dateFormat(detail?.date)),
              BookingTopCard(
                  title: PS.current.time,
                  value: CustomUi.convert24HoursInto12Hours(detail?.time)),
              BookingTopCard(
                title: PS.current.type,
                value: detail?.type == 0 ? PS.current.online : PS.current.clinic,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          AppointmentPaymentFiled(
            title: PS.current.consultationCharge,
            amount: detail?.serviceAmount ?? 0,
            onCancelCoupon: () {},
          ),
          const SizedBox(
            height: 3,
          ),
          Visibility(
            visible: controller?.selectedCoupon != null,
            child: AppointmentPaymentFiled(
              title: PS.current.couponDiscount,
              amount: controller?.discountAmount ?? 0,
              isCouponCodeVisible: true,
              couponCode: controller?.selectedCoupon?.coupon,
              isCloseBtnVisible: true,
              onCancelCoupon: () {
                controller?.onCouponCancel();
              },
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          AppointmentPaymentFiled(
            title: PS.current.subTotal,
            amount: controller?.subTotal ?? 0,
            onCancelCoupon: () {},
            color: ColorRes.tuftsBlue,
            titleColor: ColorRes.white,
            discountColor: ColorRes.white,
          ),
          const SizedBox(
            height: 3,
          ),
          Visibility(
            visible: controller?.taxes != null || controller!.taxes.isNotEmpty,
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: controller?.taxes.length,
              itemBuilder: (context, index) {
                Taxes? tax = controller?.taxes[index];
                return Container(
                  color: ColorRes.aquaHaze,
                  margin: const EdgeInsets.only(bottom: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: '${tax?.taxTitle} ',
                              style: MyTextStyle.montserratMedium(
                                  color: ColorRes.davyGrey),
                              children: <TextSpan>[
                                TextSpan(
                                  text: tax?.type == 0
                                      ? '(${tax?.value ?? ''}$percentage)'
                                      : '',
                                  style: MyTextStyle.montserratBold(
                                      color: ColorRes.tuftsBlue, size: 13),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '$dollar${double.parse('${tax?.taxAmount}').numFormat}',
                            style: MyTextStyle.montserratBold(
                                size: 17, color: ColorRes.tuftsBlue),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          AppointmentPaymentFiled(
            title: PS.current.payableAmount,
            amount: controller?.payableAmount ?? 0,
            onCancelCoupon: () {},
            color: ColorRes.charcoalGrey,
            titleColor: ColorRes.white,
            discountColor: ColorRes.white,
          ),
          const SizedBox(
            height: 20,
          ),
          Visibility(
            visible: controller?.selectedCoupon == null,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, bottom: 15, right: 8.0, top: 5),
              child: InkWell(
                onTap: controller?.onApplyCouponTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      AssetRes.icVoucher,
                      width: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      PS.current.applyCoupon,
                      style: MyTextStyle.montserratMedium(
                          size: 13, color: ColorRes.tuftsBlue),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
