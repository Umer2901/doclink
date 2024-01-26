import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:doclink/doctor/common/custom_ui.dart';
import 'package:doclink/doctor/generated/l10n.dart';
import 'package:doclink/doctor/model/appointment/appointment_request.dart';
import 'package:doclink/doctor/model/medical_prescription.dart';
import 'package:doclink/doctor/screen/accept_reject_screen/accept_reject_screen.dart';
import 'package:doclink/doctor/screen/medical_prescription_screen/widget/ad_medical_sheet.dart';
import 'package:doclink/doctor/service/api_service.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:get/get.dart';
import 'package:signature/signature.dart';

class MedicalPrescriptionScreenController extends GetxController {
  TextEditingController medicineController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController doseController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController extraNoteController = TextEditingController();
  List<AddMedicine> medicines = [];
  MedicalPrescription? prescription;
  AddMedicine? editMedicine;

  bool isTitleError = false;
  bool isQuantityError = false;
  bool isDosageError = false;
  bool isMealTimeError = false;
  bool isExtraNotesError = false;
  int initialValue = 0;

  List<String> mealList = [
    S.current.afterMeal,
    S.current.beforeMeal,
  ];
  int? selectedMeal;
  AppointmentData? appointmentData;
  bool? isvideoCall;
  MedicalPrescriptionScreenController({this.isvideoCall});
  @override
  void onInit() {
    appointmentData = Get.arguments;
    addPrescription();
    super.onInit();
  }

  void onMealTap(int index) {
    if (selectedMeal == index) {
      selectedMeal = null;
    } else {
      selectedMeal = index;
    }
    update();
  }

  void onSubmitClick(int type) {
    if (isValid()) {
      if (type == 1) {
        var index = medicines.indexOf(editMedicine!);
        medicines[index].title = medicineController.text.trim();
        medicines[index].dosage = doseController.text.trim();
        medicines[index].notes = noteController.text.trim();
        medicines[index].mealTime = selectedMeal;
        medicines[index].quantity = int.parse(quantityController.text);
      } else {
        AddMedicine medicine = AddMedicine(
          title: medicineController.text,
          dosage: doseController.text,
          notes: noteController.text,
          mealTime: selectedMeal,
          quantity: int.parse(quantityController.text),
        );
        medicines.add(medicine);
      }
      Get.back();
    }
  }

  bool isValid() {
    int i = 0;
    falseFiled();
    if (medicineController.text.isEmpty) {
      isTitleError = true;
      return false;
    }
    if (quantityController.text.isEmpty) {
      isQuantityError = true;
      return false;
    }
    if (doseController.text.isEmpty) {
      isDosageError = true;
      return false;
    }
    if (selectedMeal == null) {
      CustomUi.snackBar(
          message: S.current.pleaseSelectMeal,
          iconData: Icons.medical_information_rounded);
      return false;
    }
    // if (noteController.text.isEmpty) {
    //   isExtraNotesError = true;
    //   return false;
    // }
    return i == 0 ? true : false;
  }

  @override
  void onClose() {
    medicineController.clear();
    quantityController.clear();
    doseController.clear();
    noteController.clear();
    super.onClose();
  }

  void falseFiled() {
    isTitleError = false;
    isQuantityError = false;
    isDosageError = false;
    isMealTimeError = false;
    isExtraNotesError = false;
    update();
  }

  void addMedicineTap(MedicalPrescriptionScreenController controller) {
    Get.bottomSheet(AdMedicalSheet(controller: controller, type: 0),
            isScrollControlled: true)
        .then((value) {
      clearText();
    });
  }

 Future<File> _convertUint8ListToFile(Uint8List uint8List, String fileName) async {
    // Create a temporary directory
    Directory tempDir = await Directory.systemTemp.createTemp();

    // Create a temporary file with the given file name
    File tempFile = File('${tempDir.path}/$fileName');

    // Write the bytes from Uint8List to the file
    await tempFile.writeAsBytes(uint8List);

    return tempFile;
  }
  File? file;
  void onContinueTap(SignatureController controller,int type, bool? isVideoCall)async{
    if (medicines.isEmpty) {
      CustomUi.snackBar(
          message: S.current.pleaseAtLeastOneMedicineAdd,
          iconData: Icons.medical_information_rounded);
      return;
    }
    // if (extraNoteController.text.isEmpty) {
    //   CustomUi.snackBar(
    //       message: S.current.pleaseEnterExtraNotes,
    //       iconData: Icons.note_alt_rounded);
    //   return;
    // }
    if (type == 0) {
      var image = await controller.toPngBytes();
      if(image != null){
         file = await _convertUint8ListToFile(image, DateTime.now().millisecondsSinceEpoch.toString());
      }
      prescription =
          MedicalPrescription(medicines, extraNoteController.text.trim());
      DoctorApiService.instance
          .addPrescription(
              signature: file,
              appointmentId: appointmentData?.id,
              medicine: prescription?.toJson(),
              userId: appointmentData?.userId)
          .then((value)async{
            print(value);
        if(isvideoCall != null && isvideoCall == true){
          //Get.delete<LiveVideoCallScreenController>();
          Get.to(()=>AcceptRejectScreen(isVideoCall: isVideoCall,), arguments: appointmentData);
        }else{
          Get.back();
        }
        if (value.status == true) {
          CustomUi.snackBar(
              iconData: Icons.medical_services,
              message: value.message,
              positive: true);
        } else {
          CustomUi.snackBar(
              iconData: Icons.medical_services, message: value.message);
        }
      });
    } else {
      prescription =
          MedicalPrescription(medicines, extraNoteController.text.trim());
      DoctorApiService.instance
          .editPrescription(
              prescriptionId: appointmentData?.prescription?.id,
              medicine: prescription?.toJson())
          .then((value) {
        Get.back();
        if (value.status == true) {
          CustomUi.snackBar(
              iconData: Icons.medical_services,
              message: value.message,
              positive: true);
        } else {
          CustomUi.snackBar(
              iconData: Icons.medical_services, message: value.message);
        }
      });
    }
  }

  void addPrescription() {
    if (appointmentData?.prescription != null) {
      prescription = MedicalPrescription.fromJson(
          jsonDecode(appointmentData?.prescription?.medicine ?? ''));
      medicines = prescription?.addMedicine ?? [];
      extraNoteController = TextEditingController(text: prescription?.notes);
    }
  }

  void onMoreBtnClick(AddMedicine addMedicine) {
    medicines.remove(addMedicine);
    update();
  }

  void onDeleteTap(AddMedicine addMedicine) {
    medicines.remove(addMedicine);
    update();
  }

  void onMedicineEdit(
      AddMedicine addMedicine, MedicalPrescriptionScreenController controller) {
    medicineController = TextEditingController(text: addMedicine.title);
    quantityController =
        TextEditingController(text: addMedicine.quantity.toString());
    doseController = TextEditingController(text: addMedicine.dosage);
    noteController = TextEditingController(text: addMedicine.notes);
    selectedMeal = addMedicine.mealTime;
    editMedicine = addMedicine;
    Get.bottomSheet(AdMedicalSheet(controller: controller, type: 1),
            isScrollControlled: true)
        .then((value) {
      clearText();
    });
  }

  void clearText() {
    medicineController.clear();
    quantityController.clear();
    doseController.clear();
    noteController.clear();
    selectedMeal = null;
    update();
    falseFiled();
  }
}
