import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../utils/format.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({
    required this.title,
    required this.amount,
    required this.editExpense,
    required this.deleteExpense,
    required this.canEditAndDelete,
    super.key,
  });

  /// 支出のタイトル
  final String title;

  /// 支出の金額
  final String amount;

  /// 支出の編集
  final void Function() editExpense;

  /// 支出の削除
  final void Function() deleteExpense;

  /// 編集・削除が可能かどうか
  final bool canEditAndDelete;

  @override
  Widget build(BuildContext context) {
    return canEditAndDelete
        ? Slidable(
            key: const ValueKey(0),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (BuildContext context) {
                    editExpense();
                  },
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: '編集',
                ),
                SlidableAction(
                  onPressed: (BuildContext context) {
                    deleteExpense();
                  },
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: '削除',
                ),
              ],
            ),
            child: BaseExpenseCard(
              title: title,
              amount: amount,
            ),
          )
        : BaseExpenseCard(
            title: title,
            amount: amount,
          );
  }
}

class BaseExpenseCard extends StatelessWidget {
  const BaseExpenseCard({
    required this.title,
    required this.amount,
    super.key,
  });

  final String title;

  final String amount;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 支出のタイトル
            Expanded(
              flex: 2,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            // 支出の金額
            Expanded(
              flex: 1,
              child: Text(
                '${formatCommaSeparateNumber(amount)}円',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
