import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String toISODate() {
    DateTime dateTime = DateTime.parse(this);
    DateFormat dateFormat = DateFormat("yyyy/MM/dd");
    String formattedDate = dateFormat.format(dateTime);
    return formattedDate;
  }

  String toTimeAgo() {
    DateTime dateTime = DateTime.parse(this);
    String timeAgo =
        timeago.format(dateTime, locale: 'en_short', allowFromNow: true);

    return timeAgo;
  }
}
