import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:doclink/patient/model/appointment/add_appointment.dart';
import 'package:doclink/patient/model/appointment/appointment_detail.dart';
import 'package:doclink/patient/model/appointment/coupon.dart';
import 'package:doclink/patient/model/appointment/fetch_appointment.dart';
import 'package:doclink/patient/model/appointment/prescription.dart';
import 'package:doclink/patient/model/custom/order_summary.dart';
import 'package:doclink/patient/model/doctor/doctor_review.dart';
import 'package:doclink/patient/model/doctor/fetch_doctor.dart';
import 'package:doclink/patient/model/doctor/search_doctor.dart';
import 'package:doclink/patient/model/global/agora_token.dart';
import 'package:doclink/patient/model/global/fetch_faqs.dart';
import 'package:doclink/patient/model/global/get_path.dart';
import 'package:doclink/patient/model/global/global_setting.dart';
import 'package:doclink/patient/model/home/fav_doctor.dart';
import 'package:doclink/patient/model/home/home.dart';
import 'package:doclink/patient/model/message/message.dart';
import 'package:doclink/patient/model/notification/notification.dart';
import 'package:doclink/patient/model/user/patient.dart';
import 'package:doclink/patient/model/user/registration.dart';
import 'package:doclink/patient/model/wallet/wallet_statement.dart';
import 'package:doclink/patient/model/wallet/withdraw_request.dart';
import 'package:doclink/patient/services/patient_pref_service.dart';
import 'package:doclink/utils/const_res.dart';
import 'package:doclink/utils/update_res.dart';
import 'package:doclink/utils/urls.dart';

class PatientApiService {
  static PatientApiService get instance {
    return PatientApiService();
  }

  Future<Registration> registration(
      {String? name,
      String? identity,
      String? deviceToken,
      int? deviceType,
      int? loginType}) async {
    Map<String, dynamic> map = {};
    if (name != null) {
      map[pFullName] = name;
    }
    map[pIdentity] = identity;
    map[pDeviceToken] = deviceToken;
    if (loginType != null) {
      map[pLoginType] = loginType.toString();
    }
    if (deviceType != null) {
      map[pDeviceType] = deviceType.toString();
    }

    http.Response response = await http.post(
      Uri.parse(Urls.registration),
      headers: {pApikeyName: ConstRes.apiKey},
      body: map,
    );
    print(response.body);
    return Registration.fromJson(jsonDecode(response.body));
  }
  Future<Map<String,dynamic>> findDoctor(int? category_id)async{
    Map<String, dynamic> map = {};
    map['category_id'] = '$category_id';
    http.Response response = await http.post(
      Uri.parse(Urls.getDoctorsDeviceTokens),
      headers: {pApikeyName: ConstRes.apiKey},
      body: map,
    );
    return jsonDecode(response.body);
  }
  Future<Registration> updateUserDetails(
      {String? name,
      String? countryCode,
      int? gender,
      File? image,
      String? dob,
      String? favouriteDoctors,
      Map<String?,dynamic>? medical_history,
      int? isNotification}) async {
    var request = http.MultipartRequest(
      pPost,
      Uri.parse(Urls.updateUserDetails),
    );

    request.headers.addAll({
      pApikeyName: ConstRes.apiKey,
    });
    request.fields[pIdentity] = '${ PatientPrefService.identity}';
    if (name != null) {
      request.fields[pFullName] = name;
    }
    if (countryCode != null) {
      request.fields[pCountryCode] = countryCode;
    }
    if (gender != null) {
      request.fields[pGender] = '$gender';
    }
    if (dob != null) {
      request.fields[pDob] = dob;
    }
    if(medical_history != null){
      request.fields[pMedicalhistory] = jsonEncode(medical_history);
    }
    if (favouriteDoctors != null) {
      request.fields[pFavouriteDoctors] = favouriteDoctors;
    }
    if (isNotification != null) {
      request.fields[pIsNotification] = isNotification.toString();
    }

    if (image != null) {
      request.files.add(http.MultipartFile(
          pProfileImage, image.readAsBytes().asStream(), image.lengthSync(),
          filename: image.path.split("/").last));
    }
    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    final responseJson = jsonDecode(respStr);
    print(responseJson);
    Registration updateProfile = Registration.fromJson(responseJson);
    PatientPrefService prefService =  PatientPrefService();
    await prefService.init();
    await prefService.saveString(
        key: kRegistrationUser, value: jsonEncode(updateProfile.data));
    prefService.updateFirebaseProfile();
    return updateProfile;
  }

