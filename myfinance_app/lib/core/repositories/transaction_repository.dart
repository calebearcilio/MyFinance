import 'package:drift/drift.dart';
import 'package:myfinance_app/core/database/app_database.dart';
import 'package:myfinance_app/core/database/dto/transaction_with_category.dart';
import 'package:myfinance_app/core/models/category.dart';
import 'package:myfinance_app/core/models/transaction.dart';

/// Repository para Transaction
/// Encapsula acesso aos dados e converte entre modelos Drift e domínio
class TransactionRepository {
  final AppDatabase _database;

  TransactionRepository(this._database);

  /// Converter TransactionWithCategory (Drift join) para Transaction (Domínio)
  Transaction _convertJoinedToDomain(TransactionWithCategory row) {
    final tr = row.transaction;
    final cat = row.category;

    return Transaction(
      id: tr.id,
      title: tr.title,
      description: tr.description,
      value: tr.value,
      date: tr.date,
      type: tr.type,
      category: Category(
        id: cat.id,
        name: cat.name,
        icon: cat.icon,
        color: cat.color,
        type: cat.type,
        isDefault: cat.isDefault,
      ),
    );
  }

  /// Converter Transaction (Domínio) para TransactionsCompanion (Drift)
  TransactionsCompanion _convertToDrift(Transaction transaction) {
    return TransactionsCompanion(
      id: Value(transaction.id),
      title: Value(transaction.title),
      description: Value(transaction.description),
      value: Value(transaction.value),
      date: Value(transaction.date),
      type: Value(transaction.type),
      categoryId: Value(transaction.category.id),
      // createdAt e updatedAt serão gerenciados pelo banco
    );
  }

  /// Helper: Enriquece transações com suas categorias
  Future<List<Transaction>> _enrichTransactionsWithCategories(
    List<TransactionData> transactions,
  ) async {
    final List<Transaction> enriched = [];
    
    for (final transaction in transactions) {
      final category = await _database.categoryDao.getCategoryById(
        transaction.categoryId,
      );
      
      if (category != null) {
        enriched.add(
          Transaction(
            id: transaction.id,
            title: transaction.title,
            description: transaction.description,
            value: transaction.value,
            date: transaction.date,
            type: transaction.type,
            category: Category(
              id: category.id,
              name: category.name,
              icon: category.icon,
              color: category.color,
              type: category.type,
              isDefault: category.isDefault,
            ),
          ),
        );
      }
    }
    
    return enriched;
  }
  

  /// Obtém todas as transações com suas categorias
  Future<List<Transaction>> getAllTransactions() async {
    final rows = await _database.transactionDao.getAllTransactionsWithCategory();
    return rows.map(_convertJoinedToDomain).toList();
  }

  /// Obtém uma transação pelo ID
  Future<Transaction?> getTransactionById(String id) async {
    final data = await _database.transactionDao.getTransactionById(id);
    return data != null ? _convertJoinedToDomain(data) : null;
  }

  /// Obtém transações por categoria
  Future<List<Transaction>> getTransactionsByCategory(String categoryId) async {
    final data = await _database.transactionDao.getTransactionsWithCategory(
      categoryId: categoryId,
    );
    return data.map(_convertJoinedToDomain).toList();
  }

  /// Obtém transações por tipo (com categoria)
  Future<List<Transaction>> getTransactionsByType(TransactionType type) async {
    // Melhor: Modificar o DAO para retornar com join
    // Solução temporária: buscar todas e filtrar
    final allTransactions = await getAllTransactions();
    return allTransactions
        .where((t) => t.type == type)
        .toList();
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
    // Buscar as categorias para cada transação
    return await _enrichTransactionsWithCategories(data);
  }

  /// Obtém transações recentes (últimos N dias)
  Future<List<Transaction>> getRecentTransactions(int days) async {
    final data = await _database.transactionDao.getRecentTransactions(days);
    return await _enrichTransactionsWithCategories(data);
  }


  /// Watch todas as transações (Reativo)
  Stream<List<Transaction>> watchAllTransactions() {
    return _database.transactionDao.watchAllTransactionsStream().map(
      (data) => data.map(_convertJoinedToDomain).toList(),
    );
  }

  /// Watch uma transação específica (Reativo)
  Stream<Transaction?> watchTransactionById(String id) {
    return _database.transactionDao.watchTransactionByIdStream(id).map(
      (data) => data != null ? _convertJoinedToDomain(data) : null,
    );
  }

  /// Cria uma nova transação
  Future<void> createTransaction(Transaction transaction) async {
    await _database.transactionDao.insertTransaction(
      _convertToDrift(transaction),
    );
  }

  /// Cria múltiplas transações
  Future<void> createTransactions(List<Transaction> transactions) async {
    final driftData = transactions.map(_convertToDrift).toList();
    await _database.transactionDao.insertTransactions(driftData);
  }

  /// Atualiza uma transação
  Future<bool> updateTransaction(Transaction transaction) async {
    return await _database.transactionDao.updateTransaction(
      _convertToDrift(transaction),
    );
  }

  /// Deleta uma transação
  Future<bool> deleteTransaction(String transactionId) async {
    return await _database.transactionDao.deleteTransaction(transactionId);
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
    return await _database.transactionDao.getTotalValue(
      type: type,
      categoryId: categoryId,
    );
  }

  /// Obtém resumo mensal
  Future<Map<String, double>> getMonthlySummary(DateTime month) async {
    final startDate = DateTime(month.year, month.month, 1);
    final endDate = DateTime(month.year, month.month + 1, 0);
    
    final transactions = await getTransactionsByDateRange(startDate, endDate);
    
    double income = 0;
    double expense = 0;
    
    for (final transaction in transactions) {
      if (transaction.type == TransactionType.income) {
        income += transaction.value;
      } else {
        expense += transaction.value;
      }
    }
    
    return {
      'income': income,
      'expense': expense,
      'balance': income - expense,
    };
  }
}