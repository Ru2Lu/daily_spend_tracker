import 'package:isar/isar.dart';
import '../models/monthly_budget.dart';

class MonthlyBudgetService {
  const MonthlyBudgetService(
    this.isar,
  );

  final Isar isar;

  // 今月の予算を取得
  Future<MonthlyBudget?> getMonthlyBudget() async {
    return await isar.monthlyBudgets.where().findFirst();
  }

  // 今月の予算を監視
  Stream<MonthlyBudget?> watchMonthlyBudget() async* {
    final query = isar.monthlyBudgets.where();

    await for (final results in query.watch(fireImmediately: true)) {
      if (results.isNotEmpty) {
        yield results.first;
      } else {
        yield null;
      }
    }
  }

  // 今月の予算を保存
  Future<void> saveMonthlyBudget(int? budget) async {
    await isar.writeTxn(() async {
      // 既存の予算を削除
      await isar.monthlyBudgets.clear();
      // 新しい予算を保存
      final monthlyBudget = MonthlyBudget(budget: budget);
      await isar.monthlyBudgets.put(monthlyBudget);
    });
  }
}
