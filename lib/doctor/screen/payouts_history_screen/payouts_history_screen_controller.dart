import 'package:doclink/doctor/model/wallet/payout_history.dart';
import 'package:doclink/doctor/service/api_service.dart';
import 'package:get/get.dart';

class PayoutsHistoryScreenController extends GetxController {
  List<PayoutHistoryData>? payoutData;
  bool isLoading = false;

  @override
  void onInit() {
    fetchDoctorPayoutHistoryApiCall();
    super.onInit();
  }

  void fetchDoctorPayoutHistoryApiCall() {
    isLoading = true;
    DoctorApiService.instance.fetchDoctorPayoutHistory().then((value) {
      payoutData = value.data;
      isLoading = false;
      update();
    });
  }
}
