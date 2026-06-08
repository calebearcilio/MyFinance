import 'package:myfinance_app/core/models/transaction/transaction.dart';

class TransactionUpdate {
  final String id;
  final String title;
  final double value;
  final String description;
  final DateTime date;
  final TransactionType type;
  final String categoryId;

  TransactionUpdate({
    required this.id,
    required this.title,
    required this.value,
    required this.description,
    required this.date,
    required this.type,
    required this.categoryId,
  });
}
