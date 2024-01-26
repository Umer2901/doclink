import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:doclink/doctor/model/appointment/appointment_detail.dart';
import 'package:doclink/doctor/model/appointment/appointment_request.dart';
import 'package:doclink/doctor/model/appointment_slot/add_slot.dart';
import 'package:doclink/doctor/model/doctorProfile/registration/registration.dart';
import 'package:doclink/doctor/model/doctor_category/doctor_category.dart';
import 'package:doclink/doctor/model/global/agora_token.dart';
import 'package:doclink/doctor/model/global/faq_cat.dart';
import 'package:doclink/doctor/model/global/get_path.dart';
import 'package:doclink/doctor/model/global/global_setting.dart';
import 'package:doclink/doctor/model/message/api_status.dart';
import 'package:doclink/doctor/model/notification/notification.dart';
import 'package:doclink/doctor/model/review/review.dart';
import 'package:doclink/doctor/model/user/fetch_user_detail.dart';
import 'package:doclink/doctor/model/wallet/earning_history.dart';
import 'package:doclink/doctor/model/wallet/payout_history.dart';
import 'package:doclink/doctor/model/wallet/wallet_statement.dart';
import 'package:doclink/doctor/service/doctor_pref_service.dart';
import 'package:doclink/utils/const_res.dart';
import 'package:doclink/utils/update_res.dart';
import 'package:doclink/utils/urls.dart';
import 'package:http/http.dart' as http;

class DoctorApiService {
  static DoctorApiService get instance {
    return DoctorApiService();
  }

  Future<Registration> doctorRegistration(
      {String? mobileNumber, String? deviceToken}) async {
    http.Response response = await http.post(
      Uri.parse(Urls.doctorRegistration),
      headers: {
        pApiKeyName: ConstRes.apiKey,
      },
      body: {pMobileNumber: mobileNumber, pDeviceToken: deviceToken},
    );
    Registration registration =
        Registration.fromJson(jsonDecode(response.body));
    DoctorPrefService prefService = DoctorPrefService();
    await prefService.init();
    await prefService.saveString(
        key: kRegistrationUser, value: jsonEncode(registration.data));
    return registration;
  }

  Future<Registration> updateDoctorDetails(
      {String? name,
      String? countryCode,
      int? gender,
      var categoryId,
      String? designation,
      String? degrees,
      String? languagesSpoken,
      String? experienceYear,
      String? consultationFee,
      String? aboutYourself,
      String? educationalJourney,
      int? onlineConsultation,
      int? clinicConsultation,
      double? clinicLong,
      double? clinicLat,
      String? clinicAddress,
      String? clinicName,
      File? image,
      int? notification,
      int? vacationMode,
      String? mobileNumber,
      int? isonline
      }) async {
    var request = http.MultipartRequest(
      pPost,
      Uri.parse(Urls.updateDoctorDetails),
    );
    request.headers.addAll({
      pApiKeyName: ConstRes.apiKey,
    });
    request.fields[pDoctorId] = DoctorPrefService.id.toString();
    if (name != null) {
      request.fields[pName] = name;
    }
    if (countryCode != null) {
      request.fields[pCountryCode] = countryCode;
    }
    if (gender != null) {
      request.fields[pGender] = '$gender';
    }
    if (categoryId != null) {
      request.fields[pCategoryId] = '$categoryId';
    }
    if (designation != null) {
      request.fields[pDesignation] = designation;
    }
    if (degrees != null) {
      request.fields[pDegrees] = degrees;
    }
    if (languagesSpoken != null) {
      request.fields[pLanguagesSpoken] = languagesSpoken;
    }
    if (experienceYear != null) {
      request.fields[pExperienceYear] = experienceYear;
    }
    if (consultationFee != null) {
      request.fields[pConsultationFee] = consultationFee;
    }
    if (aboutYourself != null) {
      request.fields[pAboutYourself] = aboutYourself;
    }
    if (educationalJourney != null) {
      request.fields[pEducationalJourney] = educationalJourney;
    }
    if (onlineConsultation != null) {
      request.fields[pOnlineConsultation] = '$onlineConsultation';
    }
    if (clinicConsultation != null) {
      request.fields[pClinicConsultation] = '$clinicConsultation';
    }
    if (clinicName != null) {
      request.fields[pClinicName] = clinicName;
    }
    if (clinicAddress != null) {
      request.fields[pClinicAddress] = clinicAddress;
    }
    if (clinicLat != null) {
      request.fields[pClinicLat] = '$clinicLat';
    }
    if (clinicLong != null) {
      request.fields[pClinicLong] = '$clinicLong';
    }
    if (notification != null) {
      request.fields[pIsNotification] = '$notification';
    }
    if (vacationMode != null) {
      request.fields[pOnVacation] = '$vacationMode';
    }
    if(isonline != null){
      request.fields[pOnlneStatus] = '$isonline';
    }
    if (mobileNumber != null) {
      request.fields[pMobileNumber] = mobileNumber;
    }
    if (image != null) {
      request.files.add(http.MultipartFile(
          pImage, image.readAsBytes().asStream(), image.lengthSync(),
          filename: image.path.split("/").last));
    }
    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    final responseJson = jsonDecode(respStr);
    Registration updateProfile = Registration.fromJson(responseJson);

    DoctorPrefService prefService = DoctorPrefService();
    await prefService.init();
    await prefService.saveString(
        key: kRegistrationUser, value: jsonEncode(updateProfile.data));
    prefService.updateFirebaseProfile();
    return updateProfile;
  }

