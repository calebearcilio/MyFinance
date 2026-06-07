import 'package:flutter/material.dart';
import 'package:myfinance_app/features/buget/pages/buget_page.dart';
import 'package:myfinance_app/features/dashboard/pages/dashboard_page.dart';
import 'package:myfinance_app/features/report/pages/report_page.dart';
import 'package:myfinance_app/features/transaction/pages/transactions_page.dart';

class TabNavigationPage extends StatefulWidget {
  const TabNavigationPage({super.key});

  @override
  State<TabNavigationPage> createState() => _TabNavigationScreenState();
}

class _TabNavigationScreenState extends State<TabNavigationPage> {
  int _currentIndex = 0;
  final _screens = const [
    DashboardPage(),
    TransactionsPage(),
    BugetPage(),
    ReportPage(),
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
        items: const [
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
