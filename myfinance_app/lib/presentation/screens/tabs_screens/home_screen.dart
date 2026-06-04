import 'package:flutter/material.dart';
import 'package:myfinance_app/presentation/components/app/app_scaffold.dart';
import 'package:myfinance_app/presentation/components/charts/home_chart.dart';
import 'package:myfinance_app/presentation/components/home/home_card.dart';
import 'package:myfinance_app/presentation/components/transaction/transaction_list.dart';
import 'package:myfinance_app/domain/models/category.dart';
import 'package:myfinance_app/domain/models/transaction.dart';
import 'package:myfinance_app/data/services_locator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _transactionRepository = ServiceLocator.transactionRepository;
  final _categoryRepository = ServiceLocator.categoryRepository;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "DashBoard",
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
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
              child: Text("Transações recentes"),
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

                    return SliverList.builder(
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        final tr = transactions[index];
                        final category = categories.firstWhereOrNull(
                          (cat) => cat.id == tr.categoryId,
                        );

                        if (category == null) return const SizedBox();

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: category.color,
                            child: Icon(
                              category.icon,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(tr.title),
                          subtitle: Text(category.name),
                          trailing: Text(
                            'R\$ ${tr.value.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: tr.type == TransactionType.income
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
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
