import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  /// Formats the DateTime object into a string using the provided pattern.
  /// Example patterns:
  /// - "yyyy-MM-dd" => 2024-12-13
  /// - "MMM dd, yyyy" => Dec 13, 2024
  /// - "hh:mm a" => 12:30 PM
  String format(String pattern) {
    return DateFormat(pattern).format(this);
  }

  /// Example method to get a readable date format.
  String toReadableDate() {
    return DateFormat('MMM dd, yyyy').format(this);
  }

  /// Example method to get a readable time format.
  String toReadableTime() {
    return DateFormat('hh:mm a').format(this);
  }
}
