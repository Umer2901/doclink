import 'package:get/get.dart';
import 'package:doclink/patient/model/appointment/fetch_appointment.dart';
import 'package:doclink/patient/services/api_service.dart';

class AppointmentBookedScreenController extends GetxController {
  AppointmentData? data;

  @override
  void onInit() {
    data = Get.arguments;
    fetchDoctorApiCall();
    super.onInit();
  }

  void fetchDoctorApiCall() {
    PatientApiService.instance.fetchMyUserDetails();
  }
}
