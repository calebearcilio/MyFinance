import 'package:flutter/material.dart';
import 'package:myfinance_app/presentation/components/transaction/transaction_item.dart';
import 'package:myfinance_app/models/category.dart';
import 'package:myfinance_app/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Category> categories;
  final List<Transaction> transactions;

  const TransactionList({
    super.key,
    required this.transactions,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? SliverFillRemaining(
            child: Center(
              child: Text(
                "Nenhuma Transação Encontrada!",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          )
        : SliverList.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final tr = transactions[index];
              return TransactionItem(
                transaction: tr,
                category: defaultCategries.firstWhere(
                  (cat) => cat.id == tr.categoryId,
                ),
                onTap: () =>
                    print("Mostrar informações da transação: ${tr.title}"),
                onLongPress: () => print("Editando transação: ${tr.title}"),
              );
            },
          );
  }
}
