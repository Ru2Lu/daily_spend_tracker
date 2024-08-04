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
        // 今月の予算が未入力の場合はダイアログを表示する
        final monthlyBudget =
            await ref.read(monthlyBudgetServiceProvider.future).then(
                  (service) => service.getMonthlyBudget(),
                );
        if (monthlyBudget?.amount == null) {
          _showMonthlyBudgetDialog();
        }
      },
    );
  }

  Future<void> _showMonthlyBudgetDialog({int? monthlyBudget}) async {
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
    final monthlyBudget = ref.watch(monthlyBudgetProvider).value?.amount;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              monthlyBudget != null
                  ? '今月使用できる金額は${formatCommaSeparateNumber(
                      monthlyBudget.toString(),
                    )}円です'
                  : '今月使用できる金額は-円です',
            ),
            IconButton(
              onPressed: () {
                _showMonthlyBudgetDialog(monthlyBudget: monthlyBudget);
              },
              icon: const Icon(Icons.edit),
            )
          ],
        ),
      ),
    );
  }
}
