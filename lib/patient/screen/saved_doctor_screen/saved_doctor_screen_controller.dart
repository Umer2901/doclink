import 'package:get/get.dart';
import 'package:doclink/patient/common/custom_ui.dart';
import 'package:doclink/patient/model/doctor/fetch_doctor.dart';
import 'package:doclink/patient/model/user/registration.dart';
import 'package:doclink/patient/screen/doctor_profile_screen/doctor_profile_screen.dart';
import 'package:doclink/patient/services/api_service.dart';
import 'package:doclink/patient/services/patient_pref_service.dart';

class SavedDoctorScreenController extends GetxController {
  bool isSaved = true;

  List<Doctor>? favDoctor;
  bool isLoading = false;
  PatientPrefService prefService = PatientPrefService();
  RegistrationData? userData;

  @override
  void onInit() {
    prefData();
    fetchFavDoctorAPiCall();
    super.onInit();
  }

  void fetchFavDoctorAPiCall() async {
    isLoading = true;
    PatientApiService.instance.fetchFavoriteDoctors().then((value) {
      favDoctor = value.data;
      isLoading = false;
      update();
    });
  }

  void prefData() async {
    await prefService.init();
    userData = prefService.getRegistrationData();
    isSaved = userData?.favouriteDoctors?.contains(',') ?? false;
    update();
  }

  void onBookMarkTap(int? doctorId) {
    String? savedProfile = userData?.favouriteDoctors;
    List<String> savedId = [];
    if (savedProfile == null || savedProfile.isEmpty) {
      savedProfile = doctorId.toString();
    } else {
      savedId = savedProfile.split(',');
      if (savedProfile.contains(doctorId.toString())) {
        savedId.remove(doctorId.toString());
      } else {
        savedId.add(doctorId.toString());
      }
      savedProfile = savedId.join(',');
    }
    CustomUi.loader();
    PatientApiService.instance
        .updateUserDetails(favouriteDoctors: savedProfile)
        .then((value) {
      fetchFavDoctorAPiCall();
      userData = value.data;
      isSaved = userData?.favouriteDoctors?.contains(',') ?? false;
      Get.back();
      update();
    });
  }

  onNavigateDoctor(Doctor? doc) {
    Get.to(() => const DoctorProfileScreen(), arguments: [doc])?.then((value) {
      if (value == true) {
        onBookMarkTap(doc?.id);
      }
    });
  }
}
