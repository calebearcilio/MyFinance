import 'package:drift/drift.dart';
import 'package:myfinance_app/data/database/app_database.dart';
import 'package:myfinance_app/domain/transaction/transaction.dart';

/// Repository para Transaction
/// Encapsula acesso aos dados e converte entre modelos Drift e domínio
class TransactionRepository {
  final AppDatabase _database;

  TransactionRepository(this._database);

  /// Converter TransactionData (Drift) para Transaction (Domínio)
  Transaction _convertToDomain(TransactionData data) {
    return Transaction.fromDriftData(
      id: data.id,
      title: data.title,
      description: data.description,
      value: data.value,
      date: data.date,
      type: data.type,
      categoryId: data.categoryId,
    );
  }

  /// Converter Transaction (Domínio) para TransactionData (Drift)
  TransactionsCompanion _convertToDrift(Transaction transaction) {
    return TransactionsCompanion(
      title: Value(transaction.title),
      description: Value(transaction.description),
      value: Value(transaction.value),
      date: Value(transaction.date),
      type: Value(transaction.type),
      categoryId: Value(transaction.categoryId),
    );
  }

  /// Obtém todas as transações
  Future<List<Transaction>> getAllTransactions() async {
    final data = await _database.transactionDao.getAllTransactions();
    return data.map(_convertToDomain).toList();
  }

  /// Obtém uma transação pelo ID
  Future<Transaction?> getTransactionById(String id) async {
    final data = await _database.transactionDao.getTransactionById(id);
    return data != null ? _convertToDomain(data) : null;
  }

  /// Obtém transações por categoria
  Future<List<Transaction>> getTransactionsByCategory(String categoryId) async {
    final data = await _database.transactionDao.getTransactionsByCategory(
      categoryId,
    );
    return data.map(_convertToDomain).toList();
  }

  /// Obtém transações por tipo
  Future<List<Transaction>> getTransactionsByType(
    TransactionType type,
  ) async {
    final data = await _database.transactionDao.getTransactionsByType(
      type.name,
    );
    return data.map(_convertToDomain).toList();
  }

  /// Obtém transações em um intervalo de datas
  Future<List<Transaction>> getTransactionsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final data = await _database.transactionDao.getTransactionsByDateRange(
      startDate,
      endDate,
    );
    return data.map(_convertToDomain).toList();
  }

  /// Obtém transações recentes (últimos N dias)
  Future<List<Transaction>> getRecentTransactions(int days) async {
    final data = await _database.transactionDao.getRecentTransactions(days);
    return data.map(_convertToDomain).toList();
  }

  /// Watch todas as transações (Reativo)
  Stream<List<Transaction>> watchAllTransactions() {
    return _database.transactionDao.watchAllTransactions().map(
      (data) => data.map(_convertToDomain).toList(),
    );
  }

  /// Watch uma transação específica (Reativo)
  Stream<Transaction?> watchTransactionById(String id) {
    return _database.transactionDao
        .watchTransactionById(id)
        .map((data) => data != null ? _convertToDomain(data) : null);
  }

  /// Watch transações por categoria (Reativo)
  Stream<List<Transaction>> watchTransactionsByCategory(
    String categoryId,
  ) {
    return _database.transactionDao
        .watchTransactionsByCategory(categoryId)
        .map((data) => data.map(_convertToDomain).toList());
  }

  /// Watch transações por tipo (Reativo)
  Stream<List<Transaction>> watchTransactionsByType(TransactionType type) {
    return _database.transactionDao
        .watchTransactionsByType(type.name)
        .map((data) => data.map(_convertToDomain).toList());
  }

  /// Watch transações recentes (Reativo)
  Stream<List<Transaction>> watchRecentTransactions(int days) {
    return _database.transactionDao
        .watchRecentTransactions(days)
        .map(
          (data) => data.map(_convertToDomain).toList(),
        );
  }

  /// Cria uma nova transação
  Future<void> createTransaction(Transaction transaction) async {
    return _database.transactionDao.insertTransaction(
      _convertToDrift(transaction),
    );
  }

  /// Cria múltiplas transações
  Future<void> createTransactions(List<Transaction> transactions) async {
    final driftData = transactions.map(_convertToDrift).toList();
    return _database.transactionDao.insertTransactions(driftData);
  }

  /// Atualiza uma transação
  Future<bool> updateTransaction(Transaction transaction) async {
    return _database.transactionDao.updateTransaction(
      _convertToDrift(transaction),
    );
  }

  /// Deleta uma transação
  Future<bool> deleteTransaction(String transactionId) async {
    return _database.transactionDao.deleteTransaction(transactionId);
  }

  /// Conta o número total de transações
  Future<int> countTransactions() {
    return _database.transactionDao.countTransactions();
  }

  /// Conta transações por categoria
  Future<int> countTransactionsByCategory(String categoryId) {
    return _database.transactionDao.countTransactionsByCategory(categoryId);
  }

  /// Conta transações por tipo
  Future<int> countTransactionsByType(TransactionType type) {
    return _database.transactionDao.countTransactionsByType(type.name);
  }

  /// Obtém o valor total de transações
  Future<double> getTotalAmount({
    TransactionType? type,
    String? categoryId,
  }) async {
    final value = await _database.transactionDao.getTotalValue(
      type: type,
      categoryId: categoryId,
    );
    return value;
  }
}
