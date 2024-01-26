import 'package:doclink/utils/const_res.dart';

class Urls {
  //------------------ doctor api urls -----------------------------//

  static const String doctorRegistration =
      '${ConstRes.baseURL}doctorRegistration';
  static const String updateDoctorDetails =
      '${ConstRes.baseURL}updateDoctorDetails';
  static const String fetchDoctorCategories =
      '${ConstRes.baseURL}fetchDoctorCategories';
  static const String suggestDoctorCategory =
      '${ConstRes.baseURL}suggestDoctorCategory';
  static const String fetchDoctorNotifications =
      '${ConstRes.baseURL}fetchDoctorNotifications';
  static const String addEditService = '${ConstRes.baseURL}addEditService';
  static const String addEditExpertise = '${ConstRes.baseURL}addEditExpertise';
  static const String addEditExperience =
      '${ConstRes.baseURL}addEditExperience';
  static const String addEditAwards = '${ConstRes.baseURL}addEditAwards';
  static const String addHoliday = '${ConstRes.baseURL}addHoliday';
  static const String deleteHoliday = '${ConstRes.baseURL}deleteHoliday';
  static const String addEditServiceLocations =
      '${ConstRes.baseURL}addEditServiceLocations';
  static const String addAppointmentSlots =
      '${ConstRes.baseURL}addAppointmentSlots';
  static const String deleteAppointmentSlot =
      '${ConstRes.baseURL}deleteAppointmentSlot';
  static const String manageDrBankAccount =
      '${ConstRes.baseURL}manageDrBankAccount';
  static const String acceptAppointment =
      '${ConstRes.baseURL}acceptAppointment';
  static const String declineAppointment =
      '${ConstRes.baseURL}declineAppointment';
  static const String fetchAppointmentRequests =
      '${ConstRes.baseURL}fetchAppointmentRequests';
  static const String fetchAppointmentDetails =
      '${ConstRes.baseURL}fetchAppointmentDetails';
  static const String fetchAcceptedAppointsByDate =
      '${ConstRes.baseURL}fetchAcceptedAppointsByDate';
  static const String fetchAppointmentHistory =
      '${ConstRes.baseURL}fetchAppointmentHistory';
  static const String addPrescription = '${ConstRes.baseURL}addPrescription';
  static const String editPrescription = '${ConstRes.baseURL}editPrescription';
  static const String completeAppointment =
      '${ConstRes.baseURL}completeAppointment';
  static const String fetchDoctorWalletStatement =
      '${ConstRes.baseURL}fetchDoctorWalletStatement';
  static const String submitDoctorWithdrawRequest =
      '${ConstRes.baseURL}submitDoctorWithdrawRequest';
  static const String fetchDoctorReviews =
      '${ConstRes.baseURL}fetchDoctorReviews';
  static const String fetchDoctorEarningHistory =
      '${ConstRes.baseURL}fetchDoctorEarningHistory';
  static const String fetchDoctorPayoutHistory =
      '${ConstRes.baseURL}fetchDoctorPayoutHistory';
  static const String checkMobileNumberExists =
      '${ConstRes.baseURL}checkMobileNumberExists';
  static const String fetchFaqCats = '${ConstRes.baseURL}fetchFaqCats';
  static const String fetchGlobalSettings =
      '${ConstRes.base}api/fetchGlobalSettings';
  static const String logOutDoctor = '${ConstRes.baseURL}logOutDoctor';
  static const String deleteDoctorAccount =
      '${ConstRes.baseURL}deleteDoctorAccount';
  static const String uploadFileGivePath =
      '${ConstRes.base}api/uploadFileGivePath';
  static const String generateAgoraToken =
      '${ConstRes.base}api/generateAgoraToken';
  static const String fetchUserDetails = '${ConstRes.baseURL}fetchUserDetails';

  static String fetchMyDoctorProfile(int? id) {
    return '${ConstRes.baseURL}fetchMyDoctorProfile?doctor_id=$id';
  }

