import 'package:intl/intl.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/utils/update_res.dart';

class CommonFun {
  static calculateAge(String? birthDate) {
    DateTime currentDate = DateTime.now();
    DateTime parseDate = DateFormat(yyyyMmDd, 'en').parse(birthDate ?? '');
    int age = currentDate.year - parseDate.year;
    int month1 = currentDate.month;
    int month2 = parseDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = parseDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  static String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? PS.current.year : PS.current.years}";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? PS.current.month : PS.current.months}";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? PS.current.week : PS.current.weeks}";
    }
    if (diff.inDays > 0) {
      if (diff.inDays == 1) {
        return PS.current.yesterday;
      }
      return "${diff.inDays}${PS.current.days}";
    }
    if (diff.inHours > 0) {
      return "${diff.inHours} ${diff.inHours == 1 ? PS.current.hour : PS.current.hours}";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? PS.current.minute : PS.current.minutes}";
    }
    return PS.current.justNow;
  }
}
