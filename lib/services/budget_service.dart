import 'package:isar/isar.dart';
import '../models/budget.dart';

class BudgetService {
  const BudgetService(
    this.isar,
  );

  final Isar isar;

  // 指定した年月の予算を取得
  Future<Budget?> getBudgetByYearMonth({
    required int year,
    required int month,
  }) async {
    final currentMonthBudget = await isar.budgets
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
  Stream<Budget?> watchBudgetByYearMonth({
    required int year,
    required int month,
  }) async* {
    final query = isar.budgets
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
  Future<void> saveBudget(
    int? amount,
  ) async {
    await isar.writeTxn(() async {
      final now = DateTime.now();
      final oldMonthBudget = await getBudgetByYearMonth(
        year: now.year,
        month: now.month,
      );
      if (oldMonthBudget != null) {
        // 既存の予算を更新
        oldMonthBudget.amount = amount;
        oldMonthBudget.date = DateTime.now();
        await isar.budgets.put(oldMonthBudget);
      } else {
        // 新しい予算を保存
        final newBudget = Budget(
          amount: amount,
          date: DateTime.now(),
        );
        await isar.budgets.put(newBudget);
      }
    });
  }

  // 過去3ヶ月以前の月の予算を削除
  Future<void> deleteOldBudgets() async {
    await isar.writeTxn(() async {
      final now = DateTime.now();
      final threeMonthsAgo = DateTime(
        now.year,
        now.month - 3,
        1,
      );

      // 3ヶ月以上前の予算データを削除
      await isar.budgets.filter().dateLessThan(threeMonthsAgo).deleteAll();
    });
  }

  // 全ての月の予算を削除
  Future<void> deleteAllBudgets() async {
    await isar.writeTxn(() async {
      await isar.budgets.where().deleteAll();
    });
  }
}
