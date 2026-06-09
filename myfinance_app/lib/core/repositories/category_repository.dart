import 'package:myfinance_app/core/database/app_database.dart';
import 'package:myfinance_app/core/models/category/category.dart';
import 'package:myfinance_app/core/models/category/category_create.dart';
import 'package:myfinance_app/core/models/category/category_summary.dart';

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
      isDefault: data.isDefault,
    );
  }

  /// Converter Category (Domínio) para CategoryData (Drift)
  CategoriesCompanion _convertFromCreate(CategoryCreate category) {
    return CategoriesCompanion.insert(
      name: category.name,
      icon: category.icon,
      color: category.color,
      type: category.type,
    );
  }

  /// Obtém todas as categorias
  Future<List<Category>> getAll() async {
    final data = await _database.categoryDao.getAllCategories();
    return data.map(_convertToDomain).toList();
  }

  /// Obtém uma categoria pelo ID
  Future<Category?> getById(String id) async {
    final data = await _database.categoryDao.getCategoryById(id);
    return data != null ? _convertToDomain(data) : null;
  }

  /// Obtém categorias por tipo
  Future<List<Category>> getByType(CategoryType type) async {
    final data = await _database.categoryDao.getCategoriesByType(type.name);
    return data.map(_convertToDomain).toList();
  }

  /// Watch todas as categorias (Reativo)
  Stream<List<Category>> watchAll() {
    return _database.categoryDao.watchAllCategories().map(
      (data) => data.map(_convertToDomain).toList(),
    );
  }

  /// Watch uma categoria específica (Reativo)
  Stream<Category?> watchById(String id) {
    return _database.categoryDao
        .watchCategoryById(id)
        .map((data) => data != null ? _convertToDomain(data) : null);
  }

  /// Watch categorias por tipo (Reativo)
  Stream<List<Category>> watchByType(CategoryType type) {
    return _database.categoryDao
        .watchCategoriesByType(type.name)
        .map((data) => data.map(_convertToDomain).toList());
  }

  /// Cria uma nova categoria
  Future<void> insert(CategoryCreate category) async {
    return _database.categoryDao.insertCategory(_convertFromCreate(category));
  }

  /// Cria múltiplas categorias
  Future<void> insertAll(List<CategoryCreate> categories) async {
    final driftData = categories.map(_convertFromCreate).toList();
    return _database.categoryDao.insertCategories(driftData);
  }

  /// Verifica se uma categoria é padrão
  Future<bool> isDefaultCategory(String categoryId) async {
    final category = await _database.categoryDao.getCategoryById(categoryId);
    return category?.isDefault ?? false;
  }

  /// Deleta uma categoria
  /// Retorna false se for padrão ou houver transações vinculadas
  Future<bool> deleteCategory(String categoryId) async {
    // Verificar se é categoria padrão
    final isDefault = await isDefaultCategory(categoryId);
    if (isDefault) {
      return false; // Não permite deletar categoria padrão
    }

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

  Stream<List<CategorySummary>> watchExpensesByCategory() {
    return _database.categoryDao.watchExpensesByCategory();
  }

  /// Conta o número total de categorias
  Future<int> countCategories() {
    return _database.categoryDao.countCategories();
  }
}
