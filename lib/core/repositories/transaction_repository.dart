import 'package:drift/drift.dart';
import 'package:myfinance_app/core/database/app_database.dart';
import 'package:myfinance_app/core/database/dto/transaction_with_category.dart';
import 'package:myfinance_app/core/models/category/category.dart';
import 'package:myfinance_app/core/models/finance/finance.dart';
import 'package:myfinance_app/core/models/transaction/transaction.dart';
import 'package:myfinance_app/core/models/transaction/transaction_create.dart';
import 'package:myfinance_app/core/models/transaction/transaction_filter.dart';
import 'package:myfinance_app/core/models/transaction/transaction_update.dart';

/// Repository para Transaction
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

  List<Transaction> _convertToListDomain(List<TransactionWithCategory> rows) {
    return rows.map((row) => _convertJoinedToDomain(row)).toList();
  }

  /// Converter Transaction (Domínio) para TransactionsCompanion (Drift)
  TransactionsCompanion _convertToDrift(TransactionCreate transaction) {
    return TransactionsCompanion.insert(
      title: transaction.title,
      description: Value(transaction.description),
      value: transaction.value,
      date: transaction.date,
      type: transaction.type,
      categoryId: transaction.categoryId,
    );
  }

  TransactionsCompanion _convertFromUpdate(TransactionUpdate transaction) {
    return TransactionsCompanion(
      id: Value(transaction.id),
      title: Value(transaction.title),
      description: Value(transaction.description),
      value: Value(transaction.value),
      date: Value(transaction.date),
      type: Value(transaction.type),
      categoryId: Value(transaction.categoryId),
    );
  }

  /// Obtém todas as transações com filtros
  Future<List<Transaction>> getAll([
    TransactionFilter? filter,
  ]) async {
    // Se não há filtro, retorna todas
    if (filter == null || !filter.hasFilters) {
      final rows = await _database.transactionDao.getAllTransactions();
      return rows.map(_convertJoinedToDomain).toList();
    }

    // Aplicar filtros no DAO
    final rows = await _database.transactionDao.getTransactions(filter);
    return rows.map(_convertJoinedToDomain).toList();
  }

  Stream<List<Transaction>> watchAll([TransactionFilter? filter]) {
    if (filter == null || !filter.hasFilters) {
      return _database.transactionDao.watchAll().map(_convertToListDomain);
    }

    return _database.transactionDao
        .watchAllWithFilter(filter)
        .map((data) => data.map(_convertJoinedToDomain).toList());
  }

  /// Cria uma nova transação
  Future<bool> insert(TransactionCreate transaction) async {
    return await _database.transactionDao.insert(
      _convertToDrift(transaction),
    );
  }

  /// Cria múltiplas transações
  Future<bool> insertAll(List<TransactionCreate> transactions) async {
    final driftData = transactions.map(_convertToDrift).toList();
    return await _database.transactionDao.insertAll(driftData);
  }

  /// Atualiza uma transação
  Future<bool> update(TransactionUpdate transaction) async {
    return await _database.transactionDao.updateTransaction(
      _convertFromUpdate(transaction),
    );
  }

  /// Deleta uma transação
  Future<bool> delete(String transactionId) async {
    return await _database.transactionDao.deleteTransaction(transactionId);
  }

  /// Conta o número total de transações
  Future<int> countTransactions() {
    return _database.transactionDao.countTransactions();
  }

  /// Obtém o valor total de transações
  Future<double> getTotalValue({
    TransactionType? type,
    String? categoryId,
  }) async {
    return await _database.transactionDao.getTotalValue(
      type: type,
      categoryId: categoryId,
    );
  }

  Stream<Finance> wacthMonthlyFinance([DateTime? month]) {
    return _database.transactionDao.watchMonthlyFinance(month);
  }

  /// Obtém resumo mensal
  Future<Finance> getMonthlySummary([DateTime? month]) async {
    month ??= DateTime.now();

    final startDate = DateTime(month.year, month.month, 1);
    final endDate = DateTime(month.year, month.month + 1, 0);

    final transactions = await getAll(
      TransactionFilter(startDate: startDate, endDate: endDate),
    );

    double income = 0;
    double expense = 0;

    for (final transaction in transactions) {
      if (transaction.type == TransactionType.income) {
        income += transaction.value;
      } else {
        expense += transaction.value;
      }
    }

    return Finance(expense: expense, income: income);
  }
}
