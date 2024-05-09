import 'package:intl/intl.dart';

extension DateTimeHourMin on DateTime {
  String formatDate() {
    return DateFormat('d MMM y hh:mm a').format(this);
  }

  String formatDateTable() {
    return DateFormat('dd-MM-yyyy').format(this);
  }

  String formatDateDayOnly() {
    return DateFormat('MMMM d, y').format(this);
  }

  String getDayOfWeek() {
    return DateFormat('EEEE').format(this);
  }

  String getMonth() {
    return DateFormat('MMMM').format(this);
  }

  String timeOnly() {
    return DateFormat('hh : mm a').format(this);
  }

  String formatDatePDF() {
    return DateFormat.yMMMd().format(this);
  }

  static String formatTimeDifference(DateTime earlierTime, DateTime laterTime) {
    Duration difference = laterTime.difference(earlierTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  static DateTime getUnformattedValueMonthDateYear(String value) {
    DateFormat format = DateFormat('d MMM y hh:mm a');
    return format.parse(value);
  }

  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
    // Duration difference = to.difference(from);
    // int days = difference.inDays;
    // return days;
  }

  static String durationBetween(DateTime from, DateTime to) {
    Duration difference = to.difference(from);
    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;

    String result = '';
    if (days > 0) {
      result += '$days days ';
    }
    if (hours > 0) {
      result += '$hours hours ';
    }
    if (minutes > 0) {
      result += '$minutes minutes';
    }

    return result.trim();
  }

  static DateTime getUnformattedValueDaysHourMin(String value) {
    DateFormat format = DateFormat('d MMM y hh:mm a');
    return format.parse(value);
  }
}
