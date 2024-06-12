import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseListScreen extends ConsumerWidget {
  const ExpenseListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('今月の支出画面'),
      ),
      body: const Center(
        child: Text('今月の支出!'),
      ),
    );
  }
}
