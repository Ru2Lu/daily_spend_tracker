import 'package:daily_spend_tracker/providers/expense/expense_service_provider.dart';
import 'package:daily_spend_tracker/providers/monthly_budget_service_provider.dart';
import 'package:daily_spend_tracker/providers/selected_year_month_provider.dart';
import 'package:daily_spend_tracker/widgets/expense/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final monthlyBudget = ref.watch(monthlyBudgetProvider).value?.budget;
    final expensesAsyncValue = ref.watch(expensesProvider);
    final selectedYearMonth = ref.watch(selectedYearMonthProvider);

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
      body: Column(
        children: [
          /// 年月フィルター
          OutlinedButton(
            onPressed: () {
              DatePicker.showPicker(
                context,
                showTitleActions: true,
                onConfirm: (date) {
                  ref
                      .read(selectedYearMonthProvider.notifier)
                      .setSelectedYearMonth(date);
                },
                pickerModel: YearMonth(
                  currentTime: DateTime(
                    selectedYearMonth.year,
                    selectedYearMonth.month,
                    1,
                  ),
                  // 過去2ヶ月分までの履歴を確認できる
                  minTime: DateTime(
                    now.year,
                    now.month - 2,
                    1,
                  ),
                  maxTime: DateTime(
                    now.year,
                    now.month - 1,
                    1,
                  ),
                  locale: LocaleType.jp,
                ),
                locale: LocaleType.jp,
              );
            },
            child: Text(
              _formatYearMonth(selectedYearMonth),
            ),
          ),

          /// 支出一覧
          Expanded(
            child: expensesAsyncValue.when(
              data: (expenses) {
                // フィルターと同じ年月の支出項目のみを取り出す
                final filteredExpenses = (expenses ?? []).where((expense) {
                  final expenseCreatedDate = expense.createdDate;
                  return expenseCreatedDate.year == selectedYearMonth.year &&
                      expenseCreatedDate.month == selectedYearMonth.month;
                }).toList();
                return filteredExpenses.isEmpty
                    ? const Center(
                        child: Text('履歴がありません'),
                      )
                    : Column(
                        children: [
                          // 支出一覧リスト
                          ExpenseList(
                            expensesAsyncValue: AsyncData(filteredExpenses),
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
          ),
        ],
      ),
    );
  }

  /// 年月の日付にフォーマットする
  String _formatYearMonth(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy年M月', 'ja');
    return formatter.format(date);
  }
}

/// DatePickerを年月のみにするためのモデル
class YearMonth extends DatePickerModel {
  YearMonth({
    required DateTime super.currentTime,
    required DateTime super.minTime,
    required DateTime super.maxTime,
    required LocaleType super.locale,
  });

  @override
  List<int> layoutProportions() => [1, 1, 0];
}
