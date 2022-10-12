import 'package:intl/intl.dart';

class DataUtil {
  static String getDataFormat(DateTime date) {
    final month = DateFormat.LLLL().format(date);
    final dayNum = date.day;
    final year = date.year;

    return '$dayNum $month $year';
  }

  static String getDayNum(DateTime date) {
    final dayNum = DateFormat.d().format(date);

    return dayNum;
  }

  static String getDayText(DateTime date) {
    final dayText = DateFormat.E().format(date);
    return dayText;
  }
}
