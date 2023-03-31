DateTime startDayFormatter(String date) {
  final result = DateTime.parse(date);
  final start = DateTime(result.year, result.month, result.day);
  return start;
}

DateTime endDayFormatter(String date) {
  final result = DateTime.parse(date);
  final end = DateTime(result.year, result.month, result.day, 23, 59, 59, 999);
  return end;
}
