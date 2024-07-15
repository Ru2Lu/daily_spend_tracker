import 'package:daily_spend_tracker/models/expense.dart';
import 'package:daily_spend_tracker/providers/expense/expense_service_provider.dart';
import 'package:daily_spend_tracker/providers/monthly_budget_service_provider.dart';
import 'package:daily_spend_tracker/widgets/expense_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/format.dart';

class ExpenseListScreen extends ConsumerWidget {
  const ExpenseListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final monthlyBudget = ref.watch(monthlyBudgetProvider).value?.budget;
    final expensesAsyncValue = ref.watch(expensesProvider);

    final now = DateTime.now();
    // 今月の日数
    final daysInThisMonth = DateUtils.getDaysInMonth(
      now.year,
      now.month,
    );
    // 今日使用出来る金額
    final dayBudget = ((monthlyBudget ?? 0) / daysInThisMonth).floor();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('今月の支出画面'),
      ),
      body: Column(
        children: [
          // 今日使用出来る金額
          Text('今日使用出来る金額は${formatCommaSeparateNumber(
            dayBudget.toString(),
          )}円です'),
          // 支出一覧リスト
          ExpenseList(expensesAsyncValue: expensesAsyncValue),
        ],
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
}

/// 支出一覧リスト
class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key,
    required this.expensesAsyncValue,
  });

  final AsyncValue<List<Expense>?> expensesAsyncValue;

  @override
  Widget build(BuildContext context) {
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

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 日付
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      '${currentDate.month}/${currentDate.day}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // 支出項目一覧
                  ...expensesByCurrentDate!.map((expense) {
                    return ExpenseCard(
                      title: expense.title ?? '',
                      amount: expense.amount.toString(),
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
}

/// 支出項目
class ExpenseCard extends StatelessWidget {
  const ExpenseCard({
    required this.title,
    required this.amount,
    super.key,
  });

  /// 支出のタイトル
  final String title;

  /// 支出の金額
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
            Flexible(
              flex: 1,
              child: Text(
                '${formatCommaSeparateNumber(amount)}円',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
