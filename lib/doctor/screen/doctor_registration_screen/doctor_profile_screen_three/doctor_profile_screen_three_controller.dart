import 'package:doclink/doctor/common/custom_ui.dart';
import 'package:doclink/doctor/generated/l10n.dart';
import 'package:doclink/doctor/model/doctorProfile/registration/registration.dart';
import 'package:doclink/doctor/screen/doctor_registration_screen/doctor_profile_screen_four/doctor_profile_screen_four.dart';
import 'package:doclink/doctor/screen/map_screen/map_screen.dart';
import 'package:doclink/doctor/screen/registration_successful_screen.dart/registration_successful_screen.dart';
import 'package:doclink/doctor/service/api_service.dart';
import 'package:doclink/doctor/service/doctor_pref_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorProfileScreenThreeController extends GetxController {
  TextEditingController addClinicDetailController = TextEditingController();
  TextEditingController clinicNameController = TextEditingController();
  TextEditingController clinicAddressController = TextEditingController();
  bool isOnline = false;
  bool isAtClinic = false;
  bool isLocationFetch = false;
  DoctorPrefService prefService = DoctorPrefService();
  DoctorData? userData;
  double? latitude;
  double? longitude;
  FocusNode clinicNameFocusNode = FocusNode();
  FocusNode clinicAddressFocusNode = FocusNode();

  @override
  void onInit() {
    _prefData();
    super.onInit();
  }

  bool onChangeOnline(bool? value) {
    isOnline = value ?? false;
    update();
    return isOnline;
  }

  bool onChangeAtClinic(bool? value) {
    isAtClinic = value ?? false;
    update();
    return isAtClinic;
  }

  unFocusFiled() {
    clinicNameFocusNode.unfocus();
    clinicAddressFocusNode.unfocus();
  }

  void onLocationFetchTap() {
    if (latitude == null) {
      Get.to<List<double?>>(() => const MapScreen())?.then((value) {
        locationFetch(value);
      });
    } else {
      Get.to<List<double?>>(() => MapScreen(
            longitude: longitude,
            latitude: latitude,
          ))?.then((value) {
        locationFetch(value);
      });
    }
  }

  void locationFetch(List<double?>? value) {
    latitude = value?[0];
    longitude = value?[1];
    update();
    if (value?[0] != null) {
      CustomUi.snackBar(
          message: S.current.locationFetchSuccessfully,
          iconData: Icons.location_on_sharp,
          positive: true);
    } else {
      CustomUi.snackBar(
          message: S.current.locationNotFetch,
          iconData: Icons.location_on_sharp);
    }
  }

  void updateDoctorDetailsApiCall() {
    if (!isOnline && !isAtClinic) {
      CustomUi.infoSnackBar(S.current.chooseOneConsultationType);
      return;
    }
    if (isAtClinic) {
      if (clinicNameController.text.isEmpty) {
        CustomUi.infoSnackBar(S.current.pleaseEnterClinicName);
        return;
      }
      if (clinicAddressController.text.isEmpty) {
        CustomUi.infoSnackBar(S.current.pleaseEnterClinicAddress);
        return;
      }
    }
    unFocusFiled();
    CustomUi.loader();
    DoctorApiService.instance
        .updateDoctorDetails(
      onlineConsultation: isOnline ? 1 : 0,
      clinicConsultation: isAtClinic ? 1 : 0,
      clinicName: clinicNameController.text,
      clinicAddress: clinicAddressController.text,
      clinicLat: latitude,
      clinicLong: longitude,
    )
        .then((value) {
      if (value.status == true) {
        Get.back();
        if (Get.arguments == null) {
          Get.offAll(() => const DoctorProfileScreenFour());
        }
        CustomUi.snackBar(
            iconData: Icons.person, positive: true, message: value.message);
      } else {
        Get.back();
        CustomUi.snackBar(iconData: Icons.person, message: value.message);
      }
    });
  }

  void _prefData() async {
    await prefService.init();
    userData = prefService.getRegistrationData();
    clinicNameController =
        TextEditingController(text: userData?.clinicName ?? '');
    clinicAddressController =
        TextEditingController(text: userData?.clinicAddress ?? '');
    if (userData?.onlineConsultation != null) {
      isOnline = userData?.onlineConsultation == 1 ? true : false;
    }
    if (userData?.clinicConsultation != null) {
      isAtClinic = userData?.clinicConsultation == 1 ? true : false;
    }
    if (userData?.clinicLat != null) {
      latitude = double.parse(userData?.clinicLat ?? '');
      longitude = double.parse(userData?.clinicLong ?? '');
    }
    update();
  }
}
