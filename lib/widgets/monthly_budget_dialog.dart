import 'package:daily_spend_tracker/providers/monthly_budget_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dialog/dialog_controller_provider.dart';
import '../providers/dialog/dialog_error_message_provider.dart';
import '../utils/format.dart';

class MonthlyBudgetDialog extends ConsumerStatefulWidget {
  const MonthlyBudgetDialog({
    this.initialValue,
    super.key,
  });

  /// 今月の予算の初期値
  final int? initialValue;

  @override
  MonthlyBudgetDialogState createState() => MonthlyBudgetDialogState();
}

class MonthlyBudgetDialogState extends ConsumerState<MonthlyBudgetDialog> {
  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      final controller = ref.read(dialogControllerProvider);
      final initialText = widget.initialValue!.toString();
      final budgetValue = formatCommaSeparateNumber(
        initialText.replaceAll(',', ''),
      );
      controller.value = TextEditingValue(
        text: budgetValue,
        selection: TextSelection.collapsed(
          offset: budgetValue.length,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
              final monthlyBudget = int.tryParse(
                controller.text.replaceAll(',', ''),
              );
              if ((monthlyBudget ?? 0) <= 0) {
                ref
                    .read(dialogErrorMessageProvider.notifier)
                    .setDialogErrorMessage('金額を入力してください');
              } else {
                // 金額が入力されてる場合はダイアログを閉じる
                ref.read(monthlyBudgetServiceProvider.future).then(
                      (service) => service.saveMonthlyBudget(monthlyBudget),
                    );
                Navigator.of(context).pop();
              }
            }
          },
          child: const Text('確定'),
        ),
      ],
    );
  }
}
