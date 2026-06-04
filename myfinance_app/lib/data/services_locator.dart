import 'package:myfinance_app/data/database/app_database.dart';
import 'package:myfinance_app/domain/models/transaction.dart';
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
  static Future<void> init([List<Transaction>? transactions]) async {
    _database = AppDatabase();
    _categoryRepository = CategoryRepository(_database);
    _transactionRepository = TransactionRepository(_database);

    // Inicia dados padrão
    await _categoryRepository.seedInitialData();
    // Inserir transações fictícias
    await _transactionRepository.seedInitialData();
  }

  /// Obtém instância do banco de dados
  static AppDatabase get database => _database;

  /// Obtém instância do CategoryRepository
  static CategoryRepository get categoryRepository => _categoryRepository;

  /// Obtém instância do TransactionRepository
  static TransactionRepository get transactionRepository =>
      _transactionRepository;
}
