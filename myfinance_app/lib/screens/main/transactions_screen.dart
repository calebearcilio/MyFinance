import 'package:flutter/material.dart';
import 'package:myfinance_app/components/app/app_scaffold.dart';
import 'package:myfinance_app/components/category/category_list.dart';
import 'package:myfinance_app/components/transaction/transaction_list.dart';
import 'package:myfinance_app/models/category.dart';
import 'package:myfinance_app/models/transaction.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String selectedCategoryId = "all";

  @override
  Widget build(BuildContext context) {
    final filtered = selectedCategoryId == "all"
        ? dummyTransactions
        : dummyTransactions
              .where((t) => t.categoryId == selectedCategoryId)
              .toList();

    return AppScaffold(
      title: "Transações",
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: CustomScrollView(
          slivers: [
            CategoryList(
              categories: defaultCategries,
              selectedCategoryId: selectedCategoryId,
              onCategotyTap: (id) => setState(() => selectedCategoryId = id),
            ),

            TransactionList(transactions: filtered),
          ],
        ),
      ),
    );
  }
}
