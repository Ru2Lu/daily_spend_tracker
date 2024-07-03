import 'package:daily_spend_tracker/providers/expense/expense_date_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ExpenseBottomSheet extends ConsumerWidget {
  const ExpenseBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(expenseDateProvider);

    return SizedBox(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              title: Text(
                DateFormat('yyyy/MM/dd').format(selectedDate),
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: () => _pickDateOfThisMonth(context, ref),
            ),
          ],
        ),
      ),
    );
  }

  void _pickDateOfThisMonth(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final now = DateTime.now();
    final lastDayOfThisMonth = DateTime(now.year, now.month + 1, 0).day;
    final pickedDate = await showDatePicker(
      locale: const Locale("ja"),
      context: context,
      initialDate: ref.read(expenseDateProvider),
      firstDate: DateTime(now.year, now.month, 1),
      lastDate: DateTime(now.year, now.month, lastDayOfThisMonth),
    );

    if (pickedDate != null) {
      ref.read(expenseDateProvider.notifier).setExpenseDate(pickedDate);
    }
  }
}
