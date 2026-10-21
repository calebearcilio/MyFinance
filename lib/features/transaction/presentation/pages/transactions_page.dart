import 'package:flutter/material.dart';
import 'package:my_finance/features/category/presentation/components/category_list_filter.dart';
import 'package:my_finance/features/common/components/app_forms.dart';
import 'package:my_finance/features/common/components/app_scaffold.dart';
import 'package:my_finance/features/filters/domain/providers/filter_provider.dart';
import 'package:my_finance/features/transaction/presentation/components/transaction_form.dart';
import 'package:my_finance/features/transaction/presentation/components/transaction_list.dart';
import 'package:provider/provider.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsPage> {
  void _openFormModal() {
    showDialog<bool>(
      context: context,
      builder: (_) => const TransactionForm(mode: FormMode.create),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filter = Provider.of<FilterProvider>(context);

    return AppScaffold(
      title: "Transações",
      onRefreshBody: () async {
        setState(() {});
      },
      body: CustomScrollView(
        slivers: [
          CategoryListFilter(
            filter: filter.categoryFilter,
          ),

          TransactionList(
            filter: filter.transactionFilter,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openFormModal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
