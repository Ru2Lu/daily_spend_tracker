import 'package:daily_spend_tracker/providers/expense_service_provider.dart';
import 'package:daily_spend_tracker/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/budget_dialog.dart';
import '../providers/budget_service_provider.dart';
import '../utils/format.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        // 古いデータを削除
        await _deleteOldData();
        // 今月の予算が入力されていない場合はダイアログを表示
        await _showDialogOnMissingBudget();
      },
    );
  }

  Future<void> _deleteOldData() async {
    await ref.read(budgetServiceProvider.future).then(
          (service) => service.deleteOldBudgets(),
        );
    await ref.read(expenseServiceProvider.future).then(
          (service) => service.deleteOldExpenses(),
        );
  }

  Future<void> _showDialogOnMissingBudget() async {
    final now = DateTime.now();
    // 今月の予算が未入力の場合はダイアログを表示する
    final budget = await ref.read(budgetServiceProvider.future).then(
          (service) => service.getBudgetByYearMonth(
            year: now.year,
            month: now.month,
          ),
        );
    if (budget?.amount == null) {
      _showDialog();
    }
  }

  Future<void> _showDialog({int? budget}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BudgetDialog(initialValue: budget);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final budget = ref
        .watch(
          budgetProvider(
            now.year,
            now.month,
          ),
        )
        .value
        ?.amount;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
              _showDialogOnMissingBudget();
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '今月の予算',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      budget != null
                          ? formatCommaSeparateNumber(
                              budget.toString(),
                            )
                          : '-',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 45,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  const Text('円'),
                  IconButton(
                    onPressed: () {
                      _showDialog(budget: budget);
                    },
                    icon: const Icon(Icons.edit),
                    iconSize: 30,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
