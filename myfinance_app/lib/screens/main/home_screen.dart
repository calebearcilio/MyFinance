import 'package:flutter/material.dart';
import 'package:myfinance_app/components/app/app_scaffold.dart';
import 'package:myfinance_app/components/charts/home_chart.dart';
import 'package:myfinance_app/components/home_card.dart';
import 'package:myfinance_app/components/transaction/transaction_list.dart';
import 'package:myfinance_app/models/transaction.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Transaction> recentTransactions = dummyTransactions
      .where(
        (t) => t.date.isAfter(DateTime.now().subtract(Duration(days: 7))),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "DashBoard",
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: HomeCard(
                value: 2000,
                revenue: 20000,
                expense: 300,
              ),
            ),

            SliverToBoxAdapter(
              child: HomeChart(),
            ),

            SliverToBoxAdapter(
              child: Text("Transações recentes"),
            ),

            TransactionList(transactions: recentTransactions),
          ],
        ),
      ),
    );
  }
}
