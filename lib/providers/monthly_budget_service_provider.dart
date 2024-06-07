import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/monthly_budget.dart';
import '../services/monthly_budget_service.dart';
import 'isar_provider.dart';

part 'monthly_budget_service_provider.g.dart';

@Riverpod(keepAlive: true)
Future<MonthlyBudgetService> monthlyBudgetService(
  MonthlyBudgetServiceRef ref,
) async {
  final isar = await ref.watch(isarProvider.future);
  return MonthlyBudgetService(isar);
}

@riverpod
Stream<MonthlyBudget?> monthlyBudget(
  MonthlyBudgetRef ref,
) async* {
  final service = await ref.watch(monthlyBudgetServiceProvider.future);
  yield* service.watchMonthlyBudget();
}
