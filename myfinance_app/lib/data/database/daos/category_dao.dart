import 'package:drift/drift.dart';
import 'package:myfinance_app/data/database/app_database.dart';
import 'package:myfinance_app/data/database/tables/category_table.dart';
import 'package:myfinance_app/data/database/tables/transaction_table.dart';
part 'category_dao.g.dart';

/// DAO para operações com categorias
@DriftAccessor(
  tables: [
    Categories,
    Transactions,
  ],
)
class CategoryDao extends DatabaseAccessor<AppDatabase>
    with _$CategoryDaoMixin {
  CategoryDao(super.db);

  /// Obtém todas as categorias
  Future<List<CategoryData>> getAllCategories() {
    return select(categories).get();
  }

  /// Obtém uma categoria pelo ID
  Future<CategoryData?> getCategoryById(String id) {
    return (select(
      categories,
    )..where((c) => c.id.equals(id))).getSingleOrNull();
  }

  /// Obtém todas as categorias de um tipo específico
  Future<List<CategoryData>> getCategoriesByType(String type) {
    return (select(categories)..where((c) => c.type.equals(type))).get();
  }

  /// Watch todas as categorias (reativo)
  Stream<List<CategoryData>> watchAllCategories() {
    return select(categories).watch();
  }

  /// Watch uma categoria específica (reativo)
  Stream<CategoryData?> watchCategoryById(String id) {
    return (select(
      categories,
    )..where((c) => c.id.equals(id))).watchSingleOrNull();
  }

  /// Watch categorias por tipo (reativo)
  Stream<List<CategoryData>> watchCategoriesByType(String type) {
    return (select(categories)..where((c) => c.type.equals(type))).watch();
  }

  /// Insere uma nova categoria
  Future<void> insertCategory(CategoriesCompanion category) {
    return into(categories).insert(category);
  }

  /// Insere múltiplas categorias
  Future<void> insertCategories(List<CategoriesCompanion> categoryList) {
    return batch((batch) {
      batch.insertAll(categories, categoryList);
    });
  }

  /// Atualiza uma categoria
  Future<bool> updateCategory(CategoriesCompanion category) {
    return update(categories).replace(category);
  }

  /// Deleta uma categoria pelo ID
  /// Retorna false se houver transações vinculadas (constraint)
  Future<bool> deleteCategory(String categoryId) async {
    final result = await (delete(
      categories,
    )..where((c) => c.id.equals(categoryId))).go();

    return result > 0;
  }

  /// Conta o número total de categorias
  Future<int> countCategories() async {
    final countExp = categories.id.count();

    final query = selectOnly(categories)..addColumns([countExp]);

    final result = await query.getSingle();

    return result.read(countExp) ?? 0;
  }

/*
  /// Verifica se uma categoria tem transações associadas
  Future<bool> hasDependentTransactions(String categoryId) async {
    final count = await countTransactionsByCategory(categoryId);
    return count > 0;
  }

  /// (Helper) Conta transações de uma categoria - requer acesso a outro DAO
  /// Este método será chamado do repository
  Future<int> countTransactionsByCategory(String categoryId) async {
    // Implementar no repository
    return 0;
  }
  */
}
