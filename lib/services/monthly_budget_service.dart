import 'package:isar/isar.dart';
import '../models/monthly_budget.dart';

class MonthlyBudgetService {
  const MonthlyBudgetService(
    this.isar,
  );

  final Isar isar;

  // 今月の予算を取得
  Future<MonthlyBudget?> getCurrentMonthBudget() async {
    final now = DateTime.now();
    final currentMonthBudget = await isar.monthlyBudgets
        .filter()
        .dateGreaterThan(
          DateTime(now.year, now.month, 1).subtract(
            const Duration(days: 1),
          ),
        )
        .and()
        .dateLessThan(
          DateTime(
            now.year,
            now.month + 1,
            1,
          ),
        )
        .findFirst();

    return currentMonthBudget;
  }

  // 今月の予算を監視
  Stream<MonthlyBudget?> watchMonthlyBudget() async* {
    final now = DateTime.now();
    final query = isar.monthlyBudgets
        .filter()
        .dateGreaterThan(
          DateTime(now.year, now.month, 1).subtract(
            const Duration(days: 1),
          ),
        )
        .and()
        .dateLessThan(
          DateTime(
            now.year,
            now.month + 1,
            1,
          ),
        );

    await for (final results in query.watch(fireImmediately: true)) {
      if (results.isNotEmpty) {
        yield results.first;
      } else {
        yield null;
      }
    }
  }

  // 今月の予算を保存
  Future<void> saveMonthlyBudget(
    int? amount,
  ) async {
    await isar.writeTxn(() async {
      final oldMonthBudget = await getCurrentMonthBudget();
      if (oldMonthBudget != null) {
        // 既存の予算を更新
        oldMonthBudget.amount = amount;
        oldMonthBudget.date = DateTime.now();
        await isar.monthlyBudgets.put(oldMonthBudget);
      } else {
        // 新しい予算を保存
        final newMonthlyBudget = MonthlyBudget(
          amount: amount,
          date: DateTime.now(),
        );
        await isar.monthlyBudgets.put(newMonthlyBudget);
      }
    });
  }
}
