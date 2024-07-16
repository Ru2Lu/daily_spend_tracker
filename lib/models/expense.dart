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
    required this.updatedDate,
  });

  /// ID
  final Id id;

  /// 支出の日付
  DateTime? date;

  /// 支出のタイトル
  String? title;

  /// 支出の金額
  int? amount;

  /// データの作成日時
  final DateTime createdDate;

  /// データの更新日時
  final DateTime updatedDate;
}
