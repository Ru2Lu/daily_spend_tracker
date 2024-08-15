import 'package:daily_spend_tracker/providers/expense/expense_service_provider.dart';
import 'package:daily_spend_tracker/providers/monthly_budget_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text(
              'プライバシーポリシー',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: const Icon(Icons.shield),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () async {
              final url = Uri.parse(
                  'https://ru2lu.github.io/daily_spend_tracker_privacy_policy_site/');
              await launchUrl(url);
            },
          ),
          ListTile(
            title: const Text(
              '全てのデータを削除する',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: const Icon(Icons.delete),
            onTap: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      '本当にデータを削除しますか？\n一度削除されたデータは元に戻すことが出来ません。',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('キャンセル'),
                      ),
                      TextButton(
                        onPressed: () async {
                          final expenseService =
                              await ref.read(expenseServiceProvider.future);
                          final monthlyBudgetService = await ref
                              .read(monthlyBudgetServiceProvider.future);
                          // 全ての支出を削除
                          await expenseService.deleteAllExpenses();
                          // 全ての月の予算を削除
                          await monthlyBudgetService.deleteAllMonthlyBudgets();
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        },
                        child: const Text(
                          '削除',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