  Future<Notification> fetchNotification({int start = 0}) async {
    http.Response response = await http.post(
      Uri.parse(Urls.fetchNotification),
      headers: {pApikeyName: ConstRes.apiKey},
      body: {
        pStart: start.toString(),
        pCount: pTen,
      },
    );
    return Notification.fromJson(jsonDecode(response.body));
  }

  Future<Home> fetchHomePageData({String? date}) async {
    Map<String, dynamic> map = {};
    map[pUserId] =  PatientPrefService.userId.toString();
    if (date != null) {
      map[pDate] = date;
    }
    http.Response response = await http.post(Uri.parse(Urls.fetchHomePageData),
        headers: {pApikeyName: ConstRes.apiKey}, body: map);
    return Home.fromJson(
      jsonDecode(response.body),
    );
  }

  Future<SearchDoctor> searchDoctor({
    int? gender,
    String keyword = '',
    int? categoryId,
    int start = 0,
    int? sortType,
  }) async {
    Map<String, dynamic> map = {};
    map[pStart] = start.toString();
    map[pCount] = pTen;
    if (keyword.isNotEmpty) {
      map[pKeyword] = keyword;
    }
    if (gender != null) {
      map[pGender] = gender.toString();
    }
    if (categoryId != null) {
      map[pCategoryId] = categoryId.toString();
    }
    if (sortType != null) {
      map[pSortType] = sortType.toString();
    }

    http.Response? response = await http.post(Uri.parse(Urls.searchDoctor),
        headers: {pApikeyName: ConstRes.apiKey}, body: map);
    return SearchDoctor.fromJson(jsonDecode(response.body));
  }

  Future<FetchPatient> fetchPatient() async {
    http.Response response = await http.post(
      Uri.parse(Urls.fetchPatients),
      headers: {pApikeyName: ConstRes.apiKey},
      body: {pUserId:  PatientPrefService.userId.toString()},
    );
    FetchPatient data = FetchPatient.fromJson(jsonDecode(response.body));
     PatientPrefService service =  PatientPrefService();
    await service.init();
    service.saveString(key: kPatient, value: jsonEncode(data.data));
    return data;
  }

  Future<Message> addPatient({
    String? fullName,
    String? age,
    String? relation,
    int? gender,
    File? image,
  }) async {
    var request = http.MultipartRequest(
      pPost,
      Uri.parse(Urls.addPatient),
    );

    request.headers.addAll({
      pApikeyName: ConstRes.apiKey,
    });
    request.fields[pUserId] = '${ PatientPrefService.userId}';
    if (fullName != null) {
      request.fields[pFullName] = fullName;
    }
    if (age != null) {
      request.fields[pAge] = age.toString();
    }
    if (relation != null) {
      request.fields[pRelation] = relation.toString();
    }
    if (gender != null) {
      request.fields[pGender] = gender.toString();
    }

    if (image != null) {
      request.files.add(http.MultipartFile(
          pImage, image.readAsBytes().asStream(), image.lengthSync(),
          filename: image.path.split("/").last));
    }
    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    return Message.fromJson(jsonDecode(respStr));
  }

  Future<Message> editPatient(
      {String? fullName,
      String? age,
      String? relation,
      int? gender,
      File? image,
      int? patientId}) async {
    var request = http.MultipartRequest(
      pPost,
      Uri.parse(Urls.editPatient),
    );

    request.headers.addAll({
      pApikeyName: ConstRes.apiKey,
    });
    request.fields[pPatientId] = '$patientId';
    if (fullName != null) {
      request.fields[pFullName] = fullName;
    }
    if (age != null) {
      request.fields[pAge] = age.toString();
    }
    if (relation != null) {
      request.fields[pRelation] = relation.toString();
    }
    if (gender != null) {
      request.fields[pGender] = gender.toString();
    }

    if (image != null) {
      request.files.add(http.MultipartFile(
          pImage, image.readAsBytes().asStream(), image.lengthSync(),
          filename: image.path.split("/").last));
    }
    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    return Message.fromJson(jsonDecode(respStr));
  }

  Future<Message> deletePatient({int? patientId}) async {
    http.Response response = await http.post(
      Uri.parse(Urls.deletePatient),
      headers: {pApikeyName: ConstRes.apiKey},
      body: {pPatientId: patientId.toString()},
    );
    return Message.fromJson(jsonDecode(response.body));
  }