  Future<DoctorCategory> fetchDoctorCategories() async {
    http.Response response = await http.post(
      Uri.parse(Urls.fetchDoctorCategories),
      headers: {pApiKeyName: ConstRes.apiKey},
    );
    DoctorCategory doctorCategory =
        DoctorCategory.fromJson(jsonDecode(response.body));
    return doctorCategory;
  }

  Future<ApiStatus> suggestDoctorCategory(
      {String? title, String? about}) async {
    http.Response response = await http.post(
      Uri.parse(Urls.suggestDoctorCategory),
      headers: {
        pApiKeyName: ConstRes.apiKey,
      },
      body: {
        pTitle: title,
        pAbout: about,
      },
    );
    ApiStatus message = ApiStatus.fromJson(jsonDecode(response.body));
    return message;
  }

  Future<Notification> fetchDoctorNotifications({int? start}) async {
    http.Response response = await http.post(
      Uri.parse(Urls.fetchDoctorNotifications),
      headers: {
        pApiKeyName: ConstRes.apiKey,
      },
      body: {
        pStart: start.toString(),
        pCount: pTen,
      },
    );
    return Notification.fromJson(jsonDecode(response.body));
  }

  Future<Registration> fetchMyDoctorProfile() async {
    http.Response response = await http.post(
      Uri.parse(Urls.fetchMyDoctorProfile(DoctorPrefService.id)),
      headers: {
        pApiKeyName: ConstRes.apiKey,
      },
    );
    Registration data = Registration.fromJson(jsonDecode(response.body));

    DoctorPrefService prefService = DoctorPrefService();
    await prefService.init();
    await prefService.saveString(
        key: kRegistrationUser, value: jsonEncode(data.data));
    return data;
  }

  Future<Registration> addEditService(
      {String? title, int? apiType, int? serviceId}) async {
    Map<String, dynamic> map = {};
    map[pDoctorId] = DoctorPrefService.id.toString();
    map[pTitle] = title;
    map[pType] = apiType.toString();
    if (apiType != null) {
      map[pServiceId] = serviceId.toString();
    }

    http.Response response = await http.post(
      Uri.parse(Urls.addEditService),
      headers: {
        pApiKeyName: ConstRes.apiKey,
      },
      body: map,
    );
    return Registration.fromJson(jsonDecode(response.body));
  }

  Future<Registration> addEditExpertise(
      {String? title, int? apiType, int? expertiseId}) async {
    Map<String, dynamic> map = {};
    map[pDoctorId] = DoctorPrefService.id.toString();
    map[pTitle] = title;
    map[pType] = apiType.toString();
    if (apiType != null) {
      map[pExpertiseId] = expertiseId.toString();
    }

    http.Response response = await http.post(
      Uri.parse(Urls.addEditExpertise),
      headers: {
        pApiKeyName: ConstRes.apiKey,
      },
      body: map,
    );
    return Registration.fromJson(jsonDecode(response.body));
  }

