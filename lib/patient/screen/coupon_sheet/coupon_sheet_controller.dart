import 'package:get/get.dart';
import 'package:doclink/patient/model/appointment/coupon.dart';
import 'package:doclink/patient/services/api_service.dart';

class CouponSheetController extends GetxController {
  List<CouponData>? coupons;
  bool isLoading = false;

  @override
  void onInit() {
    fetchCouponApiCall();
    super.onInit();
  }

  void fetchCouponApiCall() {
    isLoading = true;
    PatientApiService.instance.fetchCoupons().then((value) {
      coupons = value.data;
      isLoading = false;
      update();
    });
  }
}
