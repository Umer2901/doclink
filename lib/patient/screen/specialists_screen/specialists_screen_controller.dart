import 'package:get/get.dart';
import 'package:doclink/patient/model/home/home.dart';
import 'package:doclink/patient/services/api_service.dart';

class SpecialistsScreenController extends GetxController {
  bool isLoading = false;
  List<Categories>? categories = [];

  @override
  void onInit() {
    fetchHomePageDataApiCall();
    super.onInit();
  }

  void fetchHomePageDataApiCall() async {
    isLoading = true;
    PatientApiService.instance.fetchHomePageData().then((value) {
      categories = value.categories;
      isLoading = false;
      update();
    });
  }
}
