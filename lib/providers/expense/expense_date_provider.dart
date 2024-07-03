import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expense_date_provider.g.dart';

@riverpod
class ExpenseDate extends _$ExpenseDate {
  @override
  DateTime build() => DateTime.now();

  void setExpenseDate(DateTime expenseDate) {
    state = expenseDate;
  }
}