  Future<Registration> addEditExperience(
      {String? title, int? apiType, int? experienceId}) async {
    Map<String, dynamic> map = {};
    map[pDoctorId] = DoctorPrefService.id.toString();
    map[pTitle] = title;
    map[pType] = apiType.toString();
    if (apiType != null) {
      map[pExperienceId] = experienceId.toString();
    }

    http.Response response = await http.post(
      Uri.parse(Urls.addEditExperience),
      headers: {
        pApiKeyName: ConstRes.apiKey,
      },
      body: map,
    );
    return Registration.fromJson(jsonDecode(response.body));
  }

  Future<Registration> addEditAwards(
      {String? title, int? apiType, int? awardId}) async {
    Map<String, dynamic> map = {};
    map[pDoctorId] = DoctorPrefService.id.toString();
    map[pTitle] = title;
    map[pType] = apiType.toString();
    if (apiType != null) {
      map[pAwardId] = awardId.toString();
    }

    http.Response response = await http.post(
      Uri.parse(Urls.addEditAwards),
      headers: {
        pApiKeyName: ConstRes.apiKey,
      },
      body: map,
    );
    return Registration.fromJson(jsonDecode(response.body));
  }

  Future<Registration> addEditServiceLocations(
      {String? hospitalTitle,
      String? hospitalAddress,
      int? type,
      int? serviceLocationId,
      double? hospitalLat,
      double? hospitalLong}) async {
    Map<String, dynamic> map = {};
    map[pDoctorId] = DoctorPrefService.id.toString();
    map[pHospitalTitle] = hospitalTitle;
    map[pHospitalAddress] = hospitalAddress;
    map[pType] = type.toString();
    map[pHospitalLat] = hospitalLat.toString();
    map[pHospitalLong] = hospitalLong.toString();
    if (type != null) {
      map[pServiceLCationId] = serviceLocationId.toString();
    }

    http.Response response = await http.post(
      Uri.parse(Urls.addEditServiceLocations),
      headers: {
        pApiKeyName: ConstRes.apiKey,
      },
      body: map,
    );
    return Registration.fromJson(jsonDecode(response.body));
  }

  Future<ApiStatus> addHoliday({
    String? date,
  }) async {
    Map<String, dynamic> map = {};
    map[pDoctorId] = DoctorPrefService.id.toString();
    map[pDate] = date;
    http.Response response = await http.post(
      Uri.parse(Urls.addHoliday),
      headers: {
        pApiKeyName: ConstRes.apiKey,
      },
      body: map,
    );
    return ApiStatus.fromJson(jsonDecode(response.body));
  }

  Future<ApiStatus> deleteHoliday({
    int? holidayId,
  }) async {
    Map<String, dynamic> map = {};
    map[pDoctorId] = DoctorPrefService.id.toString();
    map[pHolidayId] = holidayId.toString();
    http.Response response = await http.post(
      Uri.parse(Urls.deleteHoliday),
      headers: {
        pApiKeyName: ConstRes.apiKey,
      },
      body: map,
    );
    return ApiStatus.fromJson(jsonDecode(response.body));
  }

  Future<AddSlot> addAppointmentSlots({String? time, int? weekday}) async {
    Map<String, dynamic> map = {};
    map[pDoctorId] = DoctorPrefService.id.toString();
    map[pTime] = time;
    map[pWeekday] = weekday.toString();
    http.Response response = await http.post(
      Uri.parse(Urls.addAppointmentSlots),
      headers: {
        pApiKeyName: ConstRes.apiKey,
      },
      body: map,
    );
    return AddSlot.fromJson(jsonDecode(response.body));
  }

  Future<ApiStatus> deleteAppointmentSlot({int? slotId}) async {
    Map<String, dynamic> map = {};
    map[pDoctorId] = DoctorPrefService.id.toString();
    map[pSlotId] = slotId.toString();
    http.Response response = await http.post(
      Uri.parse(Urls.deleteAppointmentSlot),
      headers: {
        pApiKeyName: ConstRes.apiKey,
      },
      body: map,
    );
    return ApiStatus.fromJson(jsonDecode(response.body));
  }

