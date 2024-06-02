import 'package:intl/intl.dart';

/// 数字の文字列を3桁ごとにカンマ区切りに整形
String formatCommaSeparateNumber(String numString) {
  return NumberFormat.decimalPattern().format(
    int.parse(numString),
  );
}
