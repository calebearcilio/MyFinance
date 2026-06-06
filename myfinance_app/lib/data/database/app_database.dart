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
import 'package:myfinance_app/data/seed/dummy_data.dart';
import 'package:myfinance_app/domain/category/category.dart';
import 'package:myfinance_app/domain/transaction/transaction.dart';
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
      onCreate: (m) async {
        await m.createAll();
        _onCreate();
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

  /// Deleta o banco de dados (útil para testes)
  Future<void> resetDatabase() async {
    await delete(transactions).go();
    await delete(categories).go();
    await _onCreate();
  }

  Future<void> seedData() async {}

  Future<void> _onCreate() async {
    await batch(
      (batch) {
        batch.insertAll(
          categories,
          [
            ...CategoriesDefault.income,
            ...CategoriesDefault.expenses,
          ],
        );
        batch.insertAll(
          transactions,
          [
            ...DummyTransactions.income,
            ...DummyTransactions.expenses,
          ],
        );
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

  /*
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
