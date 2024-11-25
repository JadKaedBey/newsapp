import 'package:intl/intl.dart';

String formatDate(String dateString) {
  final date = DateTime.parse(dateString);
  return DateFormat('yyyy-MM-dd HH:mm').format(date);
}
