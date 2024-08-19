import 'package:daily_spend_tracker/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/monthly_budget_dialog.dart';
import '../providers/monthly_budget_service_provider.dart';
import '../utils/format.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        _showDialogOnMissingMonthlyBudget();
      },
    );
  }

  Future<void> _showDialogOnMissingMonthlyBudget() async {
    final now = DateTime.now();
    // 今月の予算が未入力の場合はダイアログを表示する
    final monthlyBudget =
        await ref.read(monthlyBudgetServiceProvider.future).then(
              (service) => service.getMonthlyBudgetByYearMonth(
                year: now.year,
                month: now.month,
              ),
            );
    if (monthlyBudget?.amount == null) {
      _showDialog();
    }
  }

  Future<void> _showDialog({int? monthlyBudget}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return MonthlyBudgetDialog(initialValue: monthlyBudget);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final monthlyBudget = ref
        .watch(
          monthlyBudgetProvider(
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
              _showDialogOnMissingMonthlyBudget();
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
                      monthlyBudget != null
                          ? formatCommaSeparateNumber(
                              monthlyBudget.toString(),
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
                      _showDialog(monthlyBudget: monthlyBudget);
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
