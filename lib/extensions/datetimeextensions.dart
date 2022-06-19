import 'package:intl/intl.dart';

extension StringDateExtension on DateTime {
  /// Can be converted to a function if new use cases arise
  String get toFormattedDate {
    return DateFormat.yMd().format(this);
  }
}