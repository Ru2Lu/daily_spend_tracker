import 'package:isar/isar.dart';
import '../models/monthly_budget.dart';

class MonthlyBudgetService {
  const MonthlyBudgetService(
    this.isar,
  );

  final Isar isar;

  // 指定した年月の予算を取得
  Future<MonthlyBudget?> getMonthlyBudgetByYearMonth({
    required int year,
    required int month,
  }) async {
    final currentMonthBudget = await isar.monthlyBudgets
        .filter()
        .dateGreaterThan(
          DateTime(year, month, 1).subtract(
            const Duration(days: 1),
          ),
        )
        .and()
        .dateLessThan(
          DateTime(
            year,
            month + 1,
            1,
          ),
        )
        .findFirst();

    return currentMonthBudget;
  }

  // 指定した年月の予算を返す
  Stream<MonthlyBudget?> watchMonthlyBudgetByYearMonth({
    required int year,
    required int month,
  }) async* {
    final query = isar.monthlyBudgets
        .filter()
        .dateGreaterThan(
          DateTime(year, month, 1).subtract(
            const Duration(days: 1),
          ),
        )
        .and()
        .dateLessThan(
          DateTime(
            year,
            month + 1,
            1,
          ),
        );

    await for (final results in query.watch(fireImmediately: true)) {
      if (results.isNotEmpty) {
        yield results.first;
      }
    }
  }

  // 今月の予算を保存
  Future<void> saveMonthlyBudget(
    int? amount,
  ) async {
    await isar.writeTxn(() async {
      final now = DateTime.now();
      final oldMonthBudget = await getMonthlyBudgetByYearMonth(
        year: now.year,
        month: now.month,
      );
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

  // 全ての月の予算を削除
  Future<void> deleteAllMonthlyBudgets() async {
    await isar.writeTxn(() async {
      await isar.monthlyBudgets.where().deleteAll();
    });
  }
}
