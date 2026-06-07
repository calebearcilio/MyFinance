import 'package:flutter/material.dart';
import 'package:myfinance_app/features/category/components/category_list_filter.dart';
import 'package:myfinance_app/features/common/components/app_scaffold.dart';
import 'package:myfinance_app/features/transaction/actions/transaction_actions.dart';
import 'package:myfinance_app/features/transaction/components/transaction_list.dart';
import 'package:myfinance_app/features/common/model/transaction_filter.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsPage> {
  TransactionFilter filter = TransactionFilter(categoryId: "all");

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Transações",
      onRefreshBody: () async {},
      body: CustomScrollView(
        slivers: [
          CategoryListFilter(
            filter: filter,
          ),
          TransactionList(
            filter: filter,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => TransactionActions.create(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
