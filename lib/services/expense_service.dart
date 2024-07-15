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
      );
      await isar.expenses.put(expense);
    });
  }
}
