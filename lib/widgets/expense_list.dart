import 'package:daily_spend_tracker/models/expense.dart';
import 'package:daily_spend_tracker/providers/expense_service_provider.dart';
import 'package:daily_spend_tracker/widgets/expense_bottom_sheet.dart';
import 'package:daily_spend_tracker/widgets/expense_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../utils/format.dart';

class ExpenseList extends ConsumerWidget {
  const ExpenseList({
    required this.expensesAsyncValue,
    required this.dayBudget,
    required this.canEditAndDelete,
    super.key,
  });

  final AsyncValue<List<Expense>?> expensesAsyncValue;

  final int dayBudget;

  final bool canEditAndDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: expensesAsyncValue.when(
        data: (expenses) {
          if (expenses == null || expenses.isEmpty) {
            return const Center(
              child: Text('支出項目がありません'),
            );
          }

          // 日付ごとに支出項目をグループ化
          final expensesByDate = _groupExpensesByDate(expenses);

          return ListView.builder(
            itemCount: expensesByDate.keys.length,
            itemBuilder: (context, index) {
              final currentDate = expensesByDate.keys.elementAt(index);
              final expensesByCurrentDate = expensesByDate[currentDate];
              final sumOfAmountByCurrentDate = (expensesByCurrentDate ?? [])
                  .map((expense) => expense.amount ?? 0)
                  .fold(0, (prev, curr) => prev + curr);
              final remainingBalance = dayBudget - sumOfAmountByCurrentDate;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 日付
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          _formatDateWithWeekday(currentDate),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // 1日の収支
                      RemainingBalance(remainingBalance: remainingBalance),
                    ],
                  ),
                  // 支出項目一覧
                  ...expensesByCurrentDate!.map((expense) {
                    return ExpenseCard(
                      title: expense.title ?? '',
                      amount: expense.amount.toString(),
                      editExpense: () {
                        if (canEditAndDelete) {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return ExpenseBottomSheet(expense: expense);
                            },
                          );
                        }
                      },
                      deleteExpense: () async {
                        if (canEditAndDelete) {
                          final expenseService =
                              await ref.read(expenseServiceProvider.future);
                          // 削除
                          await expenseService.deleteExpense(expense.id);
                        }
                      },
                      canEditAndDelete: canEditAndDelete,
                    );
                  }),
                ],
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (err, stack) => const Center(
          child: Text('エラーが発生しました'),
        ),
      ),
    );
  }

  /// 日付毎に支出をグルーピングする
  Map<DateTime, List<Expense>> _groupExpensesByDate(List<Expense> expenses) {
    final Map<DateTime, List<Expense>> expensesByDate = {};

    for (var expense in expenses) {
      final expenseDate = expense.date;
      if (expenseDate == null) {
        continue;
      }
      final currentDate = DateTime(
        expenseDate.year,
        expenseDate.month,
        expenseDate.day,
      );
      if (expensesByDate[currentDate] == null) {
        expensesByDate[currentDate] = [expense];
      } else {
        expensesByDate[currentDate]!.add(expense);
      }
    }

    return expensesByDate;
  }

  /// 曜日付きの日付にフォーマットする
  String _formatDateWithWeekday(DateTime date) {
    final DateFormat formatter = DateFormat('M/d(E)', 'ja');
    return formatter.format(date);
  }
}

/// 1日の収支
class RemainingBalance extends StatelessWidget {
  const RemainingBalance({
    required this.remainingBalance,
    super.key,
  });

  final int remainingBalance;

  @override
  Widget build(BuildContext context) {
    final isPositiveBalance = remainingBalance > 0;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Text(
            isPositiveBalance ? '+' : '-',
            style: TextStyle(
              color: isPositiveBalance ? Colors.green : Colors.red,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${formatCommaSeparateNumber(
              remainingBalance.abs().toString(),
            )}円',
            style: TextStyle(
              color: isPositiveBalance ? Colors.green : Colors.red,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
