import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doclink/doctor/generated/l10n.dart';
import 'package:doclink/doctor/model/user/fetch_user_detail.dart';
import 'package:doclink/doctor/service/api_service.dart';
import 'package:doclink/patient/model/appointment/fetch_appointment.dart';
import 'package:doclink/patient/screen/live_video_call_screen/live_video_call_screen.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/font_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doclink/patient/common/custom_ui.dart';
import 'package:doclink/patient/model/appointment/coupon.dart';
import 'package:doclink/patient/model/custom/categories.dart';
import 'package:doclink/patient/model/custom/order_summary.dart';
import 'package:doclink/patient/model/doctor/fetch_doctor.dart';
import 'package:doclink/patient/model/global/taxes.dart';
import 'package:doclink/patient/model/user/registration.dart';
import 'package:doclink/patient/screen/appointment_booked_screen/appointment_booked_screen.dart';
import 'package:doclink/patient/screen/coupon_sheet/coupon_sheet.dart';
import 'package:doclink/patient/screen/recharge_wallet_sheet/recharge_wallet_sheet.dart';
import 'package:doclink/patient/services/api_service.dart';
import 'package:doclink/patient/services/patient_pref_service.dart';

class ConfirmBookingScreenController extends GetxController {
  PatientPrefService prefService = PatientPrefService();
  List<CouponData>? coupons;
  AppointmentDetail? detail;
  CouponData? selectedCoupon;
  Doctor? doctorData;
  num serviceAmount = 0;
  num discountAmount = 0;
  num subTotal = 0;
  num payableAmount = 0.round();
  List<Taxes> taxes = [];
  num totalTaxAmount = 0;
  RegistrationData? userData;
  List<dynamic>? arguments;

  @override
  void onInit() {
    prefData();
    detail = Get.arguments[0];
    doctorData = Get.arguments[1];
    arguments = Get.arguments;
    super.onInit();
  }

  void onCouponCancel() {
    selectedCoupon = null;
    discountAmount = 0;
    _taxCalculation(detail?.serviceAmount ?? 0);
  }

  void onApplyCouponTap() {
    Get.bottomSheet(
      CouponSheet(onCouponTap: onCouponTap),
      isScrollControlled: true,
    );
  }

  void onCouponTap(CouponData? couponData) {
    Get.back();
    selectedCoupon = couponData;
    double? couponAmount =
        (serviceAmount * (couponData?.percentage ?? 0)) / 100;
    if (couponAmount > (couponData?.maxDiscountAmount ?? 0)) {
      discountAmount = (couponData?.maxDiscountAmount ?? 0);
    } else {
      discountAmount = couponAmount.round();
    }
    subTotal = serviceAmount - discountAmount;
    _taxCalculation(subTotal);
  }
  Map<String,dynamic>? dta;
  void prefData() async {
    await prefService.init();
    userData = prefService.getRegistrationData();
    taxes = prefService.getSettings()?.taxes ?? [];
    serviceAmount = (detail?.serviceAmount ?? 0);
    _taxCalculation(detail?.serviceAmount ?? 0);
  }

  void _taxCalculation(num taxableAmount) {
    subTotal = taxableAmount;
    totalTaxAmount = 0;
    if (taxes.isNotEmpty) {
      for (int i = 0; i < taxes.length; i++) {
        taxes[i].calculateTaxAmount(taxableAmount);
        totalTaxAmount += taxes[i].taxAmount ?? 0;
      }
    }
    payableAmount = (subTotal + totalTaxAmount).round();
    update();
  }

  void onPayNow() {
    // print(Get.arguments);
    OrderSummary orderSummary = OrderSummary(
      discountAmount: discountAmount,
      coupon: selectedCoupon,
      couponApply: selectedCoupon == null ? 0 : 1,
      payableAmount: payableAmount.round(),
      serviceAmount: serviceAmount,
      subtotal: subTotal,
      totalTaxAmount: num.parse(totalTaxAmount.toStringAsFixed(2)),
      taxes: taxes,
    );
    if ((userData?.wallet ?? 0) >= (payableAmount)) {
      CustomUi.loader();
      PatientApiService.instance
          .addAppointment(
              doctorId: doctorData?.id,
              problem: detail?.problem ?? '',
              date: detail?.date ?? '',
              time: detail?.time ?? '',
              patientId: detail?.patientId,
              orderSummary: orderSummary,
              payableAmount: payableAmount,
              documents: detail?.documents,
              type: detail?.type,
              isCouponApplied: selectedCoupon == null ? 0 : 1,
              discountAmount: discountAmount,
              totalTaxAmount: totalTaxAmount,
              serviceAmount: serviceAmount,
              subTotal: subTotal,
              patient_symptoms: detail?.patient_symptoms,
              )
          .then((value) {
        if (value.status == true) {
        AppointmentData? data = value.data;
        var args = arguments;
          if(args!.length > 2){
            DoctorApiService.instance
        .acceptAppointment(appointmentId: data?.id, doctorId: data?.doctorId)
        .then((value)async{
      if (value.status == true) {
       await FirebaseFirestore.instance.collection("UserRequests").doc(args[2]['id']).update({
        "appointmentData" : data?.toJson()
       });
      } else {
        CustomUi.snackBar(iconData: Icons.done_outline, message: "Something went wrog please try again later.");
      }
    });
        args[2]['appointmentData'] = data?.toJson();
        Get.dialog(
          BackdropFilter(
      filter: const ColorFilter.srgbToLinearGamma(),
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                S.current.appName,
                style: const TextStyle(
                    fontSize: 24,
                    fontFamily: FontRes.black,
                    color: ColorRes.charcoalGrey),
              ),
              const SizedBox(
                height: 5,
              ),
              RichText(
                text: TextSpan(
                    text: "Please note completion otp anywhere. This will be required at time of appointment.",
                    style: const TextStyle(
                        color: ColorRes.davyGrey,
                        fontSize: 16,
                        fontFamily: FontRes.medium),
                    ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                data!.completionOtp.toString(),
                style: const TextStyle(
                    fontSize: 24,
                    fontFamily: FontRes.black,
                    color: ColorRes.charcoalGrey),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: ()async{
                          Get.to(()=>LiveVideoCallSCreen(
            doctor: args[1],
            requestData: args[2],
            user: User.fromJson(args[2]['sentBy']['data']),
          ),
          arguments: args[1]
          );
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Adjust the radius as needed
                          ),
                          backgroundColor: ColorRes.havelockBlue),
                      child: Text(
                        'Copied',
                        style: TextStyle(
                          fontSize: 18,
                          color: ColorRes.white,
        
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    barrierDismissible: false,
        );
          }else{
            Get.offAll(() => const AppointmentBookedScreen(),
              arguments: value.data);
          }
        } else {
          CustomUi.snackBar(
              iconData: Icons.done_outline, message: value.message);
        }
      });
    var args = Get.arguments as List;
    Get.to(()=>LiveVideoCallSCreen(
              doctor: args[1],
              requestData: args[2],
              user: User.fromJson(args[2]['sentBy']['data']),
            ),
            arguments: args[1]
            );
    } else {
      // String value = '';
      // value = (payableAmount - (userData?.wallet ?? 0)).round().toString();
      Get.bottomSheet(
        const RechargeWalletSheet(
          screenType: 2,
        ),
        isScrollControlled: true,
        settings: RouteSettings(arguments: userData?.wallet.toString()),
      ).then(
        (value) async {
          userData = prefService.getRegistrationData();
          update();
        },
      );
    }
  }
}
