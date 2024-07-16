import 'package:daily_spend_tracker/models/expense.dart';
import 'package:daily_spend_tracker/providers/expense/expense_item_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:daily_spend_tracker/providers/expense/expense_service_provider.dart';

class ExpenseBottomSheet extends ConsumerStatefulWidget {
  const ExpenseBottomSheet({
    super.key,
    this.expense,
  });

  final Expense? expense;

  @override
  ExpenseBottomSheetState createState() => ExpenseBottomSheetState();
}

class ExpenseBottomSheetState extends ConsumerState<ExpenseBottomSheet> {
  late TextEditingController titleController;
  late TextEditingController amountController;
  late DateTime selectedDate;
  String? titleErrorMessage;
  String? amountErrorMessage;

  @override
  void initState() {
    super.initState();
    if (widget.expense != null) {
      titleController = TextEditingController(text: widget.expense!.title);
      amountController =
          TextEditingController(text: widget.expense!.amount.toString());
      selectedDate = widget.expense!.date!;
    } else {
      titleController = TextEditingController(text: '');
      amountController = TextEditingController(text: '');
      final now = DateTime.now();
      selectedDate = DateTime(now.year, now.month, now.day);
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// 日付
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: ListTile(
              title: Text(
                DateFormat('yyyy/MM/dd').format(selectedDate),
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: () => _pickDateOfThisMonth(context, ref),
            ),
          ),

          /// タイトル
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'タイトル',
                errorText: titleErrorMessage,
              ),
              onChanged: (value) {
                ref.read(expenseItemProvider.notifier).setTitle(value);
                setState(() {
                  titleErrorMessage = value.isEmpty ? 'タイトルを入力してください' : null;
                });
              },
            ),
          ),

          /// 金額
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: '金額',
                errorText: amountErrorMessage,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*'))
              ],
              onChanged: (value) {
                final expenseAmount = int.tryParse(value) ?? 0;
                ref.read(expenseItemProvider.notifier).setAmount(expenseAmount);
                setState(() {
                  amountErrorMessage = value.isEmpty ? '金額を入力してください' : null;
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: titleController.text.isNotEmpty &&
                    amountController.text.isNotEmpty
                ? () async {
                    final expenseAmount = int.parse(amountController.text);
                    final expenseService =
                        await ref.read(expenseServiceProvider.future);
                    if (widget.expense == null) {
                      // 新規作成
                      await expenseService.saveExpense(
                        selectedDate,
                        titleController.text,
                        expenseAmount,
                      );
                    } else {
                      // 編集
                      await expenseService.editExpense(
                        widget.expense!.id,
                        selectedDate,
                        titleController.text,
                        expenseAmount,
                      );
                    }
                    if (!context.mounted) return;
                    Navigator.of(context).pop();
                  }
                : null,
            child: Text(widget.expense == null ? '保存' : '更新'),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _pickDateOfThisMonth(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      locale: const Locale("ja"),
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(now.year, now.month, 1),
      lastDate: DateTime(now.year, now.month, now.day),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }
}
