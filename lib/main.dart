import 'package:daily_spend_tracker/providers/expense_service_provider.dart';
import 'package:daily_spend_tracker/providers/budget_service_provider.dart';
import 'package:daily_spend_tracker/screens/expense_list_screen.dart';
import 'package:daily_spend_tracker/screens/history_screen.dart';
import 'package:daily_spend_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: RestartWidget(
        child: MyApp(),
      ),
    ),
  );
}

class RestartWidget extends StatefulWidget {
  const RestartWidget({
    required this.child,
    super.key,
  });

  final Widget child;

  static void restartApp(
    BuildContext context,
    WidgetRef ref,
  ) {
    context.findAncestorStateOfType<RestartWidgetState>()!.restartApp(ref);
  }

  @override
  RestartWidgetState createState() => RestartWidgetState();
}

class RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp(WidgetRef ref) {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

class MyApp extends HookConsumerWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexBottomNavbar = useState(0);
    final appLifecycleState = useAppLifecycleState();

    final screens = [
      const HomeScreen(),
      const ExpenseListScreen(),
      const HistoryScreen(),
    ];

    useEffect(() {
      Future<void> deleteOldData() async {
        final budgetService = await ref.read(budgetServiceProvider.future);
        await budgetService.deleteOldBudgets();
        final expenseService = await ref.read(expenseServiceProvider.future);
        await expenseService.deleteOldExpenses();
      }

      // アプリが再開されたときに古いデータを削除
      if (appLifecycleState == AppLifecycleState.resumed) {
        deleteOldData();
      }

      return null;
    }, [appLifecycleState]);

    return MaterialApp(
      title: '毎日収支管理',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("ja"),
      ],
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: indexBottomNavbar.value,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'ホーム',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long),
              label: '今月の支出',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart),
              label: '履歴',
            ),
          ],
          onTap: (value) {
            indexBottomNavbar.value = value;
          },
        ),
        body: screens[indexBottomNavbar.value],
      ),
    );
  }
}
