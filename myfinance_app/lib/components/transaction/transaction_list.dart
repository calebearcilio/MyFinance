import 'package:flutter/material.dart';
import 'package:myfinance_app/components/transaction/transaction_item.dart';
import 'package:myfinance_app/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({super.key, required this.transactions});

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
            itemBuilder: (context, index) =>
                TransactionItem(transaction: transactions[index]),
          );
  }
}
