import 'package:drift/drift.dart';
import 'package:myfinance_app/data/database/app_database.dart';
import 'package:myfinance_app/domain/category/category.dart';

/// Repository para Category
/// Encapsula acesso aos dados e converte entre modelos Drift e domínio
class CategoryRepository {
  final AppDatabase _database;

  CategoryRepository(this._database);

  /// Converter CategoryData (Drift) para Category (Domínio)
  Category _convertToDomain(CategoryData data) {
    return Category.fromDriftData(
      id: data.id,
      name: data.name,
      icon: data.icon,
      color: data.color,
      type: data.type,
    );
  }

  /// Converter Category (Domínio) para CategoryData (Drift)
  CategoriesCompanion _convertToDrift(Category category) {
    return CategoriesCompanion(
      id: Value(category.id),
      name: Value(category.name),
      icon: Value(category.icon),
      color: Value(category.color),
      type: Value(category.type),
      isDefault: Value(false),
      createdAt: Value(DateTime.now()),
    );
  }

  /// Obtém todas as categorias
  Future<List<Category>> getAllCategories() async {
    final data = await _database.categoryDao.getAllCategories();
    return data.map(_convertToDomain).toList();
  }

  /// Obtém uma categoria pelo ID
  Future<Category?> getCategoryById(String id) async {
    final data = await _database.categoryDao.getCategoryById(id);
    return data != null ? _convertToDomain(data) : null;
  }

  /// Obtém categorias por tipo
  Future<List<Category>> getCategoriesByType(CategoryType type) async {
    final data = await _database.categoryDao.getCategoriesByType(type.name);
    return data.map(_convertToDomain).toList();
  }

  /// Watch todas as categorias (Reativo)
  Stream<List<Category>> watchAllCategories() {
    return _database.categoryDao.watchAllCategories().map(
      (data) => data.map(_convertToDomain).toList(),
    );
  }

  /// Watch uma categoria específica (Reativo)
  Stream<Category?> watchCategoryById(String id) {
    return _database.categoryDao
        .watchCategoryById(id)
        .map((data) => data != null ? _convertToDomain(data) : null);
  }

  /// Watch categorias por tipo (Reativo)
  Stream<List<Category>> watchCategoriesByType(CategoryType type) {
    return _database.categoryDao
        .watchCategoriesByType(type.name)
        .map((data) => data.map(_convertToDomain).toList());
  }

  /// Cria uma nova categoria
  Future<void> createCategory(Category category) async {
    return _database.categoryDao.insertCategory(_convertToDrift(category));
  }

  /// Cria múltiplas categorias
  Future<void> createCategories(List<Category> categories) async {
    final driftData = categories.map(_convertToDrift).toList();
    return _database.categoryDao.insertCategories(driftData);
  }

  /// Atualiza uma categoria
  Future<bool> updateCategory(Category category) async {
    return _database.categoryDao.updateCategory(_convertToDrift(category));
  }

  /// Deleta uma categoria
  /// Retorna false se houver transações vinculadas
  Future<bool> deleteCategory(String categoryId) async {
    // Verificar se há transações vinculadas
    final hasTransactions =
        await _database.transactionDao.countTransactionsByCategory(categoryId) >
        0;

    if (hasTransactions) {
      return false; // Não permite deletar categoria com transações
    }

    return _database.categoryDao.deleteCategory(categoryId);
  }

  /// Verifica se uma categoria tem transações
  Future<bool> hasDependentTransactions(String categoryId) async {
    final count = await _database.transactionDao.countTransactionsByCategory(
      categoryId,
    );
    return count > 0;
  }

  /// Conta o número total de categorias
  Future<int> countCategories() {
    return _database.categoryDao.countCategories();
  }
}
