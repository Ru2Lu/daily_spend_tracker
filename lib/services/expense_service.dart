import 'package:isar/isar.dart';
import '../models/expense.dart';

class ExpenseService {
  const ExpenseService(
    this.isar,
  );

  final Isar isar;

  // 全ての支出項目を取得
  Stream<List<Expense>?> watchExpenses() {
    return isar.expenses
        .where()
        .sortByDateDesc()
        .thenByCreatedDateDesc()
        .watch(fireImmediately: true);
  }

  // 支出を保存
  Future<void> saveExpense(
    DateTime date,
    String title,
    int amount,
  ) async {
    await isar.writeTxn(() async {
      // 新しい支出を保存
      final expense = Expense(
        date: date,
        title: title,
        amount: amount,
        createdDate: DateTime.now(),
        updatedDate: DateTime.now(),
      );
      await isar.expenses.put(expense);
    });
  }

  // 支出を編集
  Future<void> editExpense(
    int id,
    DateTime newDate,
    String newTitle,
    int newAmount,
  ) async {
    await isar.writeTxn(() async {
      final expense = await isar.expenses.get(id);
      if (expense != null) {
        expense.date = newDate;
        expense.title = newTitle;
        expense.amount = newAmount;
        await isar.expenses.put(expense);
      }
    });
  }

  // 支出を削除
  Future<void> deleteExpense(
    int id,
  ) async {
    await isar.writeTxn(() async {
      final expense = await isar.expenses.get(id);
      if (expense != null) {
        await isar.expenses.delete(id);
      }
    });
  }

  // 過去3ヶ月以前の支出を削除
  Future<void> deleteOldExpenses() async {
    await isar.writeTxn(() async {
      final now = DateTime.now();
      final threeMonthsAgo = DateTime(
        now.year,
        now.month - 3,
        1,
      );

      // 3ヶ月以上前の予算データを削除
      await isar.expenses.filter().dateLessThan(threeMonthsAgo).deleteAll();
    });
  }

  // 全ての支出を削除
  Future<void> deleteAllExpenses() async {
    await isar.writeTxn(() async {
      await isar.expenses.where().deleteAll();
    });
  }
}
