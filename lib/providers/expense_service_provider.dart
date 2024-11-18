import 'package:daily_spend_tracker/models/expense.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/expense_service.dart';
import 'isar_provider.dart';

part 'expense_service_provider.g.dart';

@Riverpod(keepAlive: true)
Future<ExpenseService> expenseService(
  ExpenseServiceRef ref,
) async {
  final isar = await ref.watch(isarProvider.future);
  return ExpenseService(isar);
}

@riverpod
Stream<List<Expense>?> expenses(
  ExpensesRef ref,
) async* {
  final service = await ref.watch(expenseServiceProvider.future);
  yield* service.watchExpenses();
}
