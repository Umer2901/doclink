import 'dart:convert';

import 'package:get/get.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/patient/model/appointment/fetch_appointment.dart';
import 'package:doclink/patient/model/appointment/prescription.dart';
import 'package:doclink/patient/services/api_service.dart';
import 'package:doclink/patient/services/patient_pref_service.dart';
import 'package:doclink/utils/update_res.dart';

class PrescriptionScreenController extends GetxController {
  List<Patient?> list = [
    Patient(fullname: PS.current.all),
  ];
  List<Patient>? patientData;
  Patient? selectedPrescription;
  List<PrescriptionData>? prescriptionData;
  List<PrescriptionData>? tempData;
  PatientPrefService prefService = PatientPrefService();

  @override
  void onInit() {
    fetchPrescriptionApiCall();
    prefData();
    super.onInit();
  }

  void fetchPrescriptionApiCall() {
    PatientApiService.instance.fetchMyPrescriptions().then((value) {
      prescriptionData = value.data;
      tempData = value.data;
      update();
    });
  }

  void prefData() async {
    await prefService.init();
    String response = prefService.getString(key: kPatient) ?? '';
    Iterable l = jsonDecode(response);
    patientData = List<Patient>.from(l.map((e) => Patient.fromJson(e)));
    list.addAll(patientData ?? []);
    selectedPrescription = list[0];
    update();
  }

  void onPatientChange(Patient? onChange) {
    selectedPrescription = onChange!;
    if (selectedPrescription?.id == null) {
      prescriptionData = tempData;
    } else {
      prescriptionData = [];
      prescriptionData = tempData
          ?.where((element) =>
              element.appointment?.patientId == selectedPrescription?.id)
          .toList();
    }
    update();
  }
}
