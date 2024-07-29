import 'package:daily_spend_tracker/providers/expense/expense_service_provider.dart';
import 'package:daily_spend_tracker/providers/monthly_budget_service_provider.dart';
import 'package:daily_spend_tracker/widgets/expense/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

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
      ),
      body: expensesAsyncValue.when(
        data: (expenses) {
          return (expenses ?? []).isEmpty
              ? const Center(
                  child: Text('履歴がありません'),
                )
              : Column(
                  children: [
                    // 支出一覧リスト
                    ExpenseList(
                      expensesAsyncValue: AsyncData(expenses),
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
    );
  }
}
