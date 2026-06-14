import 'package:myfinance_app/core/database/app_database.dart';
import 'package:myfinance_app/core/repositories/category_repository.dart';
import 'package:myfinance_app/core/repositories/transaction_repository.dart';

/// Fornece acesso único aos repositórios
abstract final class ServiceLocator {
  static late AppDatabase _database;
  static late CategoryRepository _categoryRepository;
  static late TransactionRepository _transactionRepository;

  /// Inicializa todos os serviços
  static Future<void> init() async {
    _database = AppDatabase();
    _categoryRepository = CategoryRepository(_database);
    _transactionRepository = TransactionRepository(_database);
  }

  /// Obtém instância do banco de dados
  static AppDatabase get database => _database;

  /// Obtém instância do CategoryRepository
  static CategoryRepository get categoryRepository => _categoryRepository;

  /// Obtém instância do TransactionRepository
  static TransactionRepository get transactionRepository =>
      _transactionRepository;
}
