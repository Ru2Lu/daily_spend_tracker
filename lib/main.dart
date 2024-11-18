import 'package:daily_spend_tracker/providers/expense/expense_service_provider.dart';
import 'package:daily_spend_tracker/providers/index_bottom_navbar_provider.dart';
import 'package:daily_spend_tracker/providers/budget_service_provider.dart';
import 'package:daily_spend_tracker/screens/expense_list_screen.dart';
import 'package:daily_spend_tracker/screens/history_screen.dart';
import 'package:daily_spend_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
    ref.read(indexBottomNavbarProvider.notifier).setIndexBottomNavbar(0);
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    // アプリのライフサイクルの監視を開始
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      await _deleteOldData();
    }
  }

  @override
  void dispose() {
    // アプリのライフサイクルの監視を終了
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _deleteOldData() async {
    await ref.read(budgetServiceProvider.future).then(
          (service) => service.deleteOldBudgets(),
        );
    await ref.read(expenseServiceProvider.future).then(
          (service) => service.deleteOldExpenses(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeScreen(),
      const ExpenseListScreen(),
      const HistoryScreen(),
    ];

    final indexBottomNavbar = ref.watch(indexBottomNavbarProvider);

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
          currentIndex: indexBottomNavbar,
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
            ref
                .read(indexBottomNavbarProvider.notifier)
                .setIndexBottomNavbar(value);
          },
        ),
        body: screens[indexBottomNavbar],
      ),
    );
  }
}
