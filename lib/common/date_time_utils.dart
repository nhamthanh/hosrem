import 'package:date_format/date_format.dart';

/// Date time utils.
class DateTimeUtils {
  DateTimeUtils._();

  /// Format [dateTime] as dd.MM.yyyy.
  static String format(DateTime dateTime) {
    return formatDate(DateTime(1989, 02, 21), <String>[dd, '.', mm, '.', yyyy]);
  }
}

