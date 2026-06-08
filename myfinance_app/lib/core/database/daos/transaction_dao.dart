import 'package:drift/drift.dart';
import 'package:myfinance_app/core/database/app_database.dart';
import 'package:myfinance_app/core/database/dto/transaction_with_category.dart';
import 'package:myfinance_app/core/database/tables/category_table.dart';
import 'package:myfinance_app/core/database/tables/transaction_table.dart';
import 'package:myfinance_app/core/models/finance/finance.dart';
import 'package:myfinance_app/core/models/transaction/transaction.dart';
import 'package:myfinance_app/core/models/transaction/transaction_filter.dart';
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

  /// Helper para converter [TransactionData] em [TransactionWithCategory]
  List<TransactionWithCategory> _convertToListDto(List<TypedResult> rows) {
    return rows
        .map(
          (row) => TransactionWithCategory(
            transaction: row.readTable(transactions),
            category: row.readTable(categories),
          ),
        )
        .toList();
  }

  /// Todas as transações usando filtro
  Future<List<TransactionWithCategory>> getTransactions(
    TransactionFilter filter,
  ) async {
    final query = select(transactions).join([
      innerJoin(
        categories,
        categories.id.equalsExp(transactions.categoryId),
      ),
    ]);

    // Tipo
    if (filter.type != null) {
      query.where(
        transactions.type.equals(
          filter.type!.name,
        ),
      );
    }

    // Categoria
    if (filter.categoryId != null) {
      query.where(
        transactions.categoryId.equals(
          filter.categoryId!,
        ),
      );
    }

    // Categoria
    if (filter.transactionId != null) {
      query.where(
        transactions.id.equals(
          filter.transactionId!,
        ),
      );
    }

    // Período
    if (filter.startDate != null && filter.endDate != null) {
      query.where(
        transactions.date.isBetweenValues(
          filter.startDate!,
          filter.endDate!,
        ),
      );
    } else if (filter.startDate != null) {
      query.where(
        transactions.date.isBiggerOrEqualValue(
          filter.startDate!,
        ),
      );
    } else if (filter.endDate != null) {
      query.where(
        transactions.date.isSmallerOrEqualValue(
          filter.endDate!,
        ),
      );
    }

    // Valor mínimo
    if (filter.minValue != null) {
      query.where(
        transactions.value.isBiggerOrEqualValue(
          filter.minValue!,
        ),
      );
    }

    // Valor máximo
    if (filter.maxValue != null) {
      query.where(
        transactions.value.isSmallerOrEqualValue(
          filter.maxValue!,
        ),
      );
    }

    // Busca textual
    if (filter.searchTerm != null && filter.searchTerm!.trim().isNotEmpty) {
      final search = filter.searchTerm!.trim();
      query.where(
        transactions.title.like("%$search%") |
            transactions.description.like("%$search%"),
      );
    }

    // Ordenação
    query.orderBy([
      OrderingTerm.desc(
        transactions.date,
      ),
    ]);

    // Paginação
    if (filter.limit != null) {
      query.limit(
        filter.limit!,
        offset: filter.offset ?? 0,
      );
    }

    final result = await query.get();

    return _convertToListDto(result);
  }

  /// Obtém todas as transações sem filtragem
  Future<List<TransactionWithCategory>> getAllTransactions() async {
    final query = select(transactions).join([
      innerJoin(
        categories,
        categories.id.equalsExp(transactions.categoryId),
      ),
    ])..orderBy([OrderingTerm.desc(transactions.date)]);

    final result = await query.get();
    return _convertToListDto(result);
  }

  Stream<List<TransactionWithCategory>> watchAll() {
    final query = select(transactions).join([
      innerJoin(
        categories,
        categories.id.equalsExp(transactions.categoryId),
      ),
    ])..orderBy([OrderingTerm.desc(transactions.date)]);

    return query.watch().map(_convertToListDto);
  }

  /// Watch todas as transações com join (reativo) - VERSÃO CORRETA COM JOIN
  Stream<List<TransactionWithCategory>> watchAllWithFilter(
    TransactionFilter filter,
  ) {
    final query = select(transactions).join([
      innerJoin(
        categories,
        categories.id.equalsExp(
          transactions.categoryId,
        ),
      ),
    ]);

    // Tipo
    if (filter.type != null) {
      query.where(
        transactions.type.equals(
          filter.type!.name,
        ),
      );
    }

    // Categoria
    if (filter.categoryId != null) {
      query.where(
        transactions.categoryId.equals(
          filter.categoryId!,
        ),
      );
    }

    // Transação
    if (filter.transactionId != null) {
      query.where(
        transactions.id.equals(
          filter.transactionId!,
        ),
      );
    }

    // Período
    if (filter.startDate != null && filter.endDate != null) {
      query.where(
        transactions.date.isBetweenValues(
          filter.startDate!,
          filter.endDate!,
        ),
      );
    } else if (filter.startDate != null) {
      query.where(
        transactions.date.isBiggerOrEqualValue(
          filter.startDate!,
        ),
      );
    } else if (filter.endDate != null) {
      query.where(
        transactions.date.isSmallerOrEqualValue(
          filter.endDate!,
        ),
      );
    }

    // Valor mínimo
    if (filter.minValue != null) {
      query.where(
        transactions.value.isBiggerOrEqualValue(
          filter.minValue!,
        ),
      );
    }

    // Valor máximo
    if (filter.maxValue != null) {
      query.where(
        transactions.value.isSmallerOrEqualValue(
          filter.maxValue!,
        ),
      );
    }

    // Busca textual
    if (filter.searchTerm != null && filter.searchTerm!.trim().isNotEmpty) {
      final search = filter.searchTerm!.trim();

      query.where(
        transactions.title.like('%$search%') |
            transactions.description.like('%$search%'),
      );
    }

    query.orderBy([
      OrderingTerm.desc(
        transactions.date,
      ),
    ]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return TransactionWithCategory(
          transaction: row.readTable(
            transactions,
          ),
          category: row.readTable(
            categories,
          ),
        );
      }).toList();
    });
  }

  /// Insere uma nova transação
  Future<bool> insert(TransactionsCompanion transaction) async {
    final result = await into(transactions).insert(transaction);
    return result > 0;
  }

  /// Insere múltiplas transações
  Future<bool> insertAll(
    List<TransactionsCompanion> transactionList,
  ) async {
    try {
      await batch((batch) {
        batch.insertAll(transactions, transactionList);
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Atualiza uma transação
  Future<bool> updateTransaction(TransactionsCompanion transaction) async {
    final result = await (update(
      transactions,
    )..where((t) => t.id.equals(transaction.id.value))).write(transaction);
    return result > 0;
  }

  /// Deleta uma transação pelo ID
  Future<bool> deleteTransaction(String transactionId) async {
    final result = await (delete(
      transactions,
    )..where((t) => t.id.equals(transactionId))).go();
    return result > 0;
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

  Stream<Finance> watchMonthlyFinance([DateTime? month]) {
    month ??= DateTime.now();

    final start = DateTime(month.year, month.month);
    final end = DateTime(month.year, month.month + 1);

    return select(transactions).watch().map((rows) {
      double income = 0;
      double expense = 0;

      for (final tr in rows) {
        if (tr.date.isBefore(start) || tr.date.isAfter(end)) {
          continue;
        }

        if (tr.type == TransactionType.income) {
          income += tr.value;
        } else {
          expense += tr.value;
        }
      }

      return Finance(
        income: income,
        expense: expense,
      );
    });
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

    final result = await query.getSingle();
    return result.read(sumExpression) ?? 0.0;
  }
}
