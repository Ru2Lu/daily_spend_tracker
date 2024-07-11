import 'package:isar/isar.dart';

part 'expense.g.dart';

@collection
class Expense {
  Expense({
    this.id = Isar.autoIncrement,
    required this.date,
    required this.title,
    required this.amount,
  });

  final Id id;

  final DateTime? date;

  final String? title;

  final int? amount;
}
