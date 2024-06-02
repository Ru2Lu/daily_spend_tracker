import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/monthly_budget_provider.dart';
import '../providers/dialog_error_message_provider.dart';
import '../utils/format.dart';

class MonthlyBudgetDialog extends ConsumerStatefulWidget {
  const MonthlyBudgetDialog({super.key});

  @override
  MonthlyBudgetDialogState createState() => MonthlyBudgetDialogState();
}

class MonthlyBudgetDialogState extends ConsumerState<MonthlyBudgetDialog> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (
      BuildContext context,
      StateSetter setState,
    ) {
      return AlertDialog(
        title: const Text(
          '今月使用できる金額を入力してください',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Consumer(
          builder: (context, ref, _) {
            final errorMessage = ref.watch(dialogErrorMessageProvider);
            return TextFormField(
              controller: _controller,
              autofocus: true,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 42),
              decoration: InputDecoration(
                hintText: '300,000',
                suffixText: '円',
                errorText: errorMessage,
              ),
              onChanged: (budgetValue) {
                if (budgetValue.isNotEmpty) {
                  ref
                      .read(dialogErrorMessageProvider.notifier)
                      .clearDialogErrorMessage();
                }
                budgetValue = formatCommaSeparateNumber(
                  budgetValue.replaceAll(',', ''),
                );
                _controller.value = TextEditingValue(
                  text: budgetValue,
                  selection: TextSelection.collapsed(
                    offset: budgetValue.length,
                  ),
                );
              },
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_controller.text.isEmpty) {
                // 金額が入力されていない場合は確定を押してもダイアログが閉じない
                ref
                    .read(dialogErrorMessageProvider.notifier)
                    .setDialogErrorMessage('金額を入力してください');
              } else {
                // 金額が入力されてる場合はダイアログを閉じる
                final monthlyBudget = int.tryParse(
                  _controller.text.replaceAll(',', ''),
                );
                ref
                    .read(monthlyBudgetProvider.notifier)
                    .setMonthlyBudget(monthlyBudget);
                Navigator.of(context).pop();
              }
            },
            child: const Text('確定'),
          ),
        ],
      );
    });
  }
}