  Future<Registration> manageDrBankAccount({
    File? chequePhoto,
    String? bankName,
    String? accountNumber,
    String? holderName,
    String? swiftCode,
  }) async {
    var request = http.MultipartRequest(
      pPost,
      Uri.parse(Urls.manageDrBankAccount),
    );
    request.headers.addAll({
      pApiKeyName: ConstRes.apiKey,
    });
    request.fields[pDoctorId] = '${DoctorPrefService.id}';
    if (bankName != null) {
      request.fields[pBankName] = bankName;
    }
    if (accountNumber != null) {
      request.fields[pAccountNumber] = accountNumber;
    }
    if (holderName != null) {
      request.fields[pHolder] = holderName;
    }
    if (swiftCode != null) {
      request.fields[pSwiftCode] = swiftCode;
    }
    if (chequePhoto != null) {
      request.files.add(http.MultipartFile(pChequePhoto,
          chequePhoto.readAsBytes().asStream(), chequePhoto.lengthSync(),
          filename: chequePhoto.path.split("/").last));
    }
    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    final responseJson = jsonDecode(respStr);
    Registration manageBankDetail = Registration.fromJson(responseJson);
    DoctorPrefService prefService = DoctorPrefService();
    await prefService.init();
    await prefService.saveString(
        key: kRegistrationUser, value: jsonEncode(manageBankDetail.data));

    return manageBankDetail;
  }

  Future<AppointmentRequest> fetchAppointmentRequests({int? start}) async {
    Map<String, dynamic> map = {};
    map[pDoctorId] = DoctorPrefService.id.toString();
    map[pStart] = start.toString();
    map[pCount] = pTen;
    http.Response response = await http.post(
      Uri.parse(Urls.fetchAppointmentRequests),
      headers: {
        pApiKeyName: ConstRes.apiKey,
      },
      body: map,
    );
    return AppointmentRequest.fromJson(jsonDecode(response.body));
  }

  Future<AppointmentDetail> fetchAppointmentDetails(
      {int? appointmentId}) async {
    Map<String, dynamic> map = {};
    map[pAppointmentId] = '$appointmentId';
    http.Response response = await http.post(
      Uri.parse(Urls.fetchAppointmentDetails),
      headers: {
        pApiKeyName: ConstRes.apiKey,
      },
      body: map,
    );
    print(jsonDecode(response.body));
    return AppointmentDetail.fromJson(jsonDecode(response.body));
  }

  Future<ApiStatus> acceptAppointment(
      {int? appointmentId, int? doctorId}) async {
    Map<String, dynamic> map = {};
    map[pAppointmentId] = '$appointmentId';
    map[pDoctorId] = '$doctorId';
    http.Response response = await http.post(
      Uri.parse(Urls.acceptAppointment),
      headers: {
        pApiKeyName: ConstRes.apiKey,
      },
      body: map,
    );
    return ApiStatus.fromJson(jsonDecode(response.body));
  }

  Future<ApiStatus> declineAppointment(
      {int? appointmentId, int? doctorId}) async {
    Map<String, dynamic> map = {};
    map[pAppointmentId] = '$appointmentId';
    map[pDoctorId] = '$doctorId';
    http.Response response = await http.post(
      Uri.parse(Urls.declineAppointment),
      headers: {
        pApiKeyName: ConstRes.apiKey,
      },
      body: map,
    );
    return ApiStatus.fromJson(jsonDecode(response.body));
  }

  Future<AppointmentRequest> fetchAcceptedAppointsByDate(
      {required String date}) async {
    http.Response response = await http.post(
      Uri.parse(Urls.fetchAcceptedAppointsByDate),
      headers: {pApiKeyName: ConstRes.apiKey},
      body: {pDate: date, pDoctorId: DoctorPrefService.id.toString()},
    );
    return AppointmentRequest.fromJson(jsonDecode(response.body));
  }

