import 'package:intl/intl.dart';

class DateUtility {
  static String extractDate(String dateString) {
    // Parse the input date string
    DateTime date = DateTime.parse(dateString);

    // Format the date
    DateFormat formatter = DateFormat('EEEE, d MMMM, yyyy');
    String formattedDate = formatter.format(date);

    // Monday, 1 January, 2023
    return formattedDate;
  }

  static String formatedDateTime(String dateString) {
    DateTime dateTime = DateTime.parse(dateString.replaceAll(" ", "T"));
    String formattedDate =
        DateFormat('dd MMMM, yyyy - hh:mm a').format(dateTime);
    return formattedDate;
  }

// Get Remaining time for session started as now date & compare with expiry date
//     "expires_at": "2024-05-27T04:56:13.000000Z",

  static String getRemainingTime(DateTime expiryDate) {
    DateTime now = DateTime.now();
    Duration duration = expiryDate.difference(now);
    String formattedDuration = duration.toString().split('.').first;
    print("formattedDuration--> $formattedDuration");
    return formattedDuration;
  }

  static String formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }

  /// Get [Formatted] Date
  static String getFormattedDate(dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDate = DateFormat('dd MMMM, yyyy').format(dateTime);

    return formattedDate;
  }
}
