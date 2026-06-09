import 'package:flutter/material.dart';
import 'package:myfinance_app/core/services/services_locator.dart';
import 'package:myfinance_app/features/transaction/actions/transaction_actions.dart';
import 'package:myfinance_app/features/transaction/components/transaction_item.dart';
import 'package:myfinance_app/core/models/transaction/transaction.dart';
import 'package:myfinance_app/core/models/transaction/transaction_filter.dart';
import 'package:myfinance_app/features/transaction/service/transaction_service.dart';

class TransactionList extends StatefulWidget {
  final TransactionFilter filter;
  final bool allowDeletion;

  const TransactionList({
    super.key,
    required this.filter,
    this.allowDeletion = true,
  });

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Transaction>>(
      stream: ServiceLocator.transactionRepository.watchAll(widget.filter),
      initialData: [],
      builder: (context, snapshot) {
        final transactions = snapshot.data ?? [];
        if (transactions.isEmpty) {
          return SliverFillRemaining(
            child: Center(
              child: Text(
                "Nenhuma Transação Cadastrada!",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          );
        }

        return SliverList.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final tr = transactions[index];

            if (!widget.allowDeletion) {
              return TransactionItem(
                transaction: tr,
                onTap: () => TransactionActions.openModalView(context, tr),
                onLongPress: () => TransactionActions.openFormEdit(context, tr),
              );
            }

            return Dismissible(
              key: ValueKey(tr),
              background: Container(
                color: Colors.redAccent,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: ListTile(
                  title: Text("Excluir Transação"),
                  trailing: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  leading: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
              onDismissed: (direction) => TransactionService.delete(tr),
              child: TransactionItem(
                transaction: tr,
                onTap: () => TransactionActions.openModalView(context, tr),
                onLongPress: () => TransactionActions.openFormEdit(context, tr),
              ),
            );
          },
        );
      },
    );
  }
}