  Future<AppointmentRequest> fetchAppointmentHistory(
      {required int? start}) async {
    log(DoctorPrefService.id.toString());
    http.Response response =
        await http.post(Uri.parse(Urls.fetchAppointmentHistory), headers: {
      pApiKeyName: ConstRes.apiKey,
    }, body: {
      pDoctorId: DoctorPrefService.id.toString(),
      pStart: start.toString(),
      pCount: pTen
    });
    return AppointmentRequest.fromJson(jsonDecode(response.body));
  }

  Future<ApiStatus> addPrescription(
      {required int? appointmentId,
      int? userId,
      File? signature,
      required Map<String, dynamic>? medicine}) async {
    var request =
        await http.MultipartRequest("POST", Uri.parse(Urls.addPrescription));
    request.headers.addAll({
      pApiKeyName: ConstRes.apiKey,
      });
      request.fields.addAll({
      pAppointmentId: appointmentId.toString(),
      pUserId: userId.toString(),
      pMedicine: jsonEncode(medicine),
    });
    if(signature != null){
      request.files.add(
        http.MultipartFile(
            "signature", signature.readAsBytes().asStream(), signature.lengthSync(),
            filename: signature.path.split("/").last),
      );
    }
    var response = await request.send();
    String strResponse = await response.stream.bytesToString();
    print(strResponse);
    return ApiStatus.fromJson(jsonDecode(strResponse));
  }

  Future<ApiStatus> editPrescription(
      {int? prescriptionId, required Map<String, dynamic>? medicine}) async {
    http.Response response =
        await http.post(Uri.parse(Urls.editPrescription), headers: {
      pApiKeyName: ConstRes.apiKey,
    }, body: {
      pPrescriptionId: prescriptionId.toString(),
      pMedicine: jsonEncode(medicine)
    });
    return ApiStatus.fromJson(jsonDecode(response.body));
  }

  Future<ApiStatus> completeAppointment(
      {int? appointmentId,
      int? doctorId,
      required String otp,
      required String diagnoseWith}) async {
    http.Response response =
        await http.post(Uri.parse(Urls.completeAppointment), headers: {
      pApiKeyName: ConstRes.apiKey,
    }, body: {
      pAppointmentId: appointmentId.toString(),
      pDoctorId: doctorId.toString(),
      pCompletionOtp: otp,
      pDiagnosedWith: diagnoseWith,
    });
    return ApiStatus.fromJson(jsonDecode(response.body));
  }

  Future<WalletStatement> fetchDoctorWalletStatement({int? start}) async {
    http.Response response = await http.post(
      Uri.parse(Urls.fetchDoctorWalletStatement),
      headers: {
        pApiKeyName: ConstRes.apiKey,
      },
      body: {
        pDoctorId: DoctorPrefService.id.toString(),
        pStart: start.toString(),
        pCount: pTen
      },
    );
    return WalletStatement.fromJson(jsonDecode(response.body));
  }

  Future<ApiStatus> submitDoctorWithdrawRequest() async {
    http.Response response = await http.post(
      Uri.parse(Urls.submitDoctorWithdrawRequest),
      headers: {
        pApiKeyName: ConstRes.apiKey,
      },
      body: {
        pDoctorId: DoctorPrefService.id.toString(),
      },
    );
    return ApiStatus.fromJson(jsonDecode(response.body));
  }

  Future<Review> fetchDoctorReviews({int? start}) async {
    http.Response response = await http.post(
      Uri.parse(Urls.fetchDoctorReviews),
      headers: {
        pApiKeyName: ConstRes.apiKey,
      },
      body: {
        pDoctorId: DoctorPrefService.id.toString(),
        pStart: start.toString(),
        pCount: pTen
      },
    );
    return Review.fromJson(jsonDecode(response.body));
  }

  Future<EarningHistory> fetchDoctorEarningHistory(
      {String? month, String? year}) async {
    http.Response response = await http.post(
      Uri.parse(Urls.fetchDoctorEarningHistory),
      headers: {
        pApiKeyName: ConstRes.apiKey,
      },
      body: {
        pDoctorId: DoctorPrefService.id.toString(),
        pMonth: month.toString(),
        pYear: year.toString()
      },
    );
    return EarningHistory.fromJson(jsonDecode(response.body));
  }

