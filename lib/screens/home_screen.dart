import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? _monthlyBudget;
  final _controller = TextEditingController();
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _showMonthlyBudgetInputDialog();
      },
    );
  }

  Future<void> _showMonthlyBudgetInputDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (
          BuildContext context,
          StateSetter setDialogState,
        ) {
          return AlertDialog(
            title: const Text(
              '今月使用できる金額を入力してください',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: TextFormField(
              controller: _controller,
              autofocus: true,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 42),
              decoration: InputDecoration(
                hintText: '300,000',
                suffixText: '円',
                errorText: _errorMessage,
              ),
              onChanged: (budgetValue) {
                if (budgetValue.isNotEmpty) {
                  setDialogState(() {
                    _errorMessage = null;
                  });
                }
                budgetValue = _formMoneyString(
                  budgetValue.replaceAll(',', ''),
                );
                _controller.value = TextEditingValue(
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
                  if (_controller.text.isEmpty) {
                    // 金額が入力されていない場合は確定を押してもダイアログが閉じない
                    setDialogState(() {
                      _errorMessage = '金額を入力してください';
                    });
                  } else {
                    // 金額が入力されてる場合はダイアログを閉じる
                    setState(() {
                      _monthlyBudget = int.tryParse(
                        _controller.text.replaceAll(',', ''),
                      );
                    });
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('確定'),
              ),
            ],
          );
        });
      },
    );
  }

  String _formMoneyString(String money) {
    return NumberFormat.decimalPattern().format(
      int.parse(money),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('ホーム画面'),
      ),
      body: Center(
        child: Text(
          _monthlyBudget != null
              ? '今月使用できる金額は${_formMoneyString(_monthlyBudget.toString())}円です'
              : '今月使用できる金額は-円です',
        ),
      ),
    );
  }
}
