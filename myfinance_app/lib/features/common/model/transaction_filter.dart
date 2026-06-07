import 'package:myfinance_app/core/models/transaction.dart';

class TransactionFilter {
  final String? categoryId;
  final TransactionType? type;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? searchText;

  const TransactionFilter({
    this.categoryId,
    this.type,
    this.startDate,
    this.endDate,
    this.searchText,
  });

  TransactionFilter copyWith({
    String? categoryId,
    TransactionType? type,
    DateTime? startDate,
    DateTime? endDate,
    String? searchText,
  }) {
    return TransactionFilter(
      categoryId: categoryId ?? this.categoryId,
      type: type ?? this.type,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      searchText: searchText ?? this.searchText,
    );
  }
}