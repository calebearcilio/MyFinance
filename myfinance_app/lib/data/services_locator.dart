import 'package:myfinance_app/data/database/app_database.dart';
import 'package:myfinance_app/domain/category/category.dart';
import 'package:myfinance_app/domain/transaction/transaction.dart';
import 'package:myfinance_app/data/repositories/category_repository.dart';
import 'package:myfinance_app/data/repositories/transaction_repository.dart';

/// Service Locator - Fornece acesso único aos repositórios
/// Implementado como singleton para simplificar a arquitetura
class ServiceLocator {
  static late AppDatabase _database;
  static late CategoryRepository _categoryRepository;
  static late TransactionRepository _transactionRepository;

  /// Inicializa todos os serviços
  /// Deve ser chamado em main.dart antes de executar o app
  static Future<void> init([
    List<Transaction>? transactions,
    List<Category>? categories,
  ]) async {
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