  Future<FetchDoctor> fetchDoctorProfile({int? doctorId}) async {
    http.Response response = await http.post(
      Uri.parse(Urls.fetchDoctorProfile),
      headers: {pApikeyName: ConstRes.apiKey},
      body: {pDoctorId: doctorId.toString()},
    );
    return FetchDoctor.fromJson(jsonDecode(response.body));
  }

  Future<DoctorReview> fetchDoctorReviews(
      {int? doctorId, int start = 0}) async {
    http.Response response = await http.post(
      Uri.parse(Urls.fetchDoctorReviews),
      headers: {
        pApikeyName: ConstRes.apiKey,
      },
      body: {
        pDoctorId: doctorId.toString(),
        pStart: start.toString(),
        pCount: pTen,
      },
    );
    return DoctorReview.fromJson(jsonDecode(response.body));
  }

  Future<FavDoctor> fetchFavoriteDoctors() async {
    http.Response response = await http.post(
      Uri.parse(Urls.fetchFavoriteDoctors),
      headers: {
        pApikeyName: ConstRes.apiKey,
      },
      body: {
        pUserId:  PatientPrefService.userId.toString(),
      },
    );
    return FavDoctor.fromJson(jsonDecode(response.body));
  }

  Future<Coupon> fetchCoupons() async {
    http.Response response = await http.post(
      Uri.parse(Urls.fetchCoupons),
      headers: {
        pApikeyName: ConstRes.apiKey,
      },
      body: {
        pUserId:  PatientPrefService.userId.toString(),
      },
    );
    return Coupon.fromJson(jsonDecode(response.body));
  }

  Future<Registration> fetchMyUserDetails() async {
    http.Response response = await http.post(
      Uri.parse(Urls.fetchMyUserDetails),
      headers: {
        pApikeyName: ConstRes.apiKey,
      },
      body: {
        pUserId:  PatientPrefService.userId.toString(),
      },
    );
    Registration user = Registration.fromJson(jsonDecode(response.body));
     PatientPrefService prefService =  PatientPrefService();
    await prefService.init();
    await prefService.saveString(
        key: kRegistrationUser, value: jsonEncode(user.data));
    return user;
  }

  Future<Message> addMoneyToUserWallet(
      {num? amount,
      required String transactionId,
      required String transactionSummary,
      required int paymentGateway}) async {
    http.Response response = await http.post(
      Uri.parse(Urls.addMoneyToUserWallet),
      headers: {
        pApikeyName: ConstRes.apiKey,
      },
      body: {
        pUserId:  PatientPrefService.userId.toString(),
        pAmount: amount.toString(),
        pGateway: paymentGateway.toString(),
        pTransactionId: transactionId,
        pTransactionSummary: transactionSummary,
      },
    );
    await fetchMyUserDetails();
    return Message.fromJson(jsonDecode(response.body));
  }

  Future<AddAppointment> addAppointment({
    required int? doctorId,
    int? patientId,
    required String problem,
    required String date,
    required String time,
    required OrderSummary orderSummary,
    required num payableAmount,
    required int? type,
    required int isCouponApplied,
    required num discountAmount,
    required num serviceAmount,
    required num subTotal,
    required num totalTaxAmount,
    List<File>? documents,
    List<dynamic>? patient_symptoms,
  }) async {
    var request = http.MultipartRequest(
      pPost,
      Uri.parse(Urls.addAppointment),
    );
    request.headers.addAll({
      pApikeyName: ConstRes.apiKey,
    });
    request.fields[pUserId] = PatientPrefService.userId.toString();
    request.fields[pDoctorId] = '$doctorId';
    if (patientId != null) {
      request.fields[pPatientId] = '$patientId';
    }
    if(patient_symptoms != null){
      request.fields['patient_symptoms'] = jsonEncode(patient_symptoms);
    }
    else{
     request.fields['patient_symptoms'] = '';
    }
    request.fields[pProblem] = problem;
    request.fields[pDate] = date;
    request.fields[pTime] = time;
    request.fields[pOrderSummary] = jsonEncode(orderSummary);
    request.fields[pPayableAmount] = '$payableAmount';
    request.fields[pType] = '$type';
    request.fields[pIsCouponApplied] = '$isCouponApplied';
    request.fields[pDiscountAmount] = '$discountAmount';
    request.fields[pServiceAmount] = '$serviceAmount';
    request.fields[pSubtotal] = '$subTotal';
    request.fields[pTotalTaxAmount] = '$totalTaxAmount';

    List<http.MultipartFile> newList = <http.MultipartFile>[];
    if (documents != null) {
      for (int i = 0; i < documents.length; i++) {
        File imageFile = documents[i];
        var multipartFile = http.MultipartFile(pDocuments,
            imageFile.readAsBytes().asStream(), imageFile.lengthSync(),
            filename: imageFile.path.split('/').last);
        newList.add(multipartFile);
      }
    }
    request.files.addAll(newList);
    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    print(respStr);
    return AddAppointment.fromJson(jsonDecode(respStr));
  }

