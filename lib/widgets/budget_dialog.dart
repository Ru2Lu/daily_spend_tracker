import 'package:daily_spend_tracker/providers/budget_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/dialog/dialog_controller_provider.dart';
import '../utils/format.dart';

class BudgetDialog extends HookConsumerWidget {
  const BudgetDialog({
    this.initialValue,
    super.key,
  });

  /// 今月の予算の初期値
  final int? initialValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(dialogControllerProvider);
    final errorMessage = useState<String?>(null);

    useEffect(() {
      if (initialValue != null) {
        final controller = ref.read(dialogControllerProvider);
        final initialText = initialValue!.toString();
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
      return null;
    }, [initialValue]);

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
          errorText: errorMessage.value,
        ),
        onChanged: (budgetValue) {
          if (budgetValue.isNotEmpty) {
            errorMessage.value = null;
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
              errorMessage.value = '金額を入力してください';
            } else {
              final budget = int.tryParse(
                controller.text.replaceAll(',', ''),
              );
              if ((budget ?? 0) <= 0) {
                errorMessage.value = '金額を入力してください';
              } else {
                // 金額が入力されてる場合はダイアログを閉じる
                ref.read(budgetServiceProvider.future).then(
                      (service) => service.saveBudget(budget),
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
