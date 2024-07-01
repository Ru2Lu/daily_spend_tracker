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
      body: Center(
        child: Text('今日使用出来る金額は${formatCommaSeparateNumber(
          dayBudget.toString(),
        )}円です'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
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
