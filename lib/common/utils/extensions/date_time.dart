import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toISODate() {
    DateFormat dateFormat = DateFormat("yyyy/MM/dd");
    String formattedDate = dateFormat.format(this);
    return formattedDate;
  }
}