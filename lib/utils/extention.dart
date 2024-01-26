import 'package:doclink/doctor/common/common_fun.dart';
import 'package:doclink/utils/update_res.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/patient/model/custom/categories.dart';
import 'package:intl/intl.dart';

extension A on int {
  String get number {
    return NumberFormat.compactCurrency(
            decimalDigits: 0, locale: 'en_US', name: '')
        .format(this)
        .toString();
  }
  String get numFormat {
    return NumberFormat(numberFormat).format(this);
  }
}

extension B on num {
  int get genderParse {
    return int.parse('$this');
  }
}

extension C on String {
  String get removeUnUsed {
    return replaceAll('+', '').replaceAll(' ', '');
  }

  String dateMilliFormat(String formatKey) {
    return DateFormat(formatKey, 'en')
        .format(DateTime.fromMillisecondsSinceEpoch(int.parse(this)).toLocal());
  }

  String dateParse(String formatKey) {
    return DateFormat(formatKey, 'en').format(DateTime.parse(this).toLocal());
  }

  String get appointmentDate {
    return dateParse(eeeMmmDdYyyy);
  }

  String get appointmentTime {
    return CommonFun.convert24HoursInto12Hours(this);
  }
}
extension D on DateTime {
  String formatDateTime(String formatKey) {
    return DateFormat(formatKey, 'en').format(this);
  }
}
extension H on double {
  String get numFormat {
    return NumberFormat(numberFormat).format(this);
  }
}

extension O on PrescriptionMedical {
  static final RegExp removeEmoji = RegExp(
      r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');

  List<List<String>> getMedicines() {
    List<List<String>> medicalData = [];
    addMedicine?.forEach((element) {
      List<String> temp = [];
      temp.add(
          '${element.title} ${element.notes == null || element.notes!.isEmpty ? '' : removeEmoji.hasMatch(element.notes ?? '') ? '' : '\n${PS.current.notes} :-${element.notes ?? ''}'} ');
      temp.add(
          element.mealTime == 0 ? PS.current.afterMeal : PS.current.beforeMeal);
      temp.add('${element.dosage}');
      temp.add('${element.quantity}');
      medicalData.add(temp);
    });
    return medicalData;
  }
}