  Future<WalletStatement> fetchWalletStatement({int? start}) async {
    http.Response response =
        await http.post(Uri.parse(Urls.fetchWalletStatement), headers: {
      pApikeyName: ConstRes.apiKey
    }, body: {
      pUserId:  PatientPrefService.userId.toString(),
      pStart: start.toString(),
      pCount: pTen,
    });
    return WalletStatement.fromJson(jsonDecode(response.body));
  }

  Future<WalletStatement> submitUserWithdrawRequest(
      {String? bankName,
      String? accountNumber,
      String? holderName,
      String? swiftCode}) async {
    http.Response response =
        await http.post(Uri.parse(Urls.submitUserWithdrawRequest), headers: {
      pApikeyName: ConstRes.apiKey
    }, body: {
      pUserId:  PatientPrefService.userId.toString(),
      pBankTitle: bankName,
      pAccountNumber: accountNumber,
      pHolder: holderName,
      pSwiftCode: swiftCode,
    });
    fetchMyUserDetails();
    return WalletStatement.fromJson(jsonDecode(response.body));
  }

  Future<Appointment> fetchAppointmentDetails({int? appointmentId}) async {
    http.Response response =
        await http.post(Uri.parse(Urls.fetchAppointmentDetails), headers: {
      pApikeyName: ConstRes.apiKey
    }, body: {
      pAppointmentId: appointmentId.toString(),
    });
    return Appointment.fromJson(
      jsonDecode(response.body),
    );
  }

  Future<FetchPrescription> fetchMyPrescriptions() async {
    http.Response response =
        await http.post(Uri.parse(Urls.fetchMyPrescriptions), headers: {
      pApikeyName: ConstRes.apiKey
    }, body: {
      pUserId:  PatientPrefService.userId.toString(),
    });
    return FetchPrescription.fromJson(jsonDecode(response.body));
  }

  Future<FetchAppointment> fetchMyAppointments() async {
    http.Response response =
        await http.post(Uri.parse(Urls.fetchMyAppointments), headers: {
      pApikeyName: ConstRes.apiKey
    }, body: {
      pUserId:  PatientPrefService.userId.toString(),
    });
    return FetchAppointment.fromJson(jsonDecode(response.body));
  }

  Future<Appointment> addRating(
      {int? appointmentId, int? userId, String? comment, int? rating}) async {
    http.Response response =
        await http.post(Uri.parse(Urls.addRating), headers: {
      pApikeyName: ConstRes.apiKey
    }, body: {
      pAppointmentId: appointmentId.toString(),
      pUserId: userId.toString(),
      pComment: comment.toString(),
      pRating: rating.toString(),
    });
    return Appointment.fromJson(jsonDecode(response.body));
  }
  Future<Appointment> addLiveCallRating(
      {int? appointmentId, int? userId, String? comment, int? rating}) async {
    http.Response response =
        await http.post(Uri.parse(Urls.addLiveCallRating), headers: {
      pApikeyName: ConstRes.apiKey
    }, body: {
      pAppointmentId: appointmentId.toString(),
      pUserId: userId.toString(),
      pComment: comment.toString(),
      pRating: rating.toString(),
    });
    return Appointment.fromJson(jsonDecode(response.body));
  }
  Future<Appointment> rescheduleAppointment(
      {int? appointmentId, int? userId, String? date, String? time}) async {
    http.Response response =
        await http.post(Uri.parse(Urls.rescheduleAppointment), headers: {
      pApikeyName: ConstRes.apiKey
    }, body: {
      pAppointmentId: appointmentId.toString(),
      pUserId: userId.toString(),
      pDate: date,
      pTime: time,
    });
    return Appointment.fromJson(jsonDecode(response.body));
  }

