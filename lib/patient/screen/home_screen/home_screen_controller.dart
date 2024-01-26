import 'package:doclink/patient/screen/findDoctor/find_doctor_screen.dart';
import 'package:get/get.dart';
import 'package:doclink/patient/model/appointment/fetch_appointment.dart';
import 'package:doclink/patient/model/doctor/fetch_doctor.dart';
import 'package:doclink/patient/model/home/home.dart';
import 'package:doclink/patient/model/user/registration.dart';
import 'package:doclink/patient/screen/doctor_profile_screen/doctor_profile_screen.dart';
import 'package:doclink/patient/screen/specialists_detail_screen/specialists_detail_screen.dart';
import 'package:doclink/patient/services/api_service.dart';
import 'package:doclink/patient/services/patient_pref_service.dart';
import 'package:doclink/utils/extention.dart';
import 'package:doclink/utils/update_res.dart';

class HomeScreenController extends GetxController {
  PatientPrefService prefService = PatientPrefService();
  bool isLoading = false;
  List<Categories>? categories = [];
  List<bool> isSelected = [];
  int index=0;
  List<AppointmentData>? appointments = [];
  RegistrationData? userData;

  @override
  void onInit() {
    prefData();
    fetchHomePageDataApiCall();
    super.onInit();
  }

  void prefData() async {
    await prefService.init();
    userData = prefService.getRegistrationData();
    update();
  }

  void fetchHomePageDataApiCall() async {
    isLoading = true;
    PatientApiService.instance
        .fetchHomePageData(date: DateTime.now().formatDateTime(yyyyMMDd))
        .then((value) {
      appointments = value.appointments;
      categories = value.categories;
      for(var i=0; i < value.categories!.length; i++){
        isSelected.add(false);
      }
      isLoading = false;
      update();
    });
  }

  onSpecialistsDetailScreenNavigate(Categories? categories) {
    Get.to(() => const SpecialistsDetailScreen(), arguments: categories);
  }

  onDoctorCardTap(Doctor? d) {
    Get.to(() => const DoctorProfileScreen(), arguments: [d]);
  }

  Future<void> finddoctor()async{
    Get.to(()=>findDoctor());
  }
  selectCategory(int index2){
    isSelected[index] = !isSelected[index];
    index = index2;
    update();
  }
}
