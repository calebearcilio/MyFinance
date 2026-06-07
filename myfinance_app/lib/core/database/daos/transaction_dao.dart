import 'package:drift/drift.dart';
import 'package:myfinance_app/core/database/app_database.dart';
import 'package:myfinance_app/core/database/dto/transaction_with_category.dart';
import 'package:myfinance_app/core/database/tables/category_table.dart';
import 'package:myfinance_app/core/database/tables/transaction_table.dart';
import 'package:myfinance_app/core/models/transaction.dart';
part 'transaction_dao.g.dart';

/// DAO para operações com transações
@DriftAccessor(
  tables: [
    Categories,
    Transactions,
  ],
)
class TransactionDao extends DatabaseAccessor<AppDatabase>
    with _$TransactionDaoMixin {
  TransactionDao(super.db);

  /// Obtém todas as transações
  Future<List<TransactionWithCategory>> getAllTransactionsWithCategory() async {
    final query = select(transactions).join([
      innerJoin(
        categories,
        categories.id.equalsExp(
          transactions.categoryId,
        ),
      ),
    ]);

    final result = await query.get();

    return result.map((row) {
      return TransactionWithCategory(
        transaction: row.readTable(transactions),
        category: row.readTable(categories),
      );
    }).toList();
  }

  /// Obtém uma transação pelo ID
  Future<TransactionWithCategory?> getTransactionById(String id) async {
    final query = select(transactions).join([
      innerJoin(
        categories,
        categories.id.equalsExp(transactions.categoryId),
      ),
    ])..where(transactions.id.equals(id));

    final result = await query.get();

    if (result.isEmpty) return null;

    final row = result.first;
    return TransactionWithCategory(
      transaction: row.readTable(transactions),
      category: row.readTable(categories),
    );
  }

  /// Obtém transações por categoria ID
  Future<List<TransactionWithCategory>> getTransactionsWithCategory({
    String? categoryId,
  }) async {
    final query = select(transactions).join([
      innerJoin(
        categories,
        categories.id.equalsExp(
          transactions.categoryId,
        ),
      ),
    ]);

    if (categoryId != null) {
      query.where(
        transactions.categoryId.equals(categoryId),
      );
    }

    query.orderBy([
      OrderingTerm.desc(
        transactions.date,
      ),
    ]);

    final result = await query.get();

    return result.map((row) {
      return TransactionWithCategory(
        transaction: row.readTable(transactions),
        category: row.readTable(categories),
      );
    }).toList();
  }

  /// Obtém transações por tipo (income/expense)
  Future<List<TransactionData>> getTransactionsByType(String type) {
    return (select(transactions)
          ..where((t) => t.type.equals(type))
          ..orderBy([
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
          ]))
        .get();
  }

  /// Obtém transações em um intervalo de datas
  Future<List<TransactionData>> getTransactionsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) {
    return (select(transactions)
          ..where((t) => t.date.isBetweenValues(startDate, endDate))
          ..orderBy([
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
          ]))
        .get();
  }

  /// Obtém transações recentes (últimos N dias)
  Future<List<TransactionData>> getRecentTransactions(int days) {
    final startDate = DateTime.now().subtract(Duration(days: days));
    return getTransactionsByDateRange(startDate, DateTime.now());
  }

  /// Watch todas as transações (reativo)
  Stream<List<TransactionData>> watchAllTransactions() {
    return (select(transactions)..orderBy([
          (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
        ]))
        .watch();
  }

  /// Watch todas as transações com join (reativo)
  Stream<List<TransactionWithCategory>> watchAllTransactionsStream() {
    final query = select(transactions).join([
      innerJoin(
        categories,
        categories.id.equalsExp(transactions.categoryId),
      ),
    ]);

    query.orderBy([
      OrderingTerm.desc(transactions.date),
    ]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return TransactionWithCategory(
          transaction: row.readTable(transactions),
          category: row.readTable(categories),
        );
      }).toList();
    });
  }

  /// Watch uma transação específica com join (reativo)
  Stream<TransactionWithCategory?> watchTransactionByIdStream(String id) {
    final query = select(transactions).join([
      innerJoin(
        categories,
        categories.id.equalsExp(transactions.categoryId),
      ),
    ])..where(transactions.id.equals(id));

    return query.watch().map((rows) {
      if (rows.isEmpty) return null;
      final row = rows.first;
      return TransactionWithCategory(
        transaction: row.readTable(transactions),
        category: row.readTable(categories),
      );
    });
  }

  /// Watch uma transação específica (reativo)
  Stream<TransactionData?> watchTransactionById(String id) {
    return (select(
      transactions,
    )..where((t) => t.id.equals(id))).watchSingleOrNull();
  }

  /// Watch transações por categoria (reativo)
  Stream<List<TransactionData>> watchTransactionsByCategory(
    String categoryId,
  ) {
    return (select(transactions)
          ..where((t) => t.categoryId.equals(categoryId))
          ..orderBy([
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
          ]))
        .watch();
  }

  /// Watch transações por tipo (reativo)
  Stream<List<TransactionData>> watchTransactionsByType(String type) {
    return (select(transactions)
          ..where((t) => t.type.equals(type))
          ..orderBy([
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
          ]))
        .watch();
  }

  /// Watch transações recentes (reativo)
  Stream<List<TransactionData>> watchRecentTransactions(int days) {
    final startDate = DateTime.now().subtract(Duration(days: days));
    return (select(transactions)
          ..where((t) => t.date.isBetweenValues(startDate, DateTime.now()))
          ..orderBy([
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
          ]))
        .watch();
  }

  /// Insere uma nova transação
  Future<void> insertTransaction(TransactionsCompanion transaction) {
    return into(transactions).insert(transaction);
  }

  /// Insere múltiplas transações
  Future<void> insertTransactions(List<TransactionsCompanion> transactionList) {
    return batch((batch) {
      batch.insertAll(transactions, transactionList);
    });
  }

  /// Atualiza uma transação
  Future<bool> updateTransaction(TransactionsCompanion transaction) {
    return update(transactions).replace(transaction);
  }

  /// Deleta uma transação pelo ID
  Future<bool> deleteTransaction(String id) async {
    final result = await (delete(
      transactions,
    )..where((t) => t.id.equals(id))).go();
    return result > 0;
  }

  /// Deleta todas as transações de uma categoria
  /// (Usado quando uma categoria é deletada - mas com constraint não deve chegar aqui)
  Future<int> deleteTransactionsByCategory(String categoryId) {
    return (delete(
      transactions,
    )..where((t) => t.categoryId.equals(categoryId))).go();
  }

  /// Conta o número total de transações
  Future<int> countTransactions() {
    return transactions.count().getSingle();
  }

  /// Conta transações por categoria
  Future<int> countTransactionsByCategory(String categoryId) async {
    final countExp = transactions.id.count();

    final query =
        selectOnly(
            transactions,
          )
          ..addColumns([countExp])
          ..where(transactions.categoryId.equals(categoryId));

    final result = await query.getSingle();

    return result.read(countExp) ?? 0;
  }

  /// Conta transações por tipo
  Future<int> countTransactionsByType(String type) async {
    final countExp = transactions.id.count();

    final query =
        selectOnly(
            transactions,
          )
          ..addColumns([countExp])
          ..where(transactions.type.equals(type));

    final result = await query.getSingle();
    return result.read(countExp) ?? 0;
  }

  /// Obtém o valor total de transações
  Future<double> getTotalValue({
    TransactionType? type,
    String? categoryId,
  }) async {
    final sumExpression = transactions.value.sum();

    final query = selectOnly(transactions)..addColumns([sumExpression]);

    if (type != null) {
      query.where(transactions.type.equals(type.name));
    }
    if (categoryId != null) {
      query.where(transactions.categoryId.equals(categoryId));
    }

    // Retrieve the single result, safely defaulting to 0 if the sum is null
    final result = await query
        .map((row) => row.read(sumExpression))
        .getSingle();

    return (result ?? 0).toDouble();
  }
}
