import 'package:flutter/material.dart';
import 'package:myfinance_app/presentation/components/app/app_scaffold.dart';
import 'package:myfinance_app/presentation/components/charts/home_chart.dart';
import 'package:myfinance_app/presentation/components/home/home_card.dart';
import 'package:myfinance_app/domain/category/category.dart';
import 'package:myfinance_app/domain/transaction/transaction.dart';
import 'package:myfinance_app/data/services_locator.dart';
import 'package:myfinance_app/presentation/components/transaction/transaction_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _transactionRepository = ServiceLocator.transactionRepository;
  final _categoryRepository = ServiceLocator.categoryRepository;

  void _loadData() async {}

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "DashBoard",
      body: CustomScrollView(
        slivers: [
          // Card de resumo
          SliverToBoxAdapter(
            child: StreamBuilder<double>(
              stream: _transactionRepository.watchAllTransactions().asyncMap((
                _,
              ) async {
                final revenue = await _transactionRepository.getTotalAmount(
                  type: TransactionType.income,
                );
                final expense = await _transactionRepository.getTotalAmount(
                  type: TransactionType.expense,
                );
                return revenue - expense;
              }),
              builder: (context, snapshot) {
                final balance = snapshot.data ?? 0.0;
                return HomeCard(
                  value: balance,
                  revenue: 0, // Será calculado quando implementar
                  expense: 0, // Será calculado quando implementar
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: HomeChart(),
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
          StreamBuilder<List<Transaction>>(
            stream: _transactionRepository.watchRecentTransactions(7),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final transactions = snapshot.data ?? [];

              if (transactions.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(
                      "Nenhuma Transação Recente!",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                );
              }

              return StreamBuilder<List<Category>>(
                stream: _categoryRepository.watchAllCategories(),
                builder: (context, categorySnapshot) {
                  final categories = categorySnapshot.data ?? [];

                  return TransactionList(
                    transactions: transactions,
                    categories: categories,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

extension FirstWhereOrNullExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    try {
      return firstWhere(test);
    } catch (e) {
      return null;
    }
  }
}
