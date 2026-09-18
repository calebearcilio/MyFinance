import 'package:myfinance_app/core/models/transaction/transaction.dart';

class TransactionCreate {
  final String title;
  final double value;
  final String? description;
  final DateTime date;
  final TransactionType type;
  final String categoryId;

  TransactionCreate({
    required this.title,
    required this.value,
    required this.description,
    required this.date,
    required this.type,
    required this.categoryId,
  });
}
