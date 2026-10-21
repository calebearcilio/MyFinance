import 'package:isar/isar.dart';
import 'package:my_finance/core/data/enums/flow_type.dart';
import 'package:my_finance/core/database/sync_service.dart';
import 'package:my_finance/features/category/data/models/category_model.dart';
import 'package:my_finance/features/category/domain/entities/category.dart';
import 'package:my_finance/features/category/domain/entities/category_summary.dart';
import 'package:my_finance/features/filters/domain/models/category_filter.dart';
import 'package:my_finance/features/transaction/data/models/transaction_model.dart';

class CategoryRepository {
  final Isar _db;
  final SyncService _syncService;

  CategoryRepository({required this._db, required this._syncService});

  Future<void> save(Category category) async {
    final existing = await _db.categoryModels.getById(category.id);
    final categoryEntity = CategoryModel().fromEntity(category);
    if (existing != null) {
      categoryEntity.isarId = existing.isarId;
    }

    if (category.parentCategory != null) {
      final parentModel = await _db.categoryModels.getById(
        category.parentCategory!.id,
      );
      categoryEntity.parentCategory.value = parentModel;
    }

    await _db.writeTxn(() async {
      await _db.categoryModels.put(categoryEntity);
      await categoryEntity.parentCategory.save();
    });

    await _syncService.saveCategory(categoryEntity.toBody(), category.id);
  }

  Future<bool> delete(Category category) async {
    if (category.isDefault) {
      return false;
    }

    final hasTransactions =
        await _db.transactionModels
            .filter()
            .categoryIdEqualTo(category.id)
            .count() >
        0;

    if (hasTransactions) {
      return false;
    }

    final deleted = await _db.writeTxn(() async {
      return await _db.categoryModels.deleteById(category.id);
    });

    if (deleted) {
      await _syncService.deleteCategory(category.id);
    }

    return deleted;
  }

  Future<List<Category>> getAll() async {
    final models = await _db.categoryModels.where().sortByName().findAll();
    for (final model in models) {
      await model.parentCategory.load();
    }
    return models.map((cat) => cat.toEntity()).toList();
  }

  Future<List<Category>> getFilteredCategories([CategoryFilter? filter]) async {
    final categoryFilter = filter ?? CategoryFilter();

    final categoriesModel = await _buildQuery(categoryFilter).findAll();
    for (final model in categoriesModel) {
      await model.parentCategory.load();
    }

    return categoriesModel.map((cat) => cat.toEntity()).toList();
  }

  Stream<List<Category>> watchAll([CategoryFilter? filter]) {
    if (filter == null) {
      return _db.categoryModels
          .where()
          .sortByName()
          .watch(fireImmediately: true)
          .asyncMap((models) async {
            for (final model in models) {
              await model.parentCategory.load();
            }
            return models.map((cat) => cat.toEntity()).toList();
          });
    }

    return _buildQuery(filter).watch(fireImmediately: true).asyncMap((
      models,
    ) async {
      for (final model in models) {
        await model.parentCategory.load();
      }
      return models.map((cat) => cat.toEntity()).toList();
    });
  }

  Stream<List<CategorySummary>> watchExpensesByCategory() {
    return _db.transactionModels
        .filter()
        .typeEqualTo(FlowType.expense)
        .watch(fireImmediately: true)
        .asyncMap((transactions) async {
          final Map<String, double> totalsByCategory = {};
          final Map<String, Category> categoryById = {};

          for (final tr in transactions) {
            await tr.category.load();
            final catModel =
                tr.category.value ??
                await _db.categoryModels.getById(tr.categoryId);
            if (catModel == null) continue;

            final cat = catModel.toEntity();
            categoryById[cat.id] = cat;
            totalsByCategory[cat.id] =
                (totalsByCategory[cat.id] ?? 0.0) + tr.value;
          }

          final summaries = totalsByCategory.entries.map((entry) {
            final cat = categoryById[entry.key]!;
            return CategorySummary(
              categoryName: cat.name,
              color: cat.color,
              total: entry.value,
            );
          }).toList();

          summaries.sort((a, b) => b.total.compareTo(a.total));
          return summaries;
        });
  }

  QueryBuilder<CategoryModel, CategoryModel, QAfterLimit> _buildQuery(
    CategoryFilter categoryFilter,
  ) {
    return _db.categoryModels
        .filter()
        .optional(
          categoryFilter.categorySelectedId != null,
          (q) => q.idEqualTo(categoryFilter.categorySelectedId!),
        )
        .optional(
          categoryFilter.name != null && categoryFilter.name!.isNotEmpty,
          (q) => q.nameContains(categoryFilter.name!, caseSensitive: false),
        )
        .optional(
          categoryFilter.type != null,
          (q) => q.typeEqualTo(categoryFilter.type!),
        )
        .sortByName()
        .offset(categoryFilter.offset)
        .limit(categoryFilter.limit);
  }
}
