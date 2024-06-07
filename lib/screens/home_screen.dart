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
      (_) {
        _showMonthlyBudgetDialog();
      },
    );
  }

  Future<void> _showMonthlyBudgetDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const MonthlyBudgetDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final monthlyBudget = ref.watch(monthlyBudgetProvider).value?.budget;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('ホーム画面'),
      ),
      body: Center(
        child: Text(
          monthlyBudget != null
              ? '今月使用できる金額は${formatCommaSeparateNumber(
                  monthlyBudget.toString(),
                )}円です'
              : '今月使用できる金額は-円です',
        ),
      ),
    );
  }
}
