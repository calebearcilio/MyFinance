import 'package:flutter/material.dart';
import 'package:myfinance_app/presentation/components/app/app_scaffold.dart';
import 'package:myfinance_app/presentation/components/category/category_form_modal.dart';
import 'package:myfinance_app/presentation/components/category/category_list.dart';
import 'package:myfinance_app/presentation/components/transaction/transaction_list.dart';
import 'package:myfinance_app/models/category.dart';
import 'package:myfinance_app/models/transaction.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String selectedCategoryId = "all";

  void _createCategory(
    BuildContext ctx,
  ) {
    showModalBottomSheet(
      backgroundColor: Theme.of(ctx).colorScheme.outline,
      context: ctx,
      builder: (ctx) {
        return CategoryFormModal();
      },
    );
  }

  void _deleteCategory(BuildContext ctx, Category cat) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Excluir Cagegoria '${cat.name}' ?"),
          content: Text(
            "Tem certeza que deseja deletar esta categoria ?",
          ),
          actions: [
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Excluir",
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              onPressed: () {
                // Lógica de exclusão
                print("Deletando categoria '${cat.name}'");
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
              onCreateCategory: _createCategory,
              onDeleteCategory: _deleteCategory,
            ),

            TransactionList(
              transactions: filtered,
              categories: defaultCategries,
            ),
          ],
        ),
      ),
    );
  }
}
