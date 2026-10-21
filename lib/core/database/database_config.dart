import 'package:isar/isar.dart';
import 'package:my_finance/core/seed/categories_default.dart';
import 'package:my_finance/core/seed/dummy_data.dart';
import 'package:my_finance/features/category/data/models/category_model.dart';
import 'package:my_finance/features/transaction/data/models/transaction_model.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConfig {
  static Isar? _db;

  static Isar get instance {
    if (_db == null) {
      throw StateError(
        'DatabaseConfig.db deve ser inicializado antes de acessar DatabaseConfig.instance.',
      );
    }
    return _db!;
  }

  static Future<Isar> get db async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Isar> _initDB() async {
    final dir = await getApplicationDocumentsDirectory();

    final isar = await Isar.open(
      [
        CategoryModelSchema,
        TransactionModelSchema,
      ],
      directory: dir.path,
      name: "my-finance-db",
      inspector: true,
    );

    await _seedIfNeeded(isar);

    return isar;
  }

  static Future<void> _seedIfNeeded(Isar isar) async {
    final categoriesCount = await isar.categoryModels.count();
    if (categoriesCount > 0) return;

    await isar.writeTxn(() async {
      final categoryMap = <String, CategoryModel>{};

      for (final category in CategoriesDefault.all) {
        final model = CategoryModel().fromEntity(category);
        await isar.categoryModels.put(model);
        categoryMap[category.id] = model;
      }

      for (final transaction in DummyTransactions.all) {
        final model = TransactionModel().fromEntity(transaction);
        final categoryModel = categoryMap[transaction.category.id];
        model.category.value = categoryModel;
        await isar.transactionModels.put(model);
        await model.category.save();
      }
    });
  }
}
