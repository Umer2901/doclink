import 'package:get/get.dart';
import 'package:doclink/patient/model/global/fetch_faqs.dart';
import 'package:doclink/patient/services/api_service.dart';

class HelpAndFaqScreenController extends GetxController {
  int selectedCategory = 0;
  List<FetchFaqsData> faqs = [];
  bool isLoading = false;

  void onCategoryChange(int category) {
    selectedCategory = category;
    update();
  }

  @override
  void onInit() {
    fetchFaqsApiCall();
    super.onInit();
  }

  void fetchFaqsApiCall() {
    isLoading = true;
    PatientApiService.instance.fetchFaqCats().then((value) {
      faqs = value.data ?? [];
      isLoading = false;
      update();
    });
  }
}
