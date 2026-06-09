import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/material.dart' hide Table, Column;
import 'package:myfinance_app/core/database/converters/color_converter.dart';
import 'package:myfinance_app/core/database/converters/icon_converter.dart';
import 'package:myfinance_app/core/database/daos/category_dao.dart';
import 'package:myfinance_app/core/database/daos/transaction_dao.dart';
import 'package:myfinance_app/core/database/tables/category_table.dart';
import 'package:myfinance_app/core/database/tables/transaction_table.dart';
import 'package:myfinance_app/core/models/category/category.dart';
import 'package:myfinance_app/core/models/transaction/transaction.dart';
import 'package:myfinance_app/core/seed/categories_default.dart';
import 'package:myfinance_app/core/seed/dummy_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

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
  MigrationStrategy get migration => MigrationStrategy(
  onCreate: (Migrator m) async {
    await m.createAll();
    await _onCreate();
  },

  onUpgrade: (Migrator m, int from, int to) async {
    // futuras migrações
  },
);

  @override
  int get schemaVersion => 1;

  Future<void> resetDatabase() async {
    await delete(transactions).go();
    await delete(categories).go();
    await _onCreate();
  }

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
}
