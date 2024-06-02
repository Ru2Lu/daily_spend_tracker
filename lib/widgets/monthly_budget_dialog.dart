import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/monthly_budget_provider.dart';
import '../providers/dialog/dialog_controller_provider.dart';
import '../providers/dialog/dialog_error_message_provider.dart';
import '../utils/format.dart';

class MonthlyBudgetDialog extends ConsumerWidget {
  const MonthlyBudgetDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(dialogControllerProvider);
    final errorMessage = ref.watch(dialogErrorMessageProvider);

    return AlertDialog(
      title: const Text(
        '今月使用できる金額を入力してください',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: TextFormField(
        controller: controller,
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
          controller.value = TextEditingValue(
            text: budgetValue,
            selection: TextSelection.collapsed(
              offset: budgetValue.length,
            ),
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (controller.text.isEmpty) {
              // 金額が入力されていない場合は確定を押してもダイアログが閉じない
              ref
                  .read(dialogErrorMessageProvider.notifier)
                  .setDialogErrorMessage('金額を入力してください');
            } else {
              // 金額が入力されてる場合はダイアログを閉じる
              final monthlyBudget = int.tryParse(
                controller.text.replaceAll(',', ''),
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
  }
}
