import 'package:daily_spend_tracker/providers/index_bottom_navbar_provider.dart';
import 'package:daily_spend_tracker/screens/expense_list_screen.dart';
import 'package:daily_spend_tracker/screens/history_screen.dart';
import 'package:daily_spend_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
