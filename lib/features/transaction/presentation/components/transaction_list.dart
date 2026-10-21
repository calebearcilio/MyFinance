import 'package:flutter/material.dart';
import 'package:my_finance/features/common/components/app_forms.dart';
import 'package:my_finance/features/filters/domain/models/transaction_filter.dart';
import 'package:my_finance/features/transaction/data/repositories/transaction_repository.dart';
import 'package:my_finance/features/transaction/domain/entities/transaction.dart';
import 'package:my_finance/features/transaction/presentation/components/transaction_details.dart';
import 'package:my_finance/features/transaction/presentation/components/transaction_form.dart';
import 'package:my_finance/features/transaction/presentation/components/transaction_item.dart';
import 'package:provider/provider.dart';

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
  void _openModalView(BuildContext context, Transaction transaction) {
    showDialog<bool>(
      context: context,
      builder: (_) => TransactionDetails(transaction: transaction),
    );
  }

  void _openFormEdit(BuildContext context, Transaction transactionToEdit) {
    showDialog<bool>(
      context: context,
      builder: (_) => TransactionForm(
        transaction: transactionToEdit,
        mode: FormMode.edit,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final transactionRepository = context.read<TransactionRepository>();

    return StreamBuilder<List<Transaction>>(
      stream: transactionRepository.watchAll(widget.filter),
      initialData: const [],
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
          itemCount: transactions.length + 1,
          itemBuilder: (context, index) {
            if (index == transactions.length) {
              return const SizedBox(height: 50);
            }

            final tr = transactions[index];

            if (!widget.allowDeletion) {
              return TransactionItem(
                transaction: tr,
                onTap: () => _openModalView(context, tr),
                onLongPress: () => _openFormEdit(context, tr),
              );
            }

            return Dismissible(
              key: ValueKey(tr.id),
              background: Container(
                color: Colors.redAccent,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: const ListTile(
                  title: Text("Excluir Transação"),
                  trailing: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  leading: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
              onDismissed: (direction) => transactionRepository.delete(tr.id),
              child: TransactionItem(
                transaction: tr,
                onTap: () => _openModalView(context, tr),
                onLongPress: () => _openFormEdit(context, tr),
              ),
            );
          },
        );
      },
    );
  }
}
