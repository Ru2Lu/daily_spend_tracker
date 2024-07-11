import 'package:daily_spend_tracker/models/expense.dart';
import 'package:daily_spend_tracker/models/monthly_budget.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'isar_provider.g.dart';

@Riverpod(keepAlive: true)
Future<Isar> isar(IsarRef ref) async {
  final dir = await getApplicationDocumentsDirectory();
  return Isar.open(
    [
      MonthlyBudgetSchema,
      ExpenseSchema,
    ],
    directory: dir.path,
  );
}
