import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:doclink/patient/common/custom_ui.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/patient/model/appointment/fetch_appointment.dart';
import 'package:doclink/patient/model/custom/categories.dart';
import 'package:doclink/patient/model/doctor/fetch_doctor.dart';
import 'package:doclink/patient/screen/confirm_booking_screen/confirm_booking_screen.dart';
import 'package:doclink/patient/services/api_service.dart';
import 'package:doclink/patient/services/patient_pref_service.dart';
import 'package:doclink/utils/update_res.dart';

class SelectDateTimeScreenController extends GetxController {
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  int day = DateTime.now().day;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  TextEditingController problemController = TextEditingController();
  int? selectedAppointmentType;
  Doctor? doctorData;
  List<Patient?> patientList = [
    Patient(fullname: mySelf),
  ];
  Patient? selectedPatient;
  List<Slots>? slotTime = [];
  Slots? selectedSlot;
  List<File>? imageFileList = [];
  List<Documents>? documentList = [];
  PatientPrefService prefService = PatientPrefService();

  List<Patient>? patientData = [];
  AppointmentData? appointmentData;
  List<dynamic>? patient_symptoms;

  @override
  void onInit() {
    doctorData = Get.arguments[0];
    appointmentData = Get.arguments[1];
    fetchDoctorProfile();
    fetchPatientApiCall();

    super.onInit();
  }

  void onDoneClick(int month, int year) {
    this.year = year;
    this.month = month;
    if (DateTime.now().month == month) {
      day = DateTime.now().day;
    }
    update([kSelectDate]);
  }

  void onSelectedDateClick(DateTime dateTime) {
    selectedSlot = null;
    selectedDay = dateTime;
    initSlotList(dateTime);
    year = dateTime.year;
    month = dateTime.month;
    day = dateTime.day;
    update([kSelectTime, kSelectDate]);
  }

  void fetchPatientApiCall() async {
    await prefService.init();
    String response = prefService.getString(key: kPatient) ?? '';
    if (response.isNotEmpty) {
      Iterable l = jsonDecode(response);
      patientData = List<Patient>.from(l.map((e) => Patient.fromJson(e)));
      patientList.addAll(patientData ?? []);
      update();
    }
  }

  void onPatientChange(Patient? onChange) {
    selectedPatient = onChange!;
    update();
  }

  void onTimeTap(Slots? slots) {
    selectedSlot = slots;
    update([kSelectTime]);
  }

  void onAppointmentTypeTap(int index) {
    selectedAppointmentType = index;
    update([kAppointmentType]);
  }

  void initSlotList(DateTime time) {
    slotTime = [];
    if (doctorData?.holidays == null || doctorData!.holidays!.isEmpty) {
      for (int i = 0;
          i < int.parse(doctorData?.slots?.length.toString() ?? '0');
          i++) {
        if (time.weekday == doctorData?.slots?[i].weekday) {
          slotTime?.add(doctorData?.slots?[i] ?? Slots());
        }
      }
    } else {
      for (int j = 0;
          j < int.parse(doctorData?.holidays?.length.toString() ?? '0');
          j++) {
        if (DateFormat(yyyyMMDd).format(time) ==
            doctorData?.holidays?[j].date) {
          slotTime = [];
        } else {
          slotTime = [];
          for (int i = 0;
              i < int.parse(doctorData?.slots?.length.toString() ?? '0');
              i++) {
            if (time.weekday == doctorData?.slots?[i].weekday) {
              slotTime?.add(doctorData?.slots?[i] ?? Slots());
            }
          }
        }
      }
    }
    update([kSelectTime]);
  }

  void onAttachDocument() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage(
      imageQuality: 50,
    );
    if (images.isEmpty) return;
    if (images.isNotEmpty) {
      for (XFile image in images) {
        var i = File(image.path);
        imageFileList?.add(i);
      }
    }
    update([kAttachDocument]);
  }

  void onRescheduleTap() {
    if (selectedSlot?.time == null) {
      CustomUi.snackBar(
          message: PS.current.pleaseSelectAppointmentTime,
          iconData: CupertinoIcons.time_solid);
      return;
    }
    CustomUi.loader();
    PatientApiService.instance
        .rescheduleAppointment(
            userId: appointmentData?.userId,
            appointmentId: appointmentData?.id,
            date: DateFormat(yyyyMMDd).format(selectedDay),
            time: selectedSlot?.time)
        .then((value) {
      if (value.status == true) {
        Get.back();
        Get.back();
        CustomUi.snackBar(
            message: value.message ?? '',
            iconData: Icons.event_repeat_rounded,
            positive: true);
      } else {
        CustomUi.snackBar(
            message: value.message ?? '', iconData: Icons.event_repeat_rounded);
      }
    });
  }

  void onMakePaymentClick() {
    if (selectedSlot?.time == null) {
      CustomUi.infoSnackBar(PS.current.pleaseSelectAppointmentTime);
      return;
    } else if (selectedAppointmentType == null) {
      CustomUi.infoSnackBar(PS.current.pleaseSelectAppointmentType);
      return;
    } else if (problemController.text.isEmpty) {
      CustomUi.infoSnackBar(PS.current.pleaseExplainYourProblem);
      return;
    } else {
      AppointmentDetail detail = AppointmentDetail(
          date: DateFormat(yyyyMMDd, 'en').format(selectedDay),
          time: selectedSlot?.time ?? '',
          problem: problemController.text,
          type: selectedAppointmentType,
          patientId: selectedPatient?.id,
          documents: imageFileList,
          serviceAmount: doctorData?.consultationFee,
          patient_symptoms: patient_symptoms,
          );
      Get.to(() => const ConfirmBookingScreen(),
          arguments: [detail, doctorData]);
    }
  }

  onImageDelete(File? imageFileList) {
    this.imageFileList?.remove(imageFileList);
    update([kAttachDocument]);
  }

  void fetchDoctorProfile() {
    PatientApiService.instance
        .fetchDoctorProfile(doctorId: doctorData?.id)
        .then((value) {
      doctorData = value.data;
      initSlotList(selectedDay);
      rescheduleAppointment();
      update();
    });
  }

  void rescheduleAppointment() {
    selectedAppointmentType = appointmentData?.type;
    selectedPatient = patientList.firstWhere((element) {
      return element?.id == appointmentData?.patientId;
    });
    problemController = TextEditingController(text: appointmentData?.problem);
    update();
    update([kAppointmentType]);
  }
}
