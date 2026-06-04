import 'package:flutter/material.dart';
import 'package:myfinance_app/presentation/components/app/app_scaffold.dart';
import 'package:myfinance_app/presentation/components/category/category_form_modal.dart';
import 'package:myfinance_app/domain/models/category.dart';
import 'package:myfinance_app/domain/models/transaction.dart';
import 'package:myfinance_app/data/services_locator.dart';
import 'package:myfinance_app/presentation/components/category/category_list.dart';
import 'package:myfinance_app/presentation/components/transaction/transaction_list.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String selectedCategoryId = "all";

  final _categoryRepository = ServiceLocator.categoryRepository;
  final _transactionRepository = ServiceLocator.transactionRepository;

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
      context: ctx,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Excluir Categoria '${cat.name}' ?"),
          content: Text(
            "Tem certeza que deseja deletar esta categoria ?",
          ),
          actions: [
            TextButton(
              child: const Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Excluir",
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              onPressed: () async {
                final success = await _categoryRepository.deleteCategory(
                  cat.id,
                );

                if (!mounted) return;

                Navigator.of(context).pop();

                if (!success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Não é possível deletar uma categoria com transações vinculadas',
                      ),
                      duration: Duration(seconds: 3),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Categoria deletada com sucesso'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoryAll = Category(
      id: "all",
      name: "Todas",
      icon: Icons.category,
      color: Colors.blueAccent,
      type: .expense,
    );

    return AppScaffold(
      title: "Transações",
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: CustomScrollView(
          slivers: [
            // Categorias usando Stream
            StreamBuilder<List<Category>>(
              stream: _categoryRepository.watchAllCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final categories = snapshot.data ?? [];

                return CategoryList(
                  categories: [categoryAll, ...categories],
                  selectedCategoryId: selectedCategoryId,
                  onCreateCategory: _createCategory,
                  onDeleteCategory: _deleteCategory,
                  onCategotyTap: (id) =>
                      setState(() => selectedCategoryId = id),
                );
              },
            ),

            // Transações filtradas usando Stream
            StreamBuilder<List<Transaction>>(
              stream: selectedCategoryId == "all"
                  ? _transactionRepository.watchAllTransactions()
                  : _transactionRepository.watchTransactionsByCategory(
                      selectedCategoryId,
                    ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final transactions = snapshot.data ?? [];

                return StreamBuilder<List<Category>>(
                  stream: _categoryRepository.watchAllCategories(),
                  builder: (context, categorySnapshot) {
                    final categories = categorySnapshot.data ?? [];

                    return TransactionList(
                      transactions: transactions,
                      categories: categories,
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

/*
SliverList.builder(
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
                          onTap: () => print(
                            "Mostrar informações da transação: ${tr.title}",
                          ),
                          onLongPress: () =>
                              print("Editando transação: ${tr.title}"),
                        );
                      },
                    );
*/
