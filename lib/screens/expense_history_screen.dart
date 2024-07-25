import 'package:flutter/material.dart';

class ExpenseHistoryScreen extends StatelessWidget {
  const ExpenseHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('履歴画面'),
      ),
      body: const Center(
        child: Text('履歴画面！！！'),
      ),
    );
  }
}
