import 'package:myfinance_app/core/models/transaction/transaction.dart';

class TransactionFilter {
  final TransactionType? type;
  final String? categoryId;
  final String? transactionId;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? minValue;
  final double? maxValue;
  final String? searchTerm;
  final int? limit;
  final int? offset;

  TransactionFilter({
    this.type,
    this.categoryId,
    this.transactionId,
    this.startDate,
    this.endDate,
    this.minValue,
    this.maxValue,
    this.searchTerm,
    this.limit,
    this.offset,
  });

  /// Criar cópia com novos valores
  TransactionFilter copyWith({
    TransactionType? type,
    String? categoryId,
    DateTime? startDate,
    DateTime? endDate,
    double? minValue,
    double? maxValue,
    String? searchTerm,
    int? limit,
    int? offset,
  }) {
    return TransactionFilter(
      type: type ?? this.type,
      categoryId: categoryId ?? this.categoryId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      minValue: minValue ?? this.minValue,
      maxValue: maxValue ?? this.maxValue,
      searchTerm: searchTerm ?? this.searchTerm,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  TransactionFilter clearCategoryOnly() {
    return TransactionFilter(
      type: type,
      categoryId: null,
      startDate: startDate,
      endDate: endDate,
      minValue: minValue,
      maxValue: maxValue,
      searchTerm: searchTerm,
      limit: limit,
      offset: offset,
    );
  }

  /// Verificar se há algum filtro aplicado
  bool get hasFilters {
    return type != null ||
        categoryId != null ||
        startDate != null ||
        endDate != null ||
        minValue != null ||
        maxValue != null ||
        (searchTerm != null && searchTerm!.isNotEmpty);
  }
}
