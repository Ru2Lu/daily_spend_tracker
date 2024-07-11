import 'package:isar/isar.dart';
import '../models/expense.dart';

class ExpenseService {
  const ExpenseService(
    this.isar,
  );

  final Isar isar;

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
      );
      await isar.expenses.put(expense);
    });
  }
}
