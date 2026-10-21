import 'package:flutter/foundation.dart';
import 'package:my_finance/features/filters/domain/models/category_filter.dart';
import 'package:my_finance/features/filters/domain/models/transaction_filter.dart';

class FilterProvider with ChangeNotifier {
  TransactionFilter _transactionFilter = TransactionFilter();
  CategoryFilter _categoryFilter = CategoryFilter();

  TransactionFilter get transactionFilter => _transactionFilter;
  CategoryFilter get categoryFilter => _categoryFilter;

  void updateTransactionFilter(TransactionFilter newTransactionFilter) {
    _transactionFilter = newTransactionFilter;
    notifyListeners();
  }

  void updateCategoryFilter(CategoryFilter newCategoryFilter) {
    _categoryFilter = newCategoryFilter;
    notifyListeners();
  }

  void selectCategoryForTransactions(String? categoryId) {
    if (categoryId == null) {
      _categoryFilter = _categoryFilter.copyWith(clearCategorySelectedId: true);
      _transactionFilter = _transactionFilter.copyWith(clearCategoryId: true);
    } else {
      _categoryFilter = _categoryFilter.copyWith(
        categorySelectedId: categoryId,
      );
      _transactionFilter = _transactionFilter.copyWith(categoryId: categoryId);
    }
    notifyListeners();
  }
}
