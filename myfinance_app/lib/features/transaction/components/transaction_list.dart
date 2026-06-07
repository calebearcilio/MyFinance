import 'package:flutter/material.dart';
import 'package:myfinance_app/core/services/services_locator.dart';
import 'package:myfinance_app/features/common/components/loading_component.dart';
import 'package:myfinance_app/features/transaction/actions/transaction_actions.dart';
import 'package:myfinance_app/features/transaction/components/transaction_item.dart';
import 'package:myfinance_app/core/models/transaction.dart';
import 'package:myfinance_app/features/common/model/transaction_filter.dart';

class TransactionList extends StatefulWidget {
  final TransactionFilter filter;

  const TransactionList({super.key, required this.filter});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  bool loading = true;
  List<Transaction> transactions = [];

  void loadData() async {
    transactions = await ServiceLocator.transactionRepository
        .getAllTransactions();
    setState(() => loading = false);
  }

  @override
  void didUpdateWidget(covariant TransactionList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.filter != widget.filter) {
      loadData();
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingComponent()
        : transactions.isEmpty
        ? SliverFillRemaining(
            child: Center(
              child: Text(
                "Nenhuma Transação Cadastrada!",
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
                onTap: () => TransactionActions.view(context, tr),
                onLongPress: () => TransactionActions.delete(context, tr.id),
              );
            },
          );
  }
}
