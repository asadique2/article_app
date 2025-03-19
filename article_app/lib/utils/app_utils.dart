import 'package:intl/intl.dart';

class AppUtils {
  static String? formatDate(String date) {
    try {
      DateTime dateTime = DateTime.parse(date);
      String formattedDate = DateFormat("dd MMM yyyy").format(dateTime);
      return formattedDate;
    } catch (e) {
      return null;
    }
  }
}