  Future<Appointment> cancelAppointment({
    int? appointmentId,
    int? userId,
  }) async {
    http.Response response =
        await http.post(Uri.parse(Urls.cancelAppointment), headers: {
      pApikeyName: ConstRes.apiKey
    }, body: {
      pAppointmentId: appointmentId.toString(),
      pUserId: userId.toString(),
    });
    return Appointment.fromJson(jsonDecode(response.body));
  }

  Future<WithdrawRequest> fetchUserWithdrawRequests({
    int? start,
  }) async {
    http.Response response = await http
        .post(Uri.parse(Urls.fetchUserWithdrawRequests), headers: {
      pApikeyName: ConstRes.apiKey
    }, body: {
      pUserId:  PatientPrefService.userId.toString(),
      pStart: start.toString(),
      pCount: pTen
    });
    return WithdrawRequest.fromJson(jsonDecode(response.body));
  }

  Future<Message> logOut() async {
    http.Response response = await http.post(Uri.parse(Urls.logOut), headers: {
      pApikeyName: ConstRes.apiKey
    }, body: {
      pUserId:  PatientPrefService.userId.toString(),
    });
    return Message.fromJson(jsonDecode(response.body));
  }

  Future<Message> deleteUserAccount() async {
    http.Response response =
        await http.post(Uri.parse(Urls.deleteUserAccount), headers: {
      pApikeyName: ConstRes.apiKey
    }, body: {
      pUserId:  PatientPrefService.userId.toString(),
    });
    return Message.fromJson(jsonDecode(response.body));
  }

  Future<GlobalSetting> fetchGlobalSettings() async {
    http.Response response = await http.post(
        Uri.parse(Urls.fetchGlobalSettings),
        headers: {pApikeyName: ConstRes.apiKey});
    GlobalSetting setting = GlobalSetting.fromJson(jsonDecode(response.body));
     PatientPrefService prefService =  PatientPrefService();
    await prefService.init();
    prefService.saveString(
        key: kGlobalSetting, value: jsonEncode(setting.data));
    return setting;
  }

  Future<FetchFaqs> fetchFaqCats() async {
    http.Response response = await http.post(Uri.parse(Urls.fetchFaqCats),
        headers: {pApikeyName: ConstRes.apiKey});
    FetchFaqs faqs = FetchFaqs.fromJson(jsonDecode(response.body));
    return faqs;
  }

  createPaymentIntent(
      {required String amount,
      required String currency,
      required String authKey}) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      //Make post request to Stripe
      http.Response response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $authKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return jsonDecode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  calculateAmount(String amount) {
    final calculateAmount = (int.parse(amount)) * 100;
    return calculateAmount.toString();
  }

  Future<GetPath> uploadFileGivePath(File? image) async {
    var request = http.MultipartRequest(
      pPost,
      Uri.parse(Urls.uploadFileGivePath),
    );
    request.headers.addAll({
      pApikeyName: ConstRes.apiKey,
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
        headers: {pApikeyName: ConstRes.apiKey},
        body: {pChannelName: channelName});
    return AgoraToken.fromJson(jsonDecode(response.body));
  }

  Future pushNotification(
      {required String authorization,
      required String title,
      required String body,
      required String token,
      String? senderIdentity,
      String? appointmentId,
      required String notificationType}) async {
    Map<String, dynamic> map = {};
    if (senderIdentity != null) {
      map[senderId] = senderIdentity;
    }
    if (appointmentId != null) {
      map[nAppointmentId] = appointmentId;
    }
    map[nNotificationType] = notificationType;
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: {
        'Authorization': 'key=$authorization',
        'content-type': 'application/json'
      },
      body: json.encode(
        {
          'data': map,
          'notification': {
            'title': title,
            'body': body,
            "sound": "default",
            "badge": "1",
          },
          'to': '/token/$token',
        },
      ),
    );
  }
  Future<int> sendRequest(String body, Map<String,dynamic>? data, String title, List<String> pushToken)async{
    final headers = {
    'Content-Type': 'application/json',
    'Authorization' : 'key=${ConstRes.authorisationKey}'
    // Add any other headers if required
  };

  // Define the request body
  final requestBody = {
    "registration_ids": pushToken,
    "notification": {
      "body": body,
      "title": title,
      "android_channel_id": "doclink",
      "sound": true,
    },
    "data": data
  };

  // Send the POST request
  final response = await http.post(
    Uri.parse(Urls.notificationUrl),
    headers: headers,
    body: jsonEncode(requestBody),
  );
  return response.statusCode;
}
}