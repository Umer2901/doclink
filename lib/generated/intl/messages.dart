import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'messages_ar.dart';
import 'messages_da.dart';
import 'messages_de.dart';
import 'messages_el.dart';
import 'messages_en.dart';
import 'messages_es.dart';
import 'messages_fr.dart';
import 'messages_hi.dart';
import 'messages_id.dart';
import 'messages_it.dart';
import 'messages_ja.dart';
import 'messages_ko.dart';
import 'messages_nb.dart';
import 'messages_nl.dart';
import 'messages_pl.dart';
import 'messages_pt.dart';
import 'messages_ru.dart';
import 'messages_th.dart';
import 'messages_tr.dart';
import 'messages_vi.dart';
import 'messages_zh.dart';

/// Callers can lookup localized strings with an instance of PS
/// returned by `PS.of(context)`.
///
/// Applications need to include `PS.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'intl/messages.dart';
///
/// return MaterialApp(
///   localizationsDelegates: PS.localizationsDelegates,
///   supportedLocales: PS.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the PS.supportedLocales
/// property.
abstract class PS {
  PS(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static PS? of(BuildContext context) {
    return Localizations.of<PS>(context, PS);
  }

  static const LocalizationsDelegate<PS> delegate = _PSDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('da'),
    Locale('de'),
    Locale('el'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('nb'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt'),
    Locale('ru'),
    Locale('th'),
    Locale('tr'),
    Locale('vi'),
    Locale('zh')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'DOCTOR.IO'**
  String get appName;

  /// No description provided for @craftYourProfileEtc.
  ///
  /// In en, this message translates to:
  /// **'Craft your profile,\nGet appointments, Accept them,\nProvide consultation, Make Money'**
  String get craftYourProfileEtc;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue As Patient'**
  String get continueText;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @enterYourPhoneNumberEtc.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number to continue.\nWe will send an OTP for verification'**
  String get enterYourPhoneNumberEtc;

  /// No description provided for @phoneVerification.
  ///
  /// In en, this message translates to:
  /// **'Phone Verification'**
  String get phoneVerification;

  /// No description provided for @weHaveSentOtpEtc.
  ///
  /// In en, this message translates to:
  /// **'We have sent OTP verification code\non phone number you entered.'**
  String get weHaveSentOtpEtc;

  /// No description provided for @enterYourOtp.
  ///
  /// In en, this message translates to:
  /// **'Enter Your OTP'**
  String get enterYourOtp;

  /// No description provided for @enterMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Mobile Number'**
  String get enterMobileNumber;

  /// No description provided for @reSend.
  ///
  /// In en, this message translates to:
  /// **'ReSend'**
  String get reSend;

  /// No description provided for @doctorRegistration.
  ///
  /// In en, this message translates to:
  /// **'Doctor Registration'**
  String get doctorRegistration;

  /// No description provided for @selectGender.
  ///
  /// In en, this message translates to:
  /// **'Select Gender'**
  String get selectGender;

  /// No description provided for @selectCountry.
  ///
  /// In en, this message translates to:
  /// **'Select Country'**
  String get selectCountry;

  /// No description provided for @yourName.
  ///
  /// In en, this message translates to:
  /// **'Your Name (Name & Surname)'**
  String get yourName;

  /// No description provided for @yourPhoneNumberEtc.
  ///
  /// In en, this message translates to:
  /// **'Your phone number has been verified'**
  String get yourPhoneNumberEtc;

  /// No description provided for @dr.
  ///
  /// In en, this message translates to:
  /// **'Dr.'**
  String get dr;

  /// No description provided for @selectYourCategory.
  ///
  /// In en, this message translates to:
  /// **'Select Your Category'**
  String get selectYourCategory;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @yourCategoryIsNotEtc.
  ///
  /// In en, this message translates to:
  /// **'Your category is not available?'**
  String get yourCategoryIsNotEtc;

  /// No description provided for @suggestUs.
  ///
  /// In en, this message translates to:
  /// **'Suggest Us'**
  String get suggestUs;

  /// No description provided for @suggestCategory.
  ///
  /// In en, this message translates to:
  /// **'Suggest Category'**
  String get suggestCategory;

  /// No description provided for @enterTheCategoryEtc.
  ///
  /// In en, this message translates to:
  /// **'Enter the category you want to add'**
  String get enterTheCategoryEtc;

  /// No description provided for @enterCategoryName.
  ///
  /// In en, this message translates to:
  /// **'Enter category name'**
  String get enterCategoryName;

  /// No description provided for @explainUsAboutIt.
  ///
  /// In en, this message translates to:
  /// **'Explain us about it..'**
  String get explainUsAboutIt;

  /// No description provided for @addYourDesignation.
  ///
  /// In en, this message translates to:
  /// **'Add your designation'**
  String get addYourDesignation;

  /// No description provided for @addYourDegreesEtc.
  ///
  /// In en, this message translates to:
  /// **'Add your degrees to display them here on your profile'**
  String get addYourDegreesEtc;

  /// No description provided for @designationEtc.
  ///
  /// In en, this message translates to:
  /// **'Designation (EG: Senior Pediatric Surgeon)'**
  String get designationEtc;

  /// No description provided for @enterDesignation.
  ///
  /// In en, this message translates to:
  /// **'Enter designation'**
  String get enterDesignation;

  /// No description provided for @enterYourDegreesEtc.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Degrees : Separated by ( , )'**
  String get enterYourDegreesEtc;

  /// No description provided for @exampleMsEtc.
  ///
  /// In en, this message translates to:
  /// **'Example : MS( General Surgery) from AIMS, BG nagara'**
  String get exampleMsEtc;

  /// No description provided for @enterDegrees.
  ///
  /// In en, this message translates to:
  /// **'Enter degrees..'**
  String get enterDegrees;

  /// No description provided for @languagesYouSpeakEtc.
  ///
  /// In en, this message translates to:
  /// **'Languages You Speak : Separated by ( , )'**
  String get languagesYouSpeakEtc;

  /// No description provided for @exampleLanguage.
  ///
  /// In en, this message translates to:
  /// **'Example : Hindi, English, French'**
  String get exampleLanguage;

  /// No description provided for @enterLanguages.
  ///
  /// In en, this message translates to:
  /// **'Enter languages..'**
  String get enterLanguages;

  /// No description provided for @yearsOfExperience.
  ///
  /// In en, this message translates to:
  /// **'Years Of Experience'**
  String get yearsOfExperience;

  /// No description provided for @numberOfYears.
  ///
  /// In en, this message translates to:
  /// **'Number of years'**
  String get numberOfYears;

  /// No description provided for @consultationFee.
  ///
  /// In en, this message translates to:
  /// **'Consultation Fees'**
  String get consultationFee;

  /// No description provided for @youCanChangeThisEtc.
  ///
  /// In en, this message translates to:
  /// **'You can change this later whenever you want'**
  String get youCanChangeThisEtc;

  /// No description provided for @aboutYourSelf.
  ///
  /// In en, this message translates to:
  /// **'About Yourself'**
  String get aboutYourSelf;

  /// No description provided for @explainAboutYourSelfBriefly.
  ///
  /// In en, this message translates to:
  /// **'Explain about yourself briefly'**
  String get explainAboutYourSelfBriefly;

  /// No description provided for @yourEducationalJourney.
  ///
  /// In en, this message translates to:
  /// **'Your Educational Journey'**
  String get yourEducationalJourney;

  /// No description provided for @explainBrieflyForBetterIdea.
  ///
  /// In en, this message translates to:
  /// **'Explain briefly for better idea'**
  String get explainBrieflyForBetterIdea;

  /// No description provided for @enterHere.
  ///
  /// In en, this message translates to:
  /// **'Enter here...'**
  String get enterHere;

  /// No description provided for @chooseConsultationType.
  ///
  /// In en, this message translates to:
  /// **'Choose Consultation Type'**
  String get chooseConsultationType;

  /// No description provided for @youCanChangeThisLater.
  ///
  /// In en, this message translates to:
  /// **'You can change this later'**
  String get youCanChangeThisLater;

  /// No description provided for @online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online;

  /// No description provided for @atClinic.
  ///
  /// In en, this message translates to:
  /// **'At Clinic'**
  String get atClinic;

  /// No description provided for @addClinicDetails.
  ///
  /// In en, this message translates to:
  /// **'Add Clinic details'**
  String get addClinicDetails;

  /// No description provided for @whereYouWillBeConsultingPatients.
  ///
  /// In en, this message translates to:
  /// **'Where you will be consulting patients'**
  String get whereYouWillBeConsultingPatients;

  /// No description provided for @clinicAddress.
  ///
  /// In en, this message translates to:
  /// **'Clinic Address'**
  String get clinicAddress;

  /// No description provided for @clinicName.
  ///
  /// In en, this message translates to:
  /// **'Clinic Name'**
  String get clinicName;

  /// No description provided for @clinicLocation.
  ///
  /// In en, this message translates to:
  /// **'Clinic Location'**
  String get clinicLocation;

  /// No description provided for @clickToFetchLocation.
  ///
  /// In en, this message translates to:
  /// **'Click to fetch location'**
  String get clickToFetchLocation;

  /// No description provided for @doctor.
  ///
  /// In en, this message translates to:
  /// **'DOCTOR'**
  String get doctor;

  /// No description provided for @registration.
  ///
  /// In en, this message translates to:
  /// **'Registration'**
  String get registration;

  /// No description provided for @submissionSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Submission Successful'**
  String get submissionSuccessful;

  /// No description provided for @requestId.
  ///
  /// In en, this message translates to:
  /// **'Request ID : '**
  String get requestId;

  /// No description provided for @desc1.
  ///
  /// In en, this message translates to:
  /// **'All of the details you have submitted\nhas been received by us.\nwe will check and update you on this\nonce we have an update for you.'**
  String get desc1;

  /// No description provided for @desc2.
  ///
  /// In en, this message translates to:
  /// **'It will take around 3 to 4 business\ndays to check and verify your profile'**
  String get desc2;

  /// No description provided for @desc3.
  ///
  /// In en, this message translates to:
  /// **'Write us on below details if you\nhave any questions and queries.'**
  String get desc3;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'salon.help@cutfx.com'**
  String get email;

  /// No description provided for @appointments.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get appointments;

  /// No description provided for @requests.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get requests;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @callNow.
  ///
  /// In en, this message translates to:
  /// **'Call Now'**
  String get callNow;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @selectMonth.
  ///
  /// In en, this message translates to:
  /// **'Select Month'**
  String get selectMonth;

  /// No description provided for @jan.
  ///
  /// In en, this message translates to:
  /// **'Jan'**
  String get jan;

  /// No description provided for @feb.
  ///
  /// In en, this message translates to:
  /// **'Feb'**
  String get feb;

  /// No description provided for @mar.
  ///
  /// In en, this message translates to:
  /// **'Mar'**
  String get mar;

  /// No description provided for @apr.
  ///
  /// In en, this message translates to:
  /// **'Apr'**
  String get apr;

  /// No description provided for @may.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get may;

  /// No description provided for @jun.
  ///
  /// In en, this message translates to:
  /// **'Jun'**
  String get jun;

  /// No description provided for @jul.
  ///
  /// In en, this message translates to:
  /// **'Jul'**
  String get jul;

  /// No description provided for @aug.
  ///
  /// In en, this message translates to:
  /// **'Aug'**
  String get aug;

  /// No description provided for @sep.
  ///
  /// In en, this message translates to:
  /// **'Sep'**
  String get sep;

  /// No description provided for @oct.
  ///
  /// In en, this message translates to:
  /// **'Oct'**
  String get oct;

  /// No description provided for @nov.
  ///
  /// In en, this message translates to:
  /// **'Nov'**
  String get nov;

  /// No description provided for @dec.
  ///
  /// In en, this message translates to:
  /// **'Dec'**
  String get dec;

  /// No description provided for @languages.
  ///
  /// In en, this message translates to:
  /// **'LANGUAGES'**
  String get languages;

  /// No description provided for @manage.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get manage;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'SERVICES'**
  String get services;

  /// No description provided for @thereIsNothingToShow.
  ///
  /// In en, this message translates to:
  /// **'There is nothing to show.\n'**
  String get thereIsNothingToShow;

  /// No description provided for @pleaseAddSome.
  ///
  /// In en, this message translates to:
  /// **'Please add some '**
  String get pleaseAddSome;

  /// No description provided for @toYourProfile.
  ///
  /// In en, this message translates to:
  /// **' to your profile.'**
  String get toYourProfile;

  /// No description provided for @aboutDr.
  ///
  /// In en, this message translates to:
  /// **'ABOUT DR.'**
  String get aboutDr;

  /// No description provided for @happyPatients.
  ///
  /// In en, this message translates to:
  /// **'HAPPY PATIENTS'**
  String get happyPatients;

  /// No description provided for @exampleHypertensionEtc.
  ///
  /// In en, this message translates to:
  /// **'Example : Hypertension Treatment, Obesity Treatment'**
  String get exampleHypertensionEtc;

  /// No description provided for @addService.
  ///
  /// In en, this message translates to:
  /// **'Add Service'**
  String get addService;

  /// No description provided for @servicesLocation.
  ///
  /// In en, this message translates to:
  /// **'SERVICES LOCATIONS'**
  String get servicesLocation;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @vacationMode.
  ///
  /// In en, this message translates to:
  /// **'Vacation Mode'**
  String get vacationMode;

  /// No description provided for @keepingItOffYourProfileEtc.
  ///
  /// In en, this message translates to:
  /// **'Keeping it off, your profile will not be shown\nto the patients until turned on'**
  String get keepingItOffYourProfileEtc;

  /// No description provided for @keepItOnIfYouWantEtc.
  ///
  /// In en, this message translates to:
  /// **'Keep it On, if you want to receive notifications'**
  String get keepItOnIfYouWantEtc;

  /// No description provided for @pushNotification.
  ///
  /// In en, this message translates to:
  /// **'Push Notification'**
  String get pushNotification;

  /// No description provided for @editProfileDetails.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile Details'**
  String get editProfileDetails;

  /// No description provided for @appointmentHistory.
  ///
  /// In en, this message translates to:
  /// **'Appointment History'**
  String get appointmentHistory;

  /// No description provided for @appointmentSlots.
  ///
  /// In en, this message translates to:
  /// **'Appointment Slots'**
  String get appointmentSlots;

  /// No description provided for @manageHolidays.
  ///
  /// In en, this message translates to:
  /// **'Manage Holidays'**
  String get manageHolidays;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @payouts.
  ///
  /// In en, this message translates to:
  /// **'Payouts'**
  String get payouts;

  /// No description provided for @termsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms Of Use'**
  String get termsOfUse;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @bankDetails.
  ///
  /// In en, this message translates to:
  /// **'Bank Details'**
  String get bankDetails;

  /// No description provided for @earningReport.
  ///
  /// In en, this message translates to:
  /// **'Earning Report'**
  String get earningReport;

  /// No description provided for @helpAndFAQs.
  ///
  /// In en, this message translates to:
  /// **'Help & FAQs'**
  String get helpAndFAQs;

  /// No description provided for @deleteMyAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete My Account'**
  String get deleteMyAccount;

  /// No description provided for @profileDetails.
  ///
  /// In en, this message translates to:
  /// **'Profile Details'**
  String get profileDetails;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @aboutYourselfEducation.
  ///
  /// In en, this message translates to:
  /// **'About Yourself / Education'**
  String get aboutYourselfEducation;

  /// No description provided for @consultationType.
  ///
  /// In en, this message translates to:
  /// **'Consultation Type'**
  String get consultationType;

  /// No description provided for @expertise.
  ///
  /// In en, this message translates to:
  /// **'EXPERTISE'**
  String get expertise;

  /// No description provided for @serviceLocations.
  ///
  /// In en, this message translates to:
  /// **'Service Locations'**
  String get serviceLocations;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @enterYourName.
  ///
  /// In en, this message translates to:
  /// **'Enter your Name'**
  String get enterYourName;

  /// No description provided for @yourCountry.
  ///
  /// In en, this message translates to:
  /// **'Your Country (You are serving)'**
  String get yourCountry;

  /// No description provided for @aboutAndEducation.
  ///
  /// In en, this message translates to:
  /// **'About/Education'**
  String get aboutAndEducation;

  /// No description provided for @manageServices.
  ///
  /// In en, this message translates to:
  /// **'Manage Services'**
  String get manageServices;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @hospitalAddress.
  ///
  /// In en, this message translates to:
  /// **'Hospital Address'**
  String get hospitalAddress;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @addAppointmentSlotsByWeekDays.
  ///
  /// In en, this message translates to:
  /// **'Add appointment slots by week days'**
  String get addAppointmentSlotsByWeekDays;

  /// No description provided for @hospitalName.
  ///
  /// In en, this message translates to:
  /// **'Hospital Name'**
  String get hospitalName;

  /// No description provided for @addServiceLocation.
  ///
  /// In en, this message translates to:
  /// **'Add Service Location'**
  String get addServiceLocation;

  /// No description provided for @addHospitalsWhereYouEtc.
  ///
  /// In en, this message translates to:
  /// **'Add Hospitals Where You Visit (Optional)'**
  String get addHospitalsWhereYouEtc;

  /// No description provided for @thisHelpsPatientsToEtc.
  ///
  /// In en, this message translates to:
  /// **'This helps patients to take a visit to you directly on those locations.'**
  String get thisHelpsPatientsToEtc;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @onThoseDaysPatientsEtc.
  ///
  /// In en, this message translates to:
  /// **'On those days, Patients would not be able to book appointments for consultation'**
  String get onThoseDaysPatientsEtc;

  /// No description provided for @addYourHolidaysHere.
  ///
  /// In en, this message translates to:
  /// **'Add your holidays here'**
  String get addYourHolidaysHere;

  /// No description provided for @withdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get withdraw;

  /// No description provided for @statement.
  ///
  /// In en, this message translates to:
  /// **'Statement'**
  String get statement;

  /// No description provided for @commission.
  ///
  /// In en, this message translates to:
  /// **'Commission'**
  String get commission;

  /// No description provided for @earning.
  ///
  /// In en, this message translates to:
  /// **'Earning'**
  String get earning;

  /// No description provided for @totalEarnings.
  ///
  /// In en, this message translates to:
  /// **'Total Earnings'**
  String get totalEarnings;

  /// No description provided for @totalOrders.
  ///
  /// In en, this message translates to:
  /// **'Total Orders'**
  String get totalOrders;

  /// No description provided for @payoutHistory.
  ///
  /// In en, this message translates to:
  /// **'Payout History'**
  String get payoutHistory;

  /// No description provided for @addBankDetails.
  ///
  /// In en, this message translates to:
  /// **'Add Bank Details'**
  String get addBankDetails;

  /// No description provided for @bankName.
  ///
  /// In en, this message translates to:
  /// **'Bank Name'**
  String get bankName;

  /// No description provided for @accountNumber.
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get accountNumber;

  /// No description provided for @cancelledChequePhoto.
  ///
  /// In en, this message translates to:
  /// **'Cancelled Cheque Photo'**
  String get cancelledChequePhoto;

  /// No description provided for @swiftCode.
  ///
  /// In en, this message translates to:
  /// **'Swift Code'**
  String get swiftCode;

  /// No description provided for @holdersName.
  ///
  /// In en, this message translates to:
  /// **'Holders Name'**
  String get holdersName;

  /// No description provided for @reEnterAccountNumber.
  ///
  /// In en, this message translates to:
  /// **'Re-Enter Account Number'**
  String get reEnterAccountNumber;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @consultationCharge.
  ///
  /// In en, this message translates to:
  /// **'Consultation Charge'**
  String get consultationCharge;

  /// No description provided for @couponDiscount.
  ///
  /// In en, this message translates to:
  /// **'Coupon Discount'**
  String get couponDiscount;

  /// No description provided for @totalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get totalAmount;

  /// No description provided for @previousAppointments.
  ///
  /// In en, this message translates to:
  /// **'Previous Appointments'**
  String get previousAppointments;

  /// No description provided for @clickToSeePreviousEtc.
  ///
  /// In en, this message translates to:
  /// **'Click to see previous appointments with you'**
  String get clickToSeePreviousEtc;

  /// No description provided for @problem.
  ///
  /// In en, this message translates to:
  /// **'Problem'**
  String get problem;

  /// No description provided for @attachments.
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get attachments;

  /// No description provided for @decline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get decline;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @medicalPrescription.
  ///
  /// In en, this message translates to:
  /// **'Medical Prescription'**
  String get medicalPrescription;

  /// No description provided for @messages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messages;

  /// No description provided for @appointmentDetails.
  ///
  /// In en, this message translates to:
  /// **'Appointment Details'**
  String get appointmentDetails;

  /// No description provided for @createPrescriptionFor.
  ///
  /// In en, this message translates to:
  /// **'Create prescription for'**
  String get createPrescriptionFor;

  /// No description provided for @afterMeal.
  ///
  /// In en, this message translates to:
  /// **'After Meal'**
  String get afterMeal;

  /// No description provided for @beforeMeal.
  ///
  /// In en, this message translates to:
  /// **'Before Meal'**
  String get beforeMeal;

  /// No description provided for @addMedicine.
  ///
  /// In en, this message translates to:
  /// **'Add Medicine'**
  String get addMedicine;

  /// No description provided for @diagnosedWith.
  ///
  /// In en, this message translates to:
  /// **'Diagnosed With'**
  String get diagnosedWith;

  /// No description provided for @medicalName.
  ///
  /// In en, this message translates to:
  /// **'Medicine Name'**
  String get medicalName;

  /// No description provided for @medicine.
  ///
  /// In en, this message translates to:
  /// **'Medicine'**
  String get medicine;

  /// No description provided for @totalUnits.
  ///
  /// In en, this message translates to:
  /// **'Total Units'**
  String get totalUnits;

  /// No description provided for @extraNotes.
  ///
  /// In en, this message translates to:
  /// **'Extra Notes'**
  String get extraNotes;

  /// No description provided for @dosageDetailsEtc.
  ///
  /// In en, this message translates to:
  /// **'Dosage Details (Timing, Unit)'**
  String get dosageDetailsEtc;

  /// No description provided for @timingUnitEtc.
  ///
  /// In en, this message translates to:
  /// **'Timing, Unit. (EG: Twice a day, 1 tablet) '**
  String get timingUnitEtc;

  /// No description provided for @quantityEtc.
  ///
  /// In en, this message translates to:
  /// **'Quantity (Total Count)'**
  String get quantityEtc;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @writeHere.
  ///
  /// In en, this message translates to:
  /// **'Write Here'**
  String get writeHere;

  /// No description provided for @noteOnlyIfYouEtc.
  ///
  /// In en, this message translates to:
  /// **'Note: Only if you feel fever and headace'**
  String get noteOnlyIfYouEtc;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @locationFetched.
  ///
  /// In en, this message translates to:
  /// **'Location Fetched'**
  String get locationFetched;

  /// No description provided for @qRScan.
  ///
  /// In en, this message translates to:
  /// **'QR Scan'**
  String get qRScan;

  /// No description provided for @scanTheBookingQREtc.
  ///
  /// In en, this message translates to:
  /// **'Scan the booking QR to get the details\nquickly'**
  String get scanTheBookingQREtc;

  /// No description provided for @complete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get complete;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @patientFeedback.
  ///
  /// In en, this message translates to:
  /// **'Patient\'s Feedback'**
  String get patientFeedback;

  /// No description provided for @pleaseEnterMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Mobile Number'**
  String get pleaseEnterMobileNumber;

  /// No description provided for @mapScreen.
  ///
  /// In en, this message translates to:
  /// **'Map Screen'**
  String get mapScreen;

  /// No description provided for @myCurrentLocation.
  ///
  /// In en, this message translates to:
  /// **'My Current Location'**
  String get myCurrentLocation;

  /// No description provided for @pleaseSelectProfileImage.
  ///
  /// In en, this message translates to:
  /// **'Please Select Profile Image'**
  String get pleaseSelectProfileImage;

  /// No description provided for @pleaseEnterDesignation.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Designation'**
  String get pleaseEnterDesignation;

  /// No description provided for @pleaseEnterDegree.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Degree'**
  String get pleaseEnterDegree;

  /// No description provided for @pleaseEnterLanguages.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Languages'**
  String get pleaseEnterLanguages;

  /// No description provided for @pleaseEnterYearOfExperience.
  ///
  /// In en, this message translates to:
  /// **'Please Enter year of Experience'**
  String get pleaseEnterYearOfExperience;

  /// No description provided for @pleaseEnterConsultationFee.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Consultation Fee'**
  String get pleaseEnterConsultationFee;

  /// No description provided for @locationFetchSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Location Fetch Successfully'**
  String get locationFetchSuccessfully;

  /// No description provided for @locationNotFetch.
  ///
  /// In en, this message translates to:
  /// **'Location Not Fetch'**
  String get locationNotFetch;

  /// No description provided for @chooseOneConsultationType.
  ///
  /// In en, this message translates to:
  /// **'Choose one Consultation type'**
  String get chooseOneConsultationType;

  /// No description provided for @pleaseEnterClinicName.
  ///
  /// In en, this message translates to:
  /// **'Please Enter clinic name'**
  String get pleaseEnterClinicName;

  /// No description provided for @pleaseEnterClinicAddress.
  ///
  /// In en, this message translates to:
  /// **'Please Enter clinic address'**
  String get pleaseEnterClinicAddress;

  /// No description provided for @pleaseEnterEducationYourSelf.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Education YourSelf'**
  String get pleaseEnterEducationYourSelf;

  /// No description provided for @pleaseEnterAboutYourSelf.
  ///
  /// In en, this message translates to:
  /// **'Please Enter About YourSelf'**
  String get pleaseEnterAboutYourSelf;

  /// No description provided for @addCategoryNameForSuggestion.
  ///
  /// In en, this message translates to:
  /// **'Add Category Name for suggestion'**
  String get addCategoryNameForSuggestion;

  /// No description provided for @pleaseExplainBrieflyEtc.
  ///
  /// In en, this message translates to:
  /// **'Please explain briefly why you add the category'**
  String get pleaseExplainBrieflyEtc;

  /// No description provided for @pleaseSelectCategory.
  ///
  /// In en, this message translates to:
  /// **'Please Select Category.'**
  String get pleaseSelectCategory;

  /// No description provided for @pleaseEnterName.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Name'**
  String get pleaseEnterName;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @feMale.
  ///
  /// In en, this message translates to:
  /// **'FeMale'**
  String get feMale;

  /// No description provided for @allOfTheDetailsEtc.
  ///
  /// In en, this message translates to:
  /// **'All of the details you have submitted has been received by us.we will check and update you on this once we have an update for you.'**
  String get allOfTheDetailsEtc;

  /// No description provided for @itWillTakeAroundEtc.
  ///
  /// In en, this message translates to:
  /// **'It will take around 3 to 4 business days to check and verify your profile'**
  String get itWillTakeAroundEtc;

  /// No description provided for @writeUsOnBelowEtc.
  ///
  /// In en, this message translates to:
  /// **'Write us on below details if you have any questions and queries.'**
  String get writeUsOnBelowEtc;

  /// No description provided for @smsVerificationCodeEtc.
  ///
  /// In en, this message translates to:
  /// **'SMS verification code used to create the phone auth credential is invalid'**
  String get smsVerificationCodeEtc;

  /// No description provided for @theProvidedPhoneEtc.
  ///
  /// In en, this message translates to:
  /// **'The provided phone number is not valid.'**
  String get theProvidedPhoneEtc;

  /// No description provided for @pleaseEnterYourOtp.
  ///
  /// In en, this message translates to:
  /// **'Please enter your otp.'**
  String get pleaseEnterYourOtp;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @less.
  ///
  /// In en, this message translates to:
  /// **'Less'**
  String get less;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @editServiceLocation.
  ///
  /// In en, this message translates to:
  /// **'Edit Service Location'**
  String get editServiceLocation;

  /// No description provided for @enterBankName.
  ///
  /// In en, this message translates to:
  /// **'Enter Bank Name'**
  String get enterBankName;

  /// No description provided for @enterAccountName.
  ///
  /// In en, this message translates to:
  /// **'Enter Account Number'**
  String get enterAccountName;

  /// No description provided for @enterReAccountNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Re-enter Account Number'**
  String get enterReAccountNumber;

  /// No description provided for @enterHolderName.
  ///
  /// In en, this message translates to:
  /// **'Enter Holder Name'**
  String get enterHolderName;

  /// No description provided for @enterSwiftCode.
  ///
  /// In en, this message translates to:
  /// **'Enter Swift Code'**
  String get enterSwiftCode;

  /// No description provided for @completionOtp.
  ///
  /// In en, this message translates to:
  /// **'Completion OTP'**
  String get completionOtp;

  /// No description provided for @pleaseAddCancelChequePhoto.
  ///
  /// In en, this message translates to:
  /// **'Please add cancel cheque photo'**
  String get pleaseAddCancelChequePhoto;

  /// No description provided for @refund.
  ///
  /// In en, this message translates to:
  /// **'Refund'**
  String get refund;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No Data'**
  String get noData;

  /// No description provided for @waitingForConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Waiting for confirmation'**
  String get waitingForConfirmation;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @accepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get accepted;

  /// No description provided for @declined.
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get declined;

  /// No description provided for @deviceTokenEmpty.
  ///
  /// In en, this message translates to:
  /// **'Device Token is Empty Please Refresh The App'**
  String get deviceTokenEmpty;

  /// No description provided for @noHolidayData.
  ///
  /// In en, this message translates to:
  /// **'No Holiday'**
  String get noHolidayData;

  /// No description provided for @noRequestData.
  ///
  /// In en, this message translates to:
  /// **'No Request Data'**
  String get noRequestData;

  /// No description provided for @years.
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get years;

  /// No description provided for @noAddressFound.
  ///
  /// In en, this message translates to:
  /// **'No Address Found'**
  String get noAddressFound;

  /// No description provided for @ratings.
  ///
  /// In en, this message translates to:
  /// **'Ratings'**
  String get ratings;

  /// No description provided for @unKnown.
  ///
  /// In en, this message translates to:
  /// **'UnKnown'**
  String get unKnown;

  /// No description provided for @yourProfileIsPending.
  ///
  /// In en, this message translates to:
  /// **'Your Profile is Pending'**
  String get yourProfileIsPending;

  /// No description provided for @pleaseAddServices.
  ///
  /// In en, this message translates to:
  /// **'PLease Add Services'**
  String get pleaseAddServices;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @pleaseEditServices.
  ///
  /// In en, this message translates to:
  /// **'PLease Edit Services'**
  String get pleaseEditServices;

  /// No description provided for @please.
  ///
  /// In en, this message translates to:
  /// **'PLease'**
  String get please;

  /// No description provided for @pleaseSelectMeal.
  ///
  /// In en, this message translates to:
  /// **'Please Select Meal'**
  String get pleaseSelectMeal;

  /// No description provided for @pleaseAtLeastOneMedicineAdd.
  ///
  /// In en, this message translates to:
  /// **'Please at Least one medicine add'**
  String get pleaseAtLeastOneMedicineAdd;

  /// No description provided for @pleaseEnterExtraNotes.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Extra Notes'**
  String get pleaseEnterExtraNotes;

  /// No description provided for @earningPerDay.
  ///
  /// In en, this message translates to:
  /// **'Earning Per Day'**
  String get earningPerDay;

  /// No description provided for @sale.
  ///
  /// In en, this message translates to:
  /// **'Sale'**
  String get sale;

  /// No description provided for @purchase.
  ///
  /// In en, this message translates to:
  /// **'Purchase'**
  String get purchase;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @subTotal.
  ///
  /// In en, this message translates to:
  /// **'Sub Total'**
  String get subTotal;

  /// No description provided for @payableAmount.
  ///
  /// In en, this message translates to:
  /// **'Payable Amount'**
  String get payableAmount;

  /// No description provided for @pleaseAddYourBankEtc.
  ///
  /// In en, this message translates to:
  /// **'Please add your bank account details'**
  String get pleaseAddYourBankEtc;

  /// No description provided for @minimumAmountToWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Minimum amount to withdraw'**
  String get minimumAmountToWithdraw;

  /// No description provided for @doYouReallyWantToEtc.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to delete your account? all of your data will deleted and you won’t be able to recover it again !\n\nDo you really want to proceed?'**
  String get doYouReallyWantToEtc;

  /// No description provided for @areYouSureLogout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?\n do want to logout?'**
  String get areYouSureLogout;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @doctorBlockByAdmin.
  ///
  /// In en, this message translates to:
  /// **'Doctor block by admin'**
  String get doctorBlockByAdmin;

  /// No description provided for @sendMedia.
  ///
  /// In en, this message translates to:
  /// **'Send Media'**
  String get sendMedia;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @waitingFor.
  ///
  /// In en, this message translates to:
  /// **'Waiting for'**
  String get waitingFor;

  /// No description provided for @muteAudio.
  ///
  /// In en, this message translates to:
  /// **'Mute Audio'**
  String get muteAudio;

  /// No description provided for @joinAChannel.
  ///
  /// In en, this message translates to:
  /// **'Join a channel'**
  String get joinAChannel;

  /// No description provided for @selectMsg.
  ///
  /// In en, this message translates to:
  /// **'Select Message'**
  String get selectMsg;

  /// No description provided for @deleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Delete message'**
  String get deleteMessage;

  /// No description provided for @deleteForMe.
  ///
  /// In en, this message translates to:
  /// **'Delete for me'**
  String get deleteForMe;

  /// No description provided for @deleteChat.
  ///
  /// In en, this message translates to:
  /// **'Delete Chat'**
  String get deleteChat;

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get minutes;

  /// No description provided for @minute.
  ///
  /// In en, this message translates to:
  /// **'Minute'**
  String get minute;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get hours;

  /// No description provided for @hour.
  ///
  /// In en, this message translates to:
  /// **'Hour'**
  String get hour;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get days;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @weeks.
  ///
  /// In en, this message translates to:
  /// **'Weeks'**
  String get weeks;

  /// No description provided for @months.
  ///
  /// In en, this message translates to:
  /// **'Months'**
  String get months;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @messageWillOnlyBeRemovedEtc.
  ///
  /// In en, this message translates to:
  /// **'Message will only be removed from this device\nAre you sure?'**
  String get messageWillOnlyBeRemovedEtc;

  /// No description provided for @tooLarge.
  ///
  /// In en, this message translates to:
  /// **'Too Large'**
  String get tooLarge;

  /// No description provided for @selectAnother.
  ///
  /// In en, this message translates to:
  /// **'Select another'**
  String get selectAnother;

  /// No description provided for @thisVideoIsGreaterThan15MbEtc.
  ///
  /// In en, this message translates to:
  /// **'This video is greater than 15 mb\nPlease select another...'**
  String get thisVideoIsGreaterThan15MbEtc;

  /// No description provided for @video.
  ///
  /// In en, this message translates to:
  /// **'VIDEO'**
  String get video;

  /// No description provided for @consultation.
  ///
  /// In en, this message translates to:
  /// **'CONSULTATION'**
  String get consultation;

  /// No description provided for @isAskingYouToJoinEtc.
  ///
  /// In en, this message translates to:
  /// **'is asking you to join the video consultation.'**
  String get isAskingYouToJoinEtc;

  /// No description provided for @pleaseWaitYourMeetingEtc.
  ///
  /// In en, this message translates to:
  /// **'Please wait Your meeting not Start'**
  String get pleaseWaitYourMeetingEtc;

  /// No description provided for @meetingEnd.
  ///
  /// In en, this message translates to:
  /// **'Meeting end'**
  String get meetingEnd;

  /// No description provided for @joinMeeting.
  ///
  /// In en, this message translates to:
  /// **'Join Meeting'**
  String get joinMeeting;

  /// No description provided for @endMeeting.
  ///
  /// In en, this message translates to:
  /// **'Meeting Ended'**
  String get endMeeting;

  /// No description provided for @emptyCategory.
  ///
  /// In en, this message translates to:
  /// **'Empty Category'**
  String get emptyCategory;

  /// No description provided for @noPreviousAppointment.
  ///
  /// In en, this message translates to:
  /// **'No Previous Appointment'**
  String get noPreviousAppointment;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @experience.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get experience;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get education;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @awards.
  ///
  /// In en, this message translates to:
  /// **'Awards'**
  String get awards;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @youEndMeeting.
  ///
  /// In en, this message translates to:
  /// **'You end the meeting?'**
  String get youEndMeeting;

  /// No description provided for @areYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are you Sure?'**
  String get areYouSure;

  /// No description provided for @end.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get end;

  /// No description provided for @onceYouLeaveChannelYouEtc.
  ///
  /// In en, this message translates to:
  /// **'Once you leave channel you can\'t joined the meeting'**
  String get onceYouLeaveChannelYouEtc;

  /// No description provided for @exampleAllergistsEtc.
  ///
  /// In en, this message translates to:
  /// **'Example : Allergists/Immunologists, Anesthesiologists, Cardiologists, Dermatologists, Etc'**
  String get exampleAllergistsEtc;

  /// No description provided for @exampleAwardEtc.
  ///
  /// In en, this message translates to:
  /// **'Example : Dr. B. C. Roy Award, ICMR Lala Ram Chand Kandhari Award, Etc'**
  String get exampleAwardEtc;

  /// No description provided for @exampleServiceLocation.
  ///
  /// In en, this message translates to:
  /// **'Example : Hospital Name, Address With Postal Code, Location'**
  String get exampleServiceLocation;

  /// No description provided for @yourAccountNumberNotSame.
  ///
  /// In en, this message translates to:
  /// **'Your Account Number Doesn\'t Match'**
  String get yourAccountNumberNotSame;

  /// No description provided for @ifYouHaveAddedOnlyEtc.
  ///
  /// In en, this message translates to:
  /// **'If you have added only 2 slots for Monday, then patients can select from those 2 slots for Monday.'**
  String get ifYouHaveAddedOnlyEtc;

  /// No description provided for @doYouReallyWantToLogoutEtc.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to logout your account?\n\nAre you sure?'**
  String get doYouReallyWantToLogoutEtc;

  /// No description provided for @markCompleted.
  ///
  /// In en, this message translates to:
  /// **'Complete Appointment'**
  String get markCompleted;

  /// No description provided for @nothingToShow.
  ///
  /// In en, this message translates to:
  /// **'Nothing To Show'**
  String get nothingToShow;

  /// No description provided for @noUser.
  ///
  /// In en, this message translates to:
  /// **'No User'**
  String get noUser;

  /// No description provided for @askingYouToVideoConsultation.
  ///
  /// In en, this message translates to:
  /// **'Asking You to Video Consultation'**
  String get askingYouToVideoConsultation;

  /// No description provided for @doYouWantToDeleteThisAppointment.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete this appointment ?'**
  String get doYouWantToDeleteThisAppointment;

  /// No description provided for @findDoctorsBookAppointmentEtc.
  ///
  /// In en, this message translates to:
  /// **'Find doctors, book appointment\nhave digital consultation, get prescription\nand live healthy life.'**
  String get findDoctorsBookAppointmentEtc;

  /// No description provided for @weHaveSentOTPEtc.
  ///
  /// In en, this message translates to:
  /// **'We have sent OTP verification code\non phone number you entered.'**
  String get weHaveSentOTPEtc;

  /// No description provided for @enterYourOTP.
  ///
  /// In en, this message translates to:
  /// **'Enter Your OTP'**
  String get enterYourOTP;

  /// No description provided for @completeRegistration.
  ///
  /// In en, this message translates to:
  /// **'Complete Registration'**
  String get completeRegistration;

  /// No description provided for @yourPhoneNumberHasEtc.
  ///
  /// In en, this message translates to:
  /// **'Your phone number has been verified'**
  String get yourPhoneNumberHasEtc;

  /// No description provided for @yourFullname.
  ///
  /// In en, this message translates to:
  /// **'Your Fullname'**
  String get yourFullname;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date Of Birth'**
  String get dateOfBirth;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @specialists.
  ///
  /// In en, this message translates to:
  /// **'Specialists'**
  String get specialists;

  /// No description provided for @howAreYouEtc.
  ///
  /// In en, this message translates to:
  /// **'How are you feeling today?'**
  String get howAreYouEtc;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @searchForDoctorEtc.
  ///
  /// In en, this message translates to:
  /// **'Search for doctor or clinic..'**
  String get searchForDoctorEtc;

  /// No description provided for @appointmentsForToday.
  ///
  /// In en, this message translates to:
  /// **'Appointments For Today'**
  String get appointmentsForToday;

  /// No description provided for @findBySpecialities.
  ///
  /// In en, this message translates to:
  /// **'Find by Specialities'**
  String get findBySpecialities;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @dentist.
  ///
  /// In en, this message translates to:
  /// **'DENTIST'**
  String get dentist;

  /// No description provided for @pathologist.
  ///
  /// In en, this message translates to:
  /// **'PATHOLOGIST'**
  String get pathologist;

  /// No description provided for @orthopedist.
  ///
  /// In en, this message translates to:
  /// **'ORTHOPEDIST'**
  String get orthopedist;

  /// No description provided for @neurologist.
  ///
  /// In en, this message translates to:
  /// **'NEUROLOGIST'**
  String get neurologist;

  /// No description provided for @ophthalmologist.
  ///
  /// In en, this message translates to:
  /// **'OPHTHALMOLOGIST'**
  String get ophthalmologist;

  /// No description provided for @pediatrician.
  ///
  /// In en, this message translates to:
  /// **'PEDIATRICIAN'**
  String get pediatrician;

  /// No description provided for @dermatologist.
  ///
  /// In en, this message translates to:
  /// **'DERMATOLOGIST'**
  String get dermatologist;

  /// No description provided for @cardiologist.
  ///
  /// In en, this message translates to:
  /// **'CARDIOLOGIST'**
  String get cardiologist;

  /// No description provided for @bestDermatologists.
  ///
  /// In en, this message translates to:
  /// **'Best Dermatologists'**
  String get bestDermatologists;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @editDetails.
  ///
  /// In en, this message translates to:
  /// **'Edit Details'**
  String get editDetails;

  /// No description provided for @keepItOnIfYou.
  ///
  /// In en, this message translates to:
  /// **'Keep it On, if you want to receive notifications'**
  String get keepItOnIfYou;

  /// No description provided for @savedDoctors.
  ///
  /// In en, this message translates to:
  /// **'Saved Doctors'**
  String get savedDoctors;

  /// No description provided for @managePatients.
  ///
  /// In en, this message translates to:
  /// **'Manage Patients'**
  String get managePatients;

  /// No description provided for @prescriptions.
  ///
  /// In en, this message translates to:
  /// **'Prescriptions'**
  String get prescriptions;

  /// No description provided for @helpAndFAQ.
  ///
  /// In en, this message translates to:
  /// **'Help & FAQ'**
  String get helpAndFAQ;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsAndConditions;

  /// No description provided for @expShort.
  ///
  /// In en, this message translates to:
  /// **'Exp'**
  String get expShort;

  /// No description provided for @fees.
  ///
  /// In en, this message translates to:
  /// **'Fees'**
  String get fees;

  /// No description provided for @deposit.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get deposit;

  /// No description provided for @withdrawRequest.
  ///
  /// In en, this message translates to:
  /// **'Withdraw Request'**
  String get withdrawRequest;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @rechargeWallet.
  ///
  /// In en, this message translates to:
  /// **'Recharge wallet'**
  String get rechargeWallet;

  /// No description provided for @addMoneyToYourWallet.
  ///
  /// In en, this message translates to:
  /// **'Add money to your wallet'**
  String get addMoneyToYourWallet;

  /// No description provided for @pleaseRechargeEtc.
  ///
  /// In en, this message translates to:
  /// **'Please recharge\nyour wallet to continue booking'**
  String get pleaseRechargeEtc;

  /// No description provided for @selectAmount.
  ///
  /// In en, this message translates to:
  /// **'Select Amount'**
  String get selectAmount;

  /// No description provided for @enterAmountOfYourChoice.
  ///
  /// In en, this message translates to:
  /// **'Enter Amount Of Your Choice'**
  String get enterAmountOfYourChoice;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @showThisQRAtClinic.
  ///
  /// In en, this message translates to:
  /// **'Show This QR at Clinic'**
  String get showThisQRAtClinic;

  /// No description provided for @offerThisQRAtClinicShop.
  ///
  /// In en, this message translates to:
  /// **'Offer this QR at clinic shop, they will\nscan it and will have all the details'**
  String get offerThisQRAtClinicShop;

  /// No description provided for @applySearchFilters.
  ///
  /// In en, this message translates to:
  /// **'Apply Search Filters'**
  String get applySearchFilters;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get sortBy;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @searchDoctor.
  ///
  /// In en, this message translates to:
  /// **'Search Doctor'**
  String get searchDoctor;

  /// No description provided for @selectDateAndTime.
  ///
  /// In en, this message translates to:
  /// **'Select Date & Time'**
  String get selectDateAndTime;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @selectTime.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get selectTime;

  /// No description provided for @appointmentType.
  ///
  /// In en, this message translates to:
  /// **'Appointment Type'**
  String get appointmentType;

  /// No description provided for @patient.
  ///
  /// In en, this message translates to:
  /// **'Patient'**
  String get patient;

  /// No description provided for @explainYourProblemBriefly.
  ///
  /// In en, this message translates to:
  /// **'Explain Your Problem Briefly'**
  String get explainYourProblemBriefly;

  /// No description provided for @attachPhoto.
  ///
  /// In en, this message translates to:
  /// **'Attach Photo'**
  String get attachPhoto;

  /// No description provided for @makePayment.
  ///
  /// In en, this message translates to:
  /// **'Make Payment'**
  String get makePayment;

  /// No description provided for @confirmBooking.
  ///
  /// In en, this message translates to:
  /// **'Confirm Booking'**
  String get confirmBooking;

  /// No description provided for @applyCoupon.
  ///
  /// In en, this message translates to:
  /// **'Apply Coupon'**
  String get applyCoupon;

  /// No description provided for @clinic.
  ///
  /// In en, this message translates to:
  /// **'At Clinic'**
  String get clinic;

  /// No description provided for @tapOnACouponEtc.
  ///
  /// In en, this message translates to:
  /// **'Tap on a coupon to apply it'**
  String get tapOnACouponEtc;

  /// No description provided for @payNow.
  ///
  /// In en, this message translates to:
  /// **'Pay Now'**
  String get payNow;

  /// No description provided for @insufficientBalance.
  ///
  /// In en, this message translates to:
  /// **'Insufficient Balance'**
  String get insufficientBalance;

  /// No description provided for @thereIsNotEnoughEtc.
  ///
  /// In en, this message translates to:
  /// **'There is not enough funds in wallet'**
  String get thereIsNotEnoughEtc;

  /// No description provided for @transactionSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Transaction Successful'**
  String get transactionSuccessful;

  /// No description provided for @fundsHaveBeenAddedEtc.
  ///
  /// In en, this message translates to:
  /// **'Funds have been added\nto your account successfully!'**
  String get fundsHaveBeenAddedEtc;

  /// No description provided for @nowYouCanBookAppointmentsEtc.
  ///
  /// In en, this message translates to:
  /// **'Now you can book appointments\nwith single click to avoid disturbance.'**
  String get nowYouCanBookAppointmentsEtc;

  /// No description provided for @appointmentBooked.
  ///
  /// In en, this message translates to:
  /// **'Appointment Booked'**
  String get appointmentBooked;

  /// No description provided for @yourAppointmentHasEtc.
  ///
  /// In en, this message translates to:
  /// **'Your appointment\nhas been booked successfully'**
  String get yourAppointmentHasEtc;

  /// No description provided for @myAppointments.
  ///
  /// In en, this message translates to:
  /// **'My Appointments'**
  String get myAppointments;

  /// No description provided for @yourProblem.
  ///
  /// In en, this message translates to:
  /// **'Your Problem'**
  String get yourProblem;

  /// No description provided for @drHasSentYouEtc.
  ///
  /// In en, this message translates to:
  /// **'Dr. Has sent you medication schedule'**
  String get drHasSentYouEtc;

  /// No description provided for @rateYourExperience.
  ///
  /// In en, this message translates to:
  /// **'Rate Your Experience'**
  String get rateYourExperience;

  /// No description provided for @addRatings.
  ///
  /// In en, this message translates to:
  /// **'Add Ratings'**
  String get addRatings;

  /// No description provided for @shareYourExperienceEtc.
  ///
  /// In en, this message translates to:
  /// **'Share your experience in few words'**
  String get shareYourExperienceEtc;

  /// No description provided for @yourReview.
  ///
  /// In en, this message translates to:
  /// **'Your Review'**
  String get yourReview;

  /// No description provided for @downloadPrescription.
  ///
  /// In en, this message translates to:
  /// **'Download Prescription'**
  String get downloadPrescription;

  /// No description provided for @patients.
  ///
  /// In en, this message translates to:
  /// **'Patients'**
  String get patients;

  /// No description provided for @addPatient.
  ///
  /// In en, this message translates to:
  /// **'Add Patient'**
  String get addPatient;

  /// No description provided for @relation.
  ///
  /// In en, this message translates to:
  /// **'Relation'**
  String get relation;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @checkAppointmentsEtc.
  ///
  /// In en, this message translates to:
  /// **'Check Appointments tab\nfor all your upcoming appointments'**
  String get checkAppointmentsEtc;

  /// No description provided for @pleaseEnterFullName.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Full Name'**
  String get pleaseEnterFullName;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @both.
  ///
  /// In en, this message translates to:
  /// **'Both'**
  String get both;

  /// No description provided for @feesLow.
  ///
  /// In en, this message translates to:
  /// **'Fees : Low'**
  String get feesLow;

  /// No description provided for @feesHigh.
  ///
  /// In en, this message translates to:
  /// **'Fees : High'**
  String get feesHigh;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Ratings'**
  String get rating;

  /// No description provided for @pleaseAddYourPhoto.
  ///
  /// In en, this message translates to:
  /// **'Please Add your Photo'**
  String get pleaseAddYourPhoto;

  /// No description provided for @editPatient.
  ///
  /// In en, this message translates to:
  /// **'Edit Patient'**
  String get editPatient;

  /// No description provided for @max.
  ///
  /// In en, this message translates to:
  /// **'MAX'**
  String get max;

  /// No description provided for @noSlotAvailable.
  ///
  /// In en, this message translates to:
  /// **'No Slot Available'**
  String get noSlotAvailable;

  /// No description provided for @reschedule.
  ///
  /// In en, this message translates to:
  /// **'Reschedule'**
  String get reschedule;

  /// No description provided for @completionOTP.
  ///
  /// In en, this message translates to:
  /// **'Completion OTP'**
  String get completionOTP;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @withdrawRequests.
  ///
  /// In en, this message translates to:
  /// **'Withdraw Requests'**
  String get withdrawRequests;

  /// No description provided for @exp.
  ///
  /// In en, this message translates to:
  /// **'Exp'**
  String get exp;

  /// No description provided for @pleaseAtLeastRatingAdd.
  ///
  /// In en, this message translates to:
  /// **'Please at least rating add.'**
  String get pleaseAtLeastRatingAdd;

  /// No description provided for @pleaseAddComment.
  ///
  /// In en, this message translates to:
  /// **'Please Add comment'**
  String get pleaseAddComment;

  /// No description provided for @noMedicalPrescriptionAdd.
  ///
  /// In en, this message translates to:
  /// **'No Medical Prescription Add'**
  String get noMedicalPrescriptionAdd;

  /// No description provided for @bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get bookNow;

  /// No description provided for @appointmentID.
  ///
  /// In en, this message translates to:
  /// **'Appointment ID'**
  String get appointmentID;

  /// No description provided for @noServiceLocation.
  ///
  /// In en, this message translates to:
  /// **'No Service Location'**
  String get noServiceLocation;

  /// No description provided for @noPatient.
  ///
  /// In en, this message translates to:
  /// **'No Patient'**
  String get noPatient;

  /// No description provided for @pleaseExplainYourProblem.
  ///
  /// In en, this message translates to:
  /// **'Please Explain your Problem'**
  String get pleaseExplainYourProblem;

  /// No description provided for @pleaseSelectAppointmentTime.
  ///
  /// In en, this message translates to:
  /// **'Please select Appointment Time'**
  String get pleaseSelectAppointmentTime;

  /// No description provided for @pleaseSelectAppointmentType.
  ///
  /// In en, this message translates to:
  /// **'Please select Appointment Type'**
  String get pleaseSelectAppointmentType;

  /// No description provided for @notEnoughBalanceToWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Not enough balance to withdraw!'**
  String get notEnoughBalanceToWithdraw;

  /// No description provided for @correctSwiftCode.
  ///
  /// In en, this message translates to:
  /// **'Correct Swift Code'**
  String get correctSwiftCode;

  /// No description provided for @pleaseAccountNumberSame.
  ///
  /// In en, this message translates to:
  /// **'Please Account Number same'**
  String get pleaseAccountNumberSame;

  /// No description provided for @paymentFailed.
  ///
  /// In en, this message translates to:
  /// **'Payment Failed'**
  String get paymentFailed;

  /// No description provided for @paymentCancelled.
  ///
  /// In en, this message translates to:
  /// **'Payment Cancelled'**
  String get paymentCancelled;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something  went wrong'**
  String get somethingWentWrong;

  /// No description provided for @minimumAmountAddEtc.
  ///
  /// In en, this message translates to:
  /// **'Minimum amount 50 add to your wallet'**
  String get minimumAmountAddEtc;

  /// No description provided for @pleaseProvideThisOTPEtc.
  ///
  /// In en, this message translates to:
  /// **'Please, provide this OTP to doctor when asked, only after you get your services as per the order.'**
  String get pleaseProvideThisOTPEtc;

  /// No description provided for @id.
  ///
  /// In en, this message translates to:
  /// **'Id'**
  String get id;

  /// No description provided for @doctorDetail.
  ///
  /// In en, this message translates to:
  /// **'Doctor Details'**
  String get doctorDetail;

  /// No description provided for @patientDetail.
  ///
  /// In en, this message translates to:
  /// **'Patient Details'**
  String get patientDetail;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @designation.
  ///
  /// In en, this message translates to:
  /// **'Designation'**
  String get designation;

  /// No description provided for @degrees.
  ///
  /// In en, this message translates to:
  /// **'degrees'**
  String get degrees;

  /// No description provided for @doses.
  ///
  /// In en, this message translates to:
  /// **'Doses'**
  String get doses;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @thisMonthNowAllow.
  ///
  /// In en, this message translates to:
  /// **'This Month Now Allow'**
  String get thisMonthNowAllow;

  /// No description provided for @noDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'No Data Available'**
  String get noDataAvailable;

  /// No description provided for @noWithdrawRequestAvailable.
  ///
  /// In en, this message translates to:
  /// **'No Withdraw Request Available'**
  String get noWithdrawRequestAvailable;

  /// No description provided for @noAppointmentsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No Appointments Available'**
  String get noAppointmentsAvailable;

  /// No description provided for @noServiceAvailable.
  ///
  /// In en, this message translates to:
  /// **'No Service Available'**
  String get noServiceAvailable;

  /// No description provided for @noExpertiseAvailable.
  ///
  /// In en, this message translates to:
  /// **'No Expertise Available'**
  String get noExpertiseAvailable;

  /// No description provided for @bod.
  ///
  /// In en, this message translates to:
  /// **'DOB'**
  String get bod;

  /// No description provided for @doseTime.
  ///
  /// In en, this message translates to:
  /// **'Dose Time'**
  String get doseTime;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @doYouWantToCancelThisAppointment.
  ///
  /// In en, this message translates to:
  /// **'Do you want to cancel this Appointment?'**
  String get doYouWantToCancelThisAppointment;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;
}

class _PSDelegate extends LocalizationsDelegate<PS> {
  const _PSDelegate();

  @override
  Future<PS> load(Locale locale) {
    return SynchronousFuture<PS>(lookupPS(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'da', 'de', 'el', 'en', 'es', 'fr', 'hi', 'id', 'it', 'ja', 'ko', 'nb', 'nl', 'pl', 'pt', 'ru', 'th', 'tr', 'vi', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_PSDelegate old) => false;
}

PS lookupPS(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return PSAr();
    case 'da': return PSDa();
    case 'de': return PSDe();
    case 'el': return PSEl();
    case 'en': return PSEn();
    case 'es': return PSEs();
    case 'fr': return PSFr();
    case 'hi': return PSHi();
    case 'id': return PSId();
    case 'it': return PSIt();
    case 'ja': return PSJa();
    case 'ko': return PSKo();
    case 'nb': return PSNb();
    case 'nl': return PSNl();
    case 'pl': return PSPl();
    case 'pt': return PSPt();
    case 'ru': return PSRu();
    case 'th': return PSTh();
    case 'tr': return PSTr();
    case 'vi': return PSVi();
    case 'zh': return PSZh();
  }

  throw FlutterError(
    'PS.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
