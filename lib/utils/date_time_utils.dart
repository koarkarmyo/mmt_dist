import 'package:intl/intl.dart';

class DateTimeUtils {
  static DateFormat ddMmYYYFormat = DateFormat('dd-MM-yyyy');
  static DateFormat ddMmYYYHMSsFormat = DateFormat('dd-MM-yyyy HH:mm:ss');
  static DateFormat ddMmYYYHMSsAFormat = DateFormat('dd-MM-yyyy HH:mm a');
  static DateFormat ddMmYYYFormatSlug = DateFormat('dd/MM/yyyy');
  static DateFormat hhMMFull = DateFormat('hh:mm a');
  static DateFormat yMmDdHMS = DateFormat('yyyy-MM-dd HH:mm:ss');
  static DateFormat yMmDdHMSsA = DateFormat('yyyy-MM-dd HH:mm:ss a');
  static DateFormat yMmDdHMA = DateFormat('yyyy-MM-dd HH:mm a');
  static DateFormat yMmDd = DateFormat('yyyy-MM-dd');
  static String currentDateTimeUTC = yMmDdHMS.format(DateTime.now().toUtc());

  static String startDate(DateTime dateTime) {
    String tempDate = yMmDd.format(dateTime);
    return '$tempDate 00:00:00';
  }

  static String endDate(DateTime dateTime) {
    String tempDate = yMmDd.format(dateTime);
    return '$tempDate 23:59:59';
  }

  static String changeToUtc(String dateTime, {DateFormat? dateFormat}) {
    dateFormat ??= yMmDdHMS;
    return dateFormat.format(DateTime.parse(dateTime).toUtc());
  }

  static String changeToLocal(String dateTime, {DateFormat? dateFormat}) {
    dateFormat ??= yMmDdHMS;
    return dateFormat.format(DateTime.parse(dateTime).toLocal());
  }

  static DateTime getDatePreviousOneWeek({DateTime? date}) {
    date ??= DateTime.now();
    DateTime endDate = getDate(
        date.add(Duration(days: -7, hours: 0, minutes: 0, seconds: 0)));
    return endDate;
  }

  static DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

// static DateTime DateTimeUtils.yMmDdHMS.format(DateTime.parse(saleOrderHeader.dateOrder!).toUtc());
}
