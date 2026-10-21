import 'package:flutter/material.dart';
import 'package:my_finance/features/category/data/repositories/category_repository.dart';
import 'package:my_finance/features/category/domain/entities/category_summary.dart';
import 'package:my_finance/features/charts/presentation/components/expense_by_category_chart.dart';
import 'package:my_finance/features/common/components/app_scaffold.dart';
import 'package:my_finance/features/dashboard/domain/entities/finance.dart';
import 'package:my_finance/features/dashboard/presentation/components/card_loading.dart';
import 'package:my_finance/features/dashboard/presentation/components/dashboard_card.dart';
import 'package:my_finance/features/filters/domain/models/transaction_filter.dart';
import 'package:my_finance/features/transaction/data/repositories/transaction_repository.dart';
import 'package:my_finance/features/transaction/presentation/components/transaction_list.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final transactionRepository = context.read<TransactionRepository>();
    final categoryRepository = context.read<CategoryRepository>();

    return AppScaffold(
      title: "DashBoard",
      body: CustomScrollView(
        slivers: [
          // Card de resumo do mês
          StreamBuilder<Finance>(
            stream: transactionRepository.watchMonthlyFinance(),
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
            stream: categoryRepository.watchExpensesByCategory(),

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
              initDate: DateTime.now().subtract(const Duration(days: 7)),
            ),
          ),
        ],
      ),
    );
  }
}
