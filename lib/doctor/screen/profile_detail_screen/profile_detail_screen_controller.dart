import 'package:doclink/doctor/service/api_service.dart';
import 'package:get/get.dart';

class ProfileDetailScreenController extends GetxController {
  @override
  void onInit() {
    fetchDoctorProfile();
    super.onInit();
  }

  void fetchDoctorProfile() {
    DoctorApiService.instance.fetchMyDoctorProfile();
  }
}
