import 'package:intl/intl.dart';

class FormartDate {
  static String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }
}
