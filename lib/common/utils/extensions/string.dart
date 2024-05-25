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
    String timeAgo = timeago.format(dateTime, allowFromNow: true);

    return timeAgo;
  }

  String toCommentDate() {
    // Parse the date string to a DateTime object
    DateTime dateTime = DateTime.parse(this);

    // Get the current year
    int currentYear = DateTime.now().year;

    // Format the date to "May 16" or "2023 May 16"
    if (dateTime.year == currentYear) {
      return DateFormat('MMMM d').format(dateTime);
    } else {
      return DateFormat('yyyy MMMM d').format(dateTime);
    }
  }
}

extension OptionalStringExtension on String? {
  bool get isNotNullOrEmpty {
    return this != null && this!.isEmpty;
  }
}
