import 'package:isar/isar.dart';

part 'monthly_budget.g.dart';

@collection
class MonthlyBudget {
  MonthlyBudget({
    this.id = Isar.autoIncrement,
    required this.budget,
  });

  final Id id;

  final int? budget;
}
