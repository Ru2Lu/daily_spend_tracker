import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NumberInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat('#,###');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // 数字とカンマ以外の文字が含まれていないかチェック
    final RegExp regExp = RegExp(r'[^0-9,]');
    if (regExp.hasMatch(newValue.text)) {
      return oldValue;
    }

    // カンマを除去して数値に変換
    final int? value = int.tryParse(newValue.text.replaceAll(',', ''));
    if (value == null) {
      return oldValue;
    }

    // フォーマット後の文字列
    final String newText = _formatter.format(value);

    // カーソル位置の調整
    final int selectionIndex =
        newText.length - (oldValue.text.length - oldValue.selection.end);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(
        offset: selectionIndex < 0 ? 0 : selectionIndex,
      ),
    );
  }
}
