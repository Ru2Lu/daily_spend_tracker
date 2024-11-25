import 'package:daily_spend_tracker/providers/expense_service_provider.dart';
import 'package:daily_spend_tracker/providers/budget_service_provider.dart';
import 'package:daily_spend_tracker/screens/settings_screen.dart';
import 'package:daily_spend_tracker/utils/format.dart';
import 'package:daily_spend_tracker/widgets/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends HookConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedYearMonth = useState<DateTime>(
      DateTime(
        DateTime.now().year,
        DateTime.now().month - 1,
      ),
    );
    final budget = ref
        .watch(
          budgetProvider(
            selectedYearMonth.value.year,
            selectedYearMonth.value.month,
          ),
        )
        .value
        ?.amount;
    // フィルターと同じ年月の支出項目のみを取り出す
    final expenses = (ref.watch(expensesProvider).value ?? []).where((expense) {
      final expenseDate = expense.date;
      return expenseDate!.year == selectedYearMonth.value.year &&
          expenseDate.month == selectedYearMonth.value.month;
    }).toList();

    final spending = expenses.fold(
      0,
      (prev, expense) => prev + (expense.amount ?? 0),
    );

    final now = DateTime.now();
    // 今月の日数
    final daysInThisMonth = DateUtils.getDaysInMonth(
      now.year,
      now.month,
    );
    // 今日使用出来る金額
    final dayBudget = ((budget ?? 0) / daysInThisMonth).floor();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
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
                  selectedYearMonth.value = date;
                },
                pickerModel: YearMonth(
                  currentTime: DateTime(
                    selectedYearMonth.value.year,
                    selectedYearMonth.value.month,
                    1,
                  ),
                  // 過去3ヶ月分までの履歴を確認できる
                  minTime: DateTime(
                    now.year,
                    now.month - 3,
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
              _formatYearMonth(selectedYearMonth.value),
            ),
          ),

          /// 月の概要
          if (budget != null)
            MonthSummary(
              budget: budget,
              spending: spending,
            ),

          /// 支出一覧
          Expanded(
            child: expenses.isEmpty
                ? const Center(
                    child: Text('履歴がありません'),
                  )
                : Column(
                    children: [
                      // 支出一覧リスト
                      ExpenseList(
                        expensesAsyncValue: AsyncData(expenses),
                        dayBudget: dayBudget,
                        canEditAndDelete: false,
                      ),
                    ],
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

/// 月の概要
class MonthSummary extends StatelessWidget {
  const MonthSummary({
    required this.budget,
    required this.spending,
    super.key,
  });

  final int budget;

  final int spending;

  @override
  Widget build(BuildContext context) {
    final balance = budget - spending;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              /// 予算
              Text(
                '${formatCommaSeparateNumber(
                  budget.toString(),
                )}円',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Text(
                '-',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              /// 支出
              Text(
                '${formatCommaSeparateNumber(
                  spending.toString(),
                )}円',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Text(
                '=',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              /// 収支
              Text(
                '${formatCommaSeparateNumber(
                  balance.toString(),
                )}円',
                style: TextStyle(
                  color: balance > 0 ? Colors.green : Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