  static const String notificationUrl = 'https://fcm.googleapis.com/fcm/send';



//------------------ patient api urls -----------------------------//
  static const String registration = '${ConstRes.userbaseURL}registerUser';
  static const String updateUserDetails =
      '${ConstRes.userbaseURL}updateUserDetails';
  static const String fetchNotification =
      '${ConstRes.userbaseURL}fetchNotification';
  static const String fetchHomePageData =
      '${ConstRes.userbaseURL}fetchHomePageData';
  static const String searchDoctor = '${ConstRes.userbaseURL}searchDoctor';
  static const String fetchPatients = '${ConstRes.userbaseURL}fetchPatients';
  static const String addPatient = '${ConstRes.userbaseURL}addPatient';
  static const String editPatient = '${ConstRes.userbaseURL}editPatient';
  static const String deletePatient = '${ConstRes.userbaseURL}deletePatient';
  static const String fetchDoctorProfile =
      '${ConstRes.userbaseURL}fetchDoctorProfile';
  static const String userfetchDoctorReviews =
      '${ConstRes.userbaseURL}fetchDoctorReviews';
  static const String fetchFavoriteDoctors =
      '${ConstRes.userbaseURL}fetchFavoriteDoctors';
  static const String fetchCoupons = '${ConstRes.userbaseURL}fetchCoupons';
  static const String fetchMyUserDetails =
      '${ConstRes.userbaseURL}fetchMyUserDetails';
  static const String addMoneyToUserWallet =
      '${ConstRes.userbaseURL}addMoneyToUserWallet';
  static const String addAppointment = '${ConstRes.userbaseURL}addAppointment';
  static const String fetchUserWithdrawRequests =
      '${ConstRes.userbaseURL}fetchUserWithdrawRequests';
  static const String fetchWalletStatement =
      '${ConstRes.userbaseURL}fetchWalletStatement';
  static const String submitUserWithdrawRequest =
      '${ConstRes.userbaseURL}submitUserWithdrawRequest';
  static const String userfetchAppointmentDetails =
      '${ConstRes.userbaseURL}fetchAppointmentDetails';
  static const String fetchMyPrescriptions =
      '${ConstRes.userbaseURL}fetchMyPrescriptions';
  static const String fetchMyAppointments =
      '${ConstRes.userbaseURL}fetchMyAppointments';
  static const String addRating = '${ConstRes.userbaseURL}addRating';
  static const String addLiveCallRating = '${ConstRes.userbaseURL}addLiveCallRating';
  static const String rescheduleAppointment =
      '${ConstRes.userbaseURL}rescheduleAppointment';
  static const String cancelAppointment =
      '${ConstRes.userbaseURL}cancelAppointment';
  static const String logOut = '${ConstRes.userbaseURL}logOut';
  static const String deleteUserAccount =
      '${ConstRes.userbaseURL}deleteUserAccount';
  static const String getDoctorsDeviceTokens = '${ConstRes.userbaseURL}getDoctorsDeviceTokens';
}

///------------------------ Params ------------------------///

const String pApiKeyName = 'apikey';
const String pPost = 'POST';
const String pMobileNumber = 'mobile_number';
const String pDeviceToken = 'device_token';
const String pDoctorId = 'doctor_id';
const String pName = 'name';
const String pCountryCode = 'country_code';
const String pGender = 'gender';
const String pCategoryId = 'category_id';
const String pDesignation = 'designation';
const String pDegrees = 'degrees';
const String pLanguagesSpoken = 'languages_spoken';
const String pExperienceYear = 'experience_year';
const String pConsultationFee = 'consultation_fee';
const String pAboutYourself = 'about_youself';
const String pEducationalJourney = 'educational_journey';
const String pOnlineConsultation = 'online_consultation';
const String pClinicConsultation = 'clinic_consultation';
const String pImage = 'image';
const pMedicalhistory = 'medical_history';
const String pIsNotification = 'is_notification';
const String pOnVacation = 'on_vacation';
const String pOnlneStatus = 'is_online';
const String pClinicLong = 'clinic_long';
const String pClinicLat = 'clinic_lat';
const String pClinicAddress = 'clinic_address';
const String pClinicName = 'clinic_name';
const String pAbout = 'about';
const String pTitle = 'title';
const String pStart = 'start';
const String pCount = 'count';
const String pType = 'type';
const String pServiceId = 'service_id';
const String pExpertiseId = 'expertise_id';
const String pExperienceId = 'experience_id';
const String pAwardId = 'award_id';
const String pHospitalLat = 'hospital_lat';
const String pHospitalLong = 'hospital_long';
const String pServiceLCationId = 'serviceLocation_id';
const String pHospitalAddress = 'hospital_address';
const String pHospitalTitle = 'hospital_title';
const String pDate = 'date';
const String pHolidayId = 'holiday_id';
const String pTime = 'time';
const String pWeekday = 'weekday';
const String pSlotId = 'slot_id';
const String pBankName = 'bank_name';
const String pAccountNumber = 'account_number';
const String pHolder = 'holder';
const String pSwiftCode = 'swift_code';
const String pChequePhoto = 'cheque_photo';
const String pAppointmentId = 'appointment_id';
const String pUserId = 'user_id';
const String pMedicine = 'medicine';
const String pPrescriptionId = 'prescription_id';
const String pCompletionOtp = 'completion_otp';
const String pDiagnosedWith = 'diagnosed_with';
const String pMonth = 'month';
const String pYear = 'year';
const String pTen = '10';
const String pFile = 'file';
const String pChannelName = 'channelName';


const String pApikeyName = 'apikey';
const String pIdentity = 'identity';
const String pFullName = 'fullname';
const String pDeviceType = 'device_type';
const String pLoginType = 'login_type';
const String pDob = 'dob';
const String pFavouriteDoctors = 'favourite_doctors';
const String pProfileImage = 'profile_image';
const String pPatientId = 'patient_id';
const String pOrderSummary = 'order_summary';
const String pTotalAmount = 'total_amount';
const String pPayableAmount = 'payable_amount';
const String pSortType = 'sort_type';
const String pKeyword = 'keyword';
const String pAge = 'age';
const String pRelation = 'relation';
const String pDocuments = 'documents[]';
const String pProblem = 'problem';
const String pAmount = 'amount';
const String pGateway = 'gateway';
const String pTransactionId = 'transaction_id';
const String pTransactionSummary = 'transaction_summary';
const String pIsCouponApplied = 'is_coupon_applied';
const String pDiscountAmount = 'discount_amount';
const String pServiceAmount = 'service_amount';
const String pSubtotal = 'subtotal';
const String pTotalTaxAmount = 'total_tax_amount';
const String pCouponTitle = 'coupon_title';
const String pCouponId = 'coupon_id';
const String pBankTitle = 'bank_title';
const String pComment = 'comment';
const String pRating = 'rating';