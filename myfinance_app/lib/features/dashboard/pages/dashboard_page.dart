import 'package:flutter/material.dart';
import 'package:myfinance_app/features/common/components/app_scaffold.dart';
import 'package:myfinance_app/core/models/transaction/transaction_filter.dart';
import 'package:myfinance_app/features/dashboard/components/dashboard_card.dart';
import 'package:myfinance_app/features/dashboard/components/dashboard_chart.dart';
import 'package:myfinance_app/features/transaction/components/transaction_list.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {


  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "DashBoard",
      body: CustomScrollView(
        slivers: [

          // Card de resumo do mês
          DashboardCard(),

          
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

          TransactionList(
            filter: TransactionFilter(
              startDate: DateTime.now().subtract(Duration(days: 7)),
            ),
          ),
        ],
      ),
    );
  }
}
