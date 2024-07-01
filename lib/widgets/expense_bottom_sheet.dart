import 'package:flutter/material.dart';

class ExpenseBottomSheet extends StatelessWidget {
  const ExpenseBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('支出入力欄'),
          ],
        ),
      ),
    );
  }
}
