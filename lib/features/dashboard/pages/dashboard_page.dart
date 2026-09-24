import 'package:flutter/material.dart';
import 'package:my_finance/core/models/category/category_summary.dart';
import 'package:my_finance/core/models/finance/finance.dart';
import 'package:my_finance/core/services/services_locator.dart';
import 'package:my_finance/features/common/components/app_scaffold.dart';
import 'package:my_finance/core/models/transaction/transaction_filter.dart';
import 'package:my_finance/features/dashboard/components/card_loading.dart';
import 'package:my_finance/features/dashboard/components/dashboard_card.dart';
import 'package:my_finance/features/charts/components/expense_by_category_chart.dart';
import 'package:my_finance/features/transaction/components/transaction_list.dart';

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
          StreamBuilder<Finance>(
            stream: ServiceLocator.transactionRepository.wacthMonthlyFinance(),
            builder: (context, snapshot) {
              if (snapshot.hasError ||
                  snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.data == null) {
                return const SliverToBoxAdapter(child: CardLoading());
              }

              return DashboardCard(
                finance: snapshot.data!,
              );
            },
          ),

          // Gráfico em pizza de gastos por categoria
          StreamBuilder<List<CategorySummary>>(
            stream: ServiceLocator.categoryRepository.watchExpensesByCategory(),

            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SliverToBoxAdapter(child: CardLoading());
              }

              return ExpenseByCategoryChart(
                summary: snapshot.data!,
              );
            },
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
            allowDeletion: false,
            filter: TransactionFilter(
              startDate: DateTime.now().subtract(Duration(days: 7)),
            ),
          ),
        ],
      ),
    );
  }
}
