import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expense_item_provider.g.dart';

@riverpod
class ExpenseItem extends _$ExpenseItem {
  @override
  ExpenseItemData build() => ExpenseItemData();

  void setTitle(String title) {
    state = state.copyWith(title: title);
  }

  void setAmount(int amount) {
    state = state.copyWith(amount: amount);
  }
}

class ExpenseItemData {
  final String title;
  final int amount;

  ExpenseItemData({
    this.title = '',
    this.amount = 0,
  });

  ExpenseItemData copyWith({
    String? title,
    int? amount,
  }) {
    return ExpenseItemData(
      title: title ?? this.title,
      amount: amount ?? this.amount,
    );
  }
}
