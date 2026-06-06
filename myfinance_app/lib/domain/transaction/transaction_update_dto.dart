import 'package:myfinance_app/domain/transaction/transaction.dart';

class TransactionUpdateDto {
  final String id;
  final String? title;
  final double? value;
  final String? description;
  final DateTime? date;
  final TransactionType? type;
  final String? categoryId;

  TransactionUpdateDto({
    required this.id,
    this.title,
    this.value,
    this.description,
    this.date,
    this.type,
    this.categoryId,
  });
}
