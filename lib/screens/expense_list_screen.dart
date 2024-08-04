import 'package:daily_spend_tracker/providers/expense/expense_service_provider.dart';
import 'package:daily_spend_tracker/providers/monthly_budget_service_provider.dart';
import 'package:daily_spend_tracker/widgets/expense/expense_list.dart';
import 'package:daily_spend_tracker/widgets/expense/expense_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../utils/format.dart';

class ExpenseListScreen extends ConsumerWidget {
  const ExpenseListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final monthlyBudget = ref.watch(monthlyBudgetProvider).value?.amount;
    final expensesAsyncValue = ref.watch(expensesProvider);

    final now = DateTime.now();
    // 今月の日数
    final daysInThisMonth = DateUtils.getDaysInMonth(
      now.year,
      now.month,
    );
    // 今日使用出来る金額
    final dayBudget = ((monthlyBudget ?? 0) / daysInThisMonth).floor();
    // 今日までの今月の日数
    final daysInThisMonthUntilToday = DateTimeRange(
          start: DateTime(now.year, now.month, 1),
          end: now,
        ).duration.inDays +
        1;
    // 今日までの予算
    final budgetUntilToday = dayBudget * daysInThisMonthUntilToday;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          _formatFullDateWithWeekday(
            DateTime.now(),
          ),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: expensesAsyncValue.when(
        data: (expenses) {
          // 今月の支出項目のみを取り出す
          final thisMonthExpenses = (expenses ?? []).where((expense) {
            final expenseCreatedDate = expense.createdDate;
            return expenseCreatedDate.year == now.year &&
                expenseCreatedDate.month == now.month;
          }).toList();
          // 今日までの支出金額を計算
          final expenseAmountsUntilToday = thisMonthExpenses
              .where((expense) =>
                  expense.date != null &&
                  expense.date!.year == now.year &&
                  expense.date!.month == now.month &&
                  expense.date!.isBefore(
                    now.add(
                      const Duration(days: 1),
                    ),
                  ))
              .fold(0, (prev, curr) => prev + (curr.amount ?? 0));

          // 今日までの収支
          final thisMonthBalance = budgetUntilToday - expenseAmountsUntilToday;

          return Column(
            children: [
              // 本日までの収支
              ThisMonthBalance(thisMonthBalance: thisMonthBalance),
              // 支出一覧リスト
              ExpenseList(
                expensesAsyncValue: AsyncData(thisMonthExpenses),
                dayBudget: dayBudget,
              ),
            ],
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (err, stack) => const Center(
          child: Text('エラーが発生しました'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return const ExpenseBottomSheet();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  /// 曜日付きの日付にフォーマットする
  String _formatFullDateWithWeekday(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy/M/d(E)', 'ja');
    return formatter.format(date);
  }
}

/// 本日までの収支
class ThisMonthBalance extends StatelessWidget {
  const ThisMonthBalance({
    required this.thisMonthBalance,
    super.key,
  });

  final int thisMonthBalance;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '本日までの収支',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  thisMonthBalance > 0
                      ? Icons.trending_up
                      : Icons.trending_down,
                  color: thisMonthBalance > 0 ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  '${formatCommaSeparateNumber(
                    thisMonthBalance.toString(),
                  )}円',
                  style: TextStyle(
                    color: thisMonthBalance > 0 ? Colors.green : Colors.red,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
