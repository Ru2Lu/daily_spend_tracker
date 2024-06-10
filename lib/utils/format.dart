import 'package:intl/intl.dart';

/// 数字の文字列を3桁ごとにカンマ区切りに整形
String formatCommaSeparateNumber(String numString) {
  if (numString == "") {
    return "";
  }
  return NumberFormat.decimalPattern().format(
    int.parse(numString),
  );
}
