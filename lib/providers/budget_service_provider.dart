import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/budget.dart';
import '../services/budget_service.dart';
import 'isar_provider.dart';

part 'budget_service_provider.g.dart';

@Riverpod(keepAlive: true)
Future<BudgetService> budgetService(
  BudgetServiceRef ref,
) async {
  final isar = await ref.watch(isarProvider.future);
  return BudgetService(isar);
}

@riverpod
Stream<Budget?> budget(
  BudgetRef ref,
  int year,
  int month,
) async* {
  final service = await ref.watch(budgetServiceProvider.future);
  yield* service.watchBudgetByYearMonth(
    year: year,
    month: month,
  );
}
