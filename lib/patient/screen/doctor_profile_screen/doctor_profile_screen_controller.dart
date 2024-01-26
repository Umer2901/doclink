import 'dart:convert';

import 'package:doclink/patient/model/appointment/fetch_appointment.dart';
import 'package:doclink/utils/update_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/patient/model/chat/chat.dart';
import 'package:doclink/patient/model/doctor/doctor_review.dart';
import 'package:doclink/patient/model/doctor/fetch_doctor.dart';
import 'package:doclink/patient/model/user/registration.dart';
import 'package:doclink/patient/screen/message_chat_screen/message_chat_screen.dart';
import 'package:doclink/patient/services/api_service.dart';
import 'package:doclink/patient/services/patient_pref_service.dart';
import 'package:doclink/utils/firebase_res.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorProfileScreenController extends GetxController {
  List<String> list = [
    PS.current.details,
    PS.current.reviews,
    PS.current.education,
    PS.current.experience,
    PS.current.awards,
  ];
  int selectedCategoryIndex = 0;
  int start = 0;
  ScrollController scrollController = ScrollController();
  double maxExtent = 300.0;
  double currentExtent = 300.0;
  bool isExpertiseShowMore = false;
  bool isServiceShowMore = false;
  bool isPosition = false;
  bool isLoading = false;
  List<DoctorReviewData>? review;
  Doctor? doctorData;
  PatientPrefService prefService = PatientPrefService();
  RegistrationData? userData;
  bool isFavouriteId = false;
  bool isBackFavDoc = false;
  List<Patient>? patientData = [];
  List<Patient?> patientList = [
    Patient(fullname: mySelf),
  ];

  @override
  void onInit() {
    doctorData = Get.arguments[0];
    prefData();
    getDoctorProfile();
    initScrollController();
    fetchScrollData();
    super.onInit();
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
  Future<void> getDoctorProfile() async {
    isLoading = true;
    await PatientApiService.instance
        .fetchDoctorProfile(doctorId: doctorData?.id)
        .then((value) {
      doctorData = value.data;
      isLoading = false;
      update();
    });
    fetchDoctorReviewsApiCall();
  }

  void fetchDoctorReviewsApiCall() {
    PatientApiService.instance
        .fetchDoctorReviews(doctorId: doctorData?.id, start: start)
        .then(
      (value) {
        if (start == 0) {
          review = value.data;
        } else {
          review?.addAll(value.data!);
        }
        start += review!.length;
        update();
      },
    );
  }

  void fetchScrollData() {
    scrollController.addListener(
      () {
        if (scrollController.offset ==
            scrollController.position.maxScrollExtent) {
          fetchDoctorReviewsApiCall();
        }
      },
    );
  }

  void onExpertiseShowMoreTap() {
    isExpertiseShowMore = !isExpertiseShowMore;
  }

  void onServicesShowMoreTap() {
    isServiceShowMore = !isServiceShowMore;
  }

  void onCategoryChange(int index) {
    selectedCategoryIndex = index;
    update();
  }

  void initScrollController() {
    scrollController.addListener(() {
      currentExtent = maxExtent - scrollController.offset;
      if (currentExtent < 0) currentExtent = 0.0;
      if (currentExtent > maxExtent) currentExtent = maxExtent;
      update();
    });
  }

  void prefData() async {
    await prefService.init();
    userData = prefService.getRegistrationData();
    isFavouriteId =
        userData?.favouriteDoctors?.contains('${doctorData?.id}') ?? false;
    update();
  }

  void updateProfileApiCall() {
    isFavouriteId = !isFavouriteId;
    String? savedProfile = userData?.favouriteDoctors;
    List<String> savedId = [];
    if (savedProfile == null || savedProfile.isEmpty) {
      savedProfile = doctorData?.id.toString();
    } else {
      savedId = savedProfile.split(',');
      if (savedProfile.contains('${doctorData?.id}')) {
        savedId.remove(doctorData?.id.toString());
      } else {
        savedId.add(doctorData?.id.toString() ?? '-1');
      }
      savedProfile = savedId.join(',');
    }

    PatientApiService.instance
        .updateUserDetails(favouriteDoctors: savedProfile)
        .then((value) {
      userData = value.data;
      isFavouriteId = value.data?.favouriteDoctors
              ?.contains(doctorData?.id.toString() ?? '-1') ??
          false;
      isBackFavDoc = true;
      update();
    });
  }

  void onChatBtnTap() {
    ChatUser chatUser = ChatUser(
        image: doctorData?.image,
        designation: doctorData?.designation,
        msgCount: 0,
        userid: doctorData?.id,
        userIdentity:
            '${FirebaseRes.dr}${doctorData?.mobileNumber?.replaceAll(' ', '').replaceAll('+', '')}',
        username: doctorData?.name);
    Conversation conversation = Conversation(
        time: DateTime.now().millisecondsSinceEpoch.toString(),
        conversationId:
            '${FirebaseRes.pt}${userData?.identity?.replaceAll(' ', '').replaceAll('+', '')}${FirebaseRes.dr}${doctorData?.mobileNumber?.replaceAll(' ', '').replaceAll('+', '')}',
        deletedId: '',
        isDeleted: false,
        lastMsg: '',
        newMsg: '',
        user: chatUser);
    Get.to(() => const MessageChatScreen(),
        arguments: [conversation, userData]);
  }

  void onCallBtnTap() {
    launchUrl(Uri.parse('tel:${doctorData?.mobileNumber ?? ''}'));
  }
}
