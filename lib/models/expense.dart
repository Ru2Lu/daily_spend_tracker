import 'package:isar/isar.dart';

part 'expense.g.dart';

@collection
class Expense {
  Expense({
    this.id = Isar.autoIncrement,
    required this.date,
    required this.title,
    required this.amount,
    required this.createdDate,
  });

  /// ID
  final Id id;

  /// 支出の日付
  final DateTime? date;

  /// 支出のタイトル
  final String? title;

  /// 支出の金額
  final int? amount;

  /// データの作成日時
  final DateTime createdDate;
}
