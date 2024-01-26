import 'package:get/get.dart';
import 'package:doclink/patient/model/appointment/fetch_appointment.dart';
import 'package:doclink/patient/screen/appointment_detail_screen/appointment_detail_screen.dart';
import 'package:doclink/patient/services/api_service.dart';

class AppointmentScreenController extends GetxController {
  List<AppointmentData>? appointmentData;
  bool isLoading = false;

  @override
  void onInit() {
    fetchAppointmentData();
    super.onInit();
  }

  void fetchAppointmentData() {
    isLoading = true;
    PatientApiService.instance.fetchMyAppointments().then((value) {
      appointmentData = value.data;
      isLoading = false;
      update();
    });
  }

  onAppointmentCardTap(AppointmentData? data) {
    Get.to(() => const AppointmentDetailScreen(), arguments: data?.id)
        ?.then((value) {
      fetchAppointmentData();
    });
  }
}
