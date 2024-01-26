import 'package:get/get.dart';
import 'package:doclink/utils/color_res.dart';

class PatientDashboardScreenController extends GetxController {
  int currentIndex = 0;
  final inactiveColor = ColorRes.grey;

  void onItemSelected(int value) {
    currentIndex = value;
    update();
  }
}
