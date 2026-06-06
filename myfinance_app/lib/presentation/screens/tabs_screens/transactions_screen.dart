import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myfinance_app/domain/transaction/transaction_update_dto.dart';
import 'package:myfinance_app/presentation/components/app/app_scaffold.dart';
import 'package:myfinance_app/presentation/components/category/category_form_modal.dart';
import 'package:myfinance_app/domain/category/category.dart';
import 'package:myfinance_app/domain/transaction/transaction.dart';
import 'package:myfinance_app/data/services_locator.dart';
import 'package:myfinance_app/presentation/components/category/category_list.dart';
import 'package:myfinance_app/presentation/components/shared/loading_component.dart';
import 'package:myfinance_app/presentation/components/transaction/transaction_form.dart';
import 'package:myfinance_app/presentation/components/transaction/transaction_list.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final _categoryRepository = ServiceLocator.categoryRepository;
  final _transactionRepository = ServiceLocator.transactionRepository;
  String _selectedCategoryId = "all";
  bool _isLoading = true;
  List<Transaction> _filteredTransactions = [];
  List<Category> _categories = [];

  Future<void> _loadData() async {
    final categoriesDB = await _categoryRepository.getAllCategories();
    await Future.delayed(Duration(milliseconds: 1500));
    _categories = categoriesDB;
    _filterTransactions(_selectedCategoryId);
  }

  /// Filtra as transações por [categoryId], mas se o usuário tocar novamente na mesma categoria, o filtro retorna todas as transações
  void _filterTransactions(String categoryId) async {
    setState(() => _isLoading = true);

    if (_selectedCategoryId == categoryId) {
      _selectedCategoryId = "all";
      _filteredTransactions = await _transactionRepository.getAllTransactions();
    } else {
      _selectedCategoryId = categoryId;
      _filteredTransactions = await _transactionRepository
          .getTransactionsByCategory(_selectedCategoryId);
    }

    setState(() => _isLoading = false);
  }

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

  void _createTransaction(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => TransactionForm(),
    );

    if (!mounted) return;

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          result == true ? "Transação salca com sucesso" : "Operação cancelada",
        ),
      ),
    );

    Fluttertoast.showToast(msg: "TEste");
  }

  void _editTransaction(BuildContext context, Transaction transaction) {}

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Transações",
      onRefreshBody: _loadData,
      body: CustomScrollView(
        slivers: [
          CategoryList(
            categories: _categories,
            selectedCategoryId: _selectedCategoryId,
            onCreateCategory: _createCategory,
            onDeleteCategory: (p0, p1) {},
            onCategotyTap: _filterTransactions,
          ),
          _isLoading
              ? SliverFillRemaining(child: LoadingComponent())
              : TransactionList(
                  transactions: _filteredTransactions,
                  categories: _categories,
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createTransaction(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

/*

  

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
*/
