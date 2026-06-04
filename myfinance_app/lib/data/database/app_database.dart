import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/material.dart' hide Table, Column;
import 'package:myfinance_app/data/database/converters/color_converter.dart';
import 'package:myfinance_app/data/database/converters/icon_converter.dart';
import 'package:myfinance_app/data/database/daos/category_dao.dart';
import 'package:myfinance_app/data/database/daos/transaction_dao.dart';
import 'package:myfinance_app/data/seed/categories_default.dart';
import 'package:myfinance_app/data/database/tables/category_table.dart';
import 'package:myfinance_app/data/database/tables/transaction_table.dart';
import 'package:myfinance_app/domain/models/category.dart';
import 'package:myfinance_app/domain/models/transaction.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
// import 'daos/category_dao.dart';
// import 'daos/transaction_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Categories,
    Transactions,
  ],
  daos: [
    TransactionDao,
    CategoryDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// Migration do esquema
  /// Para versão 1.0, apenas a criação inicial
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Migrations futuras serão adicionadas aqui
        // Exemplo para versão 2:
        // if (from == 1) {
        //   await m.addColumn(transactions, transactions.newColumn);
        // }
      },
    );
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: "myfinance.db",
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

  /// Inicia dados padrão se o banco estiver vazio
  Future<bool> seedInitialData([
    List<TransactionsCompanion>? transactions,
  ]) async {
    final categoryCount = await categoryDao.countCategories();

    if (categoryCount == 0) {
      final categoriesDefault = [
        ...CategoriesDefault.expenses,
        ...CategoriesDefault.income,
      ];

      await categoryDao.insertCategories(categoriesDefault);
      return true;
    }

    if (transactions != null) {
      final transactionCount = await transactionDao.countTransactions();
      if (transactionCount == 0) {
        await transactionDao.insertTransactions(transactions);
        return true;
      }
    }

    return false;
  }

  /*
  /// Deleta o banco de dados (útil para testes)
  Future<void> deleteDatabase() async {
    final file = File(
      p.join(
        (await getApplicationDocumentsDirectory()).path,
        'myfinance.db',
      ),
    );
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// Exporta dados (para backup/debug)
  Future<void> exportData() async {
    final categories = await categoryDao.getAllCategories();
    final transactions = await transactionDao.getAllTransactions();

    print('=== CATEGORIES ===');
    for (var cat in categories) {
      print(cat);
    }

    print('\n=== TRANSACTIONS ===');
    for (var tx in transactions) {
      print(tx);
    }
  }
*/
}
