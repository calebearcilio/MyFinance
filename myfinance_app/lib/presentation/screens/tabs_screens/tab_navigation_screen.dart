import 'package:flutter/material.dart';
import 'package:myfinance_app/presentation/screens/tabs_screens/buget_screen.dart';
import 'package:myfinance_app/presentation/screens/tabs_screens/home_screen.dart';
import 'package:myfinance_app/presentation/screens/tabs_screens/report_screen.dart';
import 'package:myfinance_app/presentation/screens/tabs_screens/transactions_screen.dart';

class TabNavigationScreen extends StatefulWidget {
  const TabNavigationScreen({super.key});

  @override
  State<TabNavigationScreen> createState() => _TabNavigationScreenState();
}

class _TabNavigationScreenState extends State<TabNavigationScreen> {
  int _currentIndex = 0;
  final _screens = const [
    HomeScreen(),
    TransactionsScreen(),
    BugetScreen(),
    ReportScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_rounded),
            label: "Início",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            activeIcon: Icon(Icons.account_balance_wallet_rounded),
            label: "Transações",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes_outlined),
            activeIcon: Icon(Icons.track_changes_rounded),
            label: "Orçamentos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart_outlined_outlined),
            activeIcon: Icon(Icons.insert_chart_rounded),
            label: "Relatórios",
          ),
        ],
      ),
    );
  }
}
