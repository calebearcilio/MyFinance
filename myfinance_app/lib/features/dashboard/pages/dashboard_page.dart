import 'package:flutter/material.dart';
import 'package:myfinance_app/core/services/services_locator.dart';
import 'package:myfinance_app/features/common/components/app_scaffold.dart';
import 'package:myfinance_app/features/common/model/transaction_filter.dart';
import 'package:myfinance_app/features/dashboard/components/dashboard_card.dart';
import 'package:myfinance_app/features/dashboard/components/dashboard_chart.dart';
import 'package:myfinance_app/features/transaction/components/transaction_list.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final transactionRepository = ServiceLocator.transactionRepository;
  final categoryRepository = ServiceLocator.categoryRepository;

  void loadData() async {}

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "DashBoard",
      body: CustomScrollView(
        slivers: [
          // Card de resumo
          SliverToBoxAdapter(
            child: DashboardCard(
              value: 2000,
              revenue: 0, // Será calculado quando implementar
              expense: 0, // Será calculado quando implementar
            ),
          ),
          SliverToBoxAdapter(
            child: DashboardChart(),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Text(
                "Transações recentes",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          // Transações recentes usando Stream
          TransactionList(
            filter: TransactionFilter(categoryId: "all"),
          ),
        ],
      ),
    );
  }
}
