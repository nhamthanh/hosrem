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

  /// Format [dateTime] as hh:mm.
  static String parseTime(DateTime dateTime) {
    if (dateTime == null) {
      return '';
    }
    return DateFormat('HH:mm').format(dateTime);
  }

  /// Format [dateTimeStart, dateTimeEnd] as hh:mm - hh:mm  .
  static String getTimeRange(DateTime dateTimeStart, DateTime dateTimeEnd) {
    if (dateTimeStart == null) {
      return '';
    }
    final DateFormat format = DateFormat('HH:mma');
    final String startTime = format.format(dateTimeStart).toLowerCase();
    if (dateTimeEnd == null) {
      return startTime;
    }
    final String endTime = format.format(dateTimeEnd).toLowerCase();
    return '$startTime - $endTime';
  }
}

