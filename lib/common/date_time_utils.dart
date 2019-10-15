import 'package:date_format/date_format.dart';

/// Date time utils.
class DateTimeUtils {
  DateTimeUtils._();

  /// Format [dateTime] as dd.MM.yyyy.
  static String format(DateTime dateTime) {
    return formatDate(dateTime, <String>[dd, '.', mm, '.', yyyy]);
  }
}

