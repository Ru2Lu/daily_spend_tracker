import 'package:isar/isar.dart';

part 'monthly_budget.g.dart';

@collection
class MonthlyBudget {
  MonthlyBudget({
    this.id = Isar.autoIncrement,
    required this.amount,
    required this.date,
  });

  final Id id;

  int? amount;

  DateTime? date;
}
