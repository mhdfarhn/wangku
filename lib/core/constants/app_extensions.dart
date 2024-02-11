import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toDateString() => DateFormat('dd/MM/yyyy').format(this);
  String toTimeString() => DateFormat.jm().format(this);
  String toDayString() {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    final tomorrow = now.add(const Duration(days: 1));
    if (now.day == day && now.month == month && now.year == year) {
      return 'Today';
    } else if (yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year) {
      return 'Yesterday';
    } else if (tomorrow.day == day &&
        tomorrow.month == month &&
        tomorrow.year == year) {
      return 'Tomorrow';
    } else {
      return DateFormat('EEEE, d MMMM yyyy').format(this);
    }
  }
}

extension StringExtension on String {
  String capitalize() =>
      '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
}