  Future<PayoutHistory> fetchDoctorPayoutHistory() async {
    http.Response response = await http.post(
        Uri.parse(Urls.fetchDoctorPayoutHistory),
        headers: {pApiKeyName: ConstRes.apiKey},
        body: {pDoctorId: DoctorPrefService.id.toString()});

    return PayoutHistory.fromJson(jsonDecode(response.body));
  }

  Future<ApiStatus> checkMobileNumberExists(
      {required String mobileNumber}) async {
    http.Response response = await http.post(
        Uri.parse(Urls.checkMobileNumberExists),
        headers: {pApiKeyName: ConstRes.apiKey},
        body: {pMobileNumber: mobileNumber});

    return ApiStatus.fromJson(jsonDecode(response.body));
  }

  Future<FaqCat> fetchFaqCats() async {
    http.Response response = await http.post(
      Uri.parse(Urls.fetchFaqCats),
      headers: {pApiKeyName: ConstRes.apiKey},
    );
    return FaqCat.fromJson(jsonDecode(response.body));
  }

  Future<ApiStatus> logOutDoctor() async {
    http.Response response =
        await http.post(Uri.parse(Urls.logOutDoctor), headers: {
      pApiKeyName: ConstRes.apiKey
    }, body: {
      pDoctorId: DoctorPrefService.id.toString(),
    });
    return ApiStatus.fromJson(jsonDecode(response.body));
  }

  Future<ApiStatus> deleteDoctorAccount() async {
    http.Response response =
        await http.post(Uri.parse(Urls.deleteDoctorAccount), headers: {
      pApiKeyName: ConstRes.apiKey
    }, body: {
      pDoctorId: DoctorPrefService.id.toString(),
    });
    return ApiStatus.fromJson(jsonDecode(response.body));
  }

  Future<GlobalSetting> fetchGlobalSettings() async {
    http.Response response = await http.post(
        Uri.parse(Urls.fetchGlobalSettings),
        headers: {pApiKeyName: ConstRes.apiKey});
        print(response.body);
    GlobalSetting setting = GlobalSetting.fromJson(jsonDecode(response.body));
    DoctorPrefService prefService = DoctorPrefService();
    await prefService.init();
    await prefService.saveString(
        key: kGlobalSetting, value: jsonEncode(setting.data));
    return setting;
  }

  Future<GetPath> uploadFileGivePath(File? image) async {
    var request = http.MultipartRequest(
      pPost,
      Uri.parse(Urls.uploadFileGivePath),
    );
    request.headers.addAll({
      pApiKeyName: ConstRes.apiKey,
    });
    if (image != null) {
      request.files.add(
        http.MultipartFile(
            pFile, image.readAsBytes().asStream(), image.lengthSync(),
            filename: image.path.split("/").last),
      );
    }
    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    final responseJson = jsonDecode(respStr);
    return GetPath.fromJson(responseJson);
  }

  Future<AgoraToken> getAgoraToken({required String channelName}) async {
    http.Response response = await http.post(Uri.parse(Urls.generateAgoraToken),
        headers: {pApiKeyName: ConstRes.apiKey},
        body: {pChannelName: channelName});
        print(response.body);
    return AgoraToken.fromJson(jsonDecode(response.body));
  }

  Future<FetchUserDetail> fetchUserDetails({required int userId}) async {
    http.Response response = await http.post(Uri.parse(Urls.fetchUserDetails),
        headers: {pApiKeyName: ConstRes.apiKey},
        body: {pUserId: userId.toString()});
    return FetchUserDetail.fromJson(jsonDecode(response.body));
  }

  Future pushNotification(
      {required String title,
      required String body,
      required String token,
      String? senderIdentity,
      String? appointmentId,
      required String type}) async {
    Map<String, dynamic> map = {};
    if (senderIdentity != null) {
      map[senderId] = senderIdentity;
    }
    if (appointmentId != null) {
      map[nAppointmentId] = appointmentId;
    }
    map[nNotificationType] = type;
    await http.post(
      Uri.parse(Urls.notificationUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "key=${ConstRes.authorisationKey}"
      },
      body: json.encode(
        {
          'data': map,
          'notification': {
            "title": title,
            "body": body,
            "mutable_content": true,
            "sound": "Tri-tone"
          },
          'to': token,
        },
      ),
    );
  }
}
