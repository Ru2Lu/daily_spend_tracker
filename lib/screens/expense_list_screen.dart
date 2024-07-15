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
        data: (expenses) => ListView.builder(
          itemCount: expenses?.length ?? 0,
          itemBuilder: (context, index) {
            final expense = expenses?[index];
            return ListTile(
              title: Text('${expense?.date}'),
              subtitle: Text('${expense?.title} ¥${expense?.amount ?? 0}'),
            );
          },
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (err, stack) => const Center(
          child: Text('エラーが発生しました'),
        ),
      ),
    );
  }
}
