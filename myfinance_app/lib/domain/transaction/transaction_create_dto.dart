import 'package:myfinance_app/domain/transaction/transaction.dart';

class TransactionCreateDto {
  final String title;
  final double value;
  final String? description;
  final DateTime date;
  final TransactionType type;
  final String categoryId;

  TransactionCreateDto({
    required this.title,
    required this.value,
    this.description,
    required this.date,
    required this.type,
    required this.categoryId,
  });

}
