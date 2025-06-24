import 'package:intl/intl.dart';

extension IntExtension on int? {
  String toSplitCommaString() {
    final formatter = NumberFormat('#,###');
    return formatter.format(this);
  }
}

extension DateTimeExtension on DateTime {
  String toYMD() {
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(this);
  }
}
