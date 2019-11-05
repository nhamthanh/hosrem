import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

/// Date time utils.
class DateTimeUtils {
  DateTimeUtils._();

  /// Format [dateTime] as dd.MM.yyyy.
  static String format(DateTime dateTime) {
    return formatDate(dateTime, <String>[dd, '.', mm, '.', yyyy]);
  }

  /// Format [dateTime] as dd / MM / yyyy.
  static String formatAsStandard(DateTime dateTime) {
    return formatDate(dateTime, <String>[dd, '/', mm, '/', yyyy]);
  }

  /// Format string [dateTime] to DateTime.
  static DateTime parseDate(String dateTime) {
    final DateFormat format = DateFormat('dd/mm/yyyy');
    return format.parse(dateTime);
  }
}

