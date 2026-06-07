import 'package:myfinance_app/core/database/app_database.dart';

class TransactionWithCategory {
  final TransactionData transaction;
  final CategoryData category;

  TransactionWithCategory({
    required this.transaction,
    required this.category,
  });
}
