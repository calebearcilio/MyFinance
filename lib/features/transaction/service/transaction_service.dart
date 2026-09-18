import 'package:myfinance_app/core/models/transaction/transaction.dart';
import 'package:myfinance_app/core/models/transaction/transaction_create.dart';
import 'package:myfinance_app/core/models/transaction/transaction_update.dart';
import 'package:myfinance_app/core/services/services_locator.dart';

class TransactionService {
  static Future<void> create(
    TransactionCreate transaction,
  ) async {
    await ServiceLocator.transactionRepository.insert(
      transaction,
    );
  }

  static Future<void> delete(
    Transaction transaction,
  ) async {
    await ServiceLocator.transactionRepository.delete(
      transaction.id,
    );
  }
  
  static Future<void> update(
    TransactionUpdate transaction,
  ) async {
    await ServiceLocator.transactionRepository.update(
      transaction,
    );
  }
}