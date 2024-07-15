import 'package:flutter/material.dart';
import '../../utils/format.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({
    required this.title,
    required this.amount,
    super.key,
  });

  /// 支出のタイトル
  final String title;

  /// 支出の金額
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 支出のタイトル
            Expanded(
              flex: 2,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            // 支出の金額
            Expanded(
              flex: 1,
              child: Text(
                '${formatCommaSeparateNumber(amount)}円',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
