import 'package:isar/isar.dart';
import 'package:my_finance/core/data/enums/flow_type.dart';
import 'package:my_finance/core/database/sync_service.dart';
import 'package:my_finance/features/category/data/models/category_model.dart';
import 'package:my_finance/features/category/domain/entities/category.dart';
import 'package:my_finance/features/dashboard/domain/entities/finance.dart';
import 'package:my_finance/features/filters/domain/models/transaction_filter.dart';
import 'package:my_finance/features/transaction/data/models/transaction_model.dart';
import 'package:my_finance/features/transaction/domain/entities/transaction.dart';

class TransactionRepository {
  final Isar _db;
  final SyncService syncService;

  TransactionRepository({required this._db, required this.syncService});

  Future<void> save(Transaction tr, [Category? cat]) async {
    final category = cat ?? tr.category;
    tr.category = category;
    tr.type = category.type;

    final existing = await _db.transactionModels.getById(tr.id);
    final transactionEntity = TransactionModel().fromEntity(tr);
    if (existing != null) {
      transactionEntity.isarId = existing.isarId;
    }

    final categoryModel = await _db.categoryModels.getById(category.id);
    transactionEntity.category.value = categoryModel;

    // Save in local DB
    await _db.writeTxn(() async {
      await _db.transactionModels.put(transactionEntity);
      await transactionEntity.category.save();
    });

    // Save in Firebase
    await syncService.saveTransaction(
      transactionEntity.toBody(),
      transactionEntity.id,
    );
  }

  Future<bool> delete(String id) async {
    final deleted = await _db.writeTxn(() async {
      return await _db.transactionModels.deleteById(id);
    });

    if (deleted) {
      await syncService.deleteTransaction(id);
    }

    return deleted;
  }

  Future<List<Transaction>> getFilteredTransactions([
    TransactionFilter? filter,
  ]) async {
    final transactionsModel = await _buildQuery(
      filter ?? TransactionFilter(),
    ).findAll();

    return _mapModelsToEntities(transactionsModel);
  }

  Stream<List<Transaction>> watchAll([TransactionFilter? filter]) {
    return _buildQuery(filter ?? TransactionFilter())
        .watch(fireImmediately: true)
        .asyncMap(_mapModelsToEntities);
  }

  Stream<Finance> watchMonthlyFinance([DateTime? month]) {
    final target = month ?? DateTime.now();
    final start = DateTime(target.year, target.month, 1);
    final end = DateTime(target.year, target.month + 1, 0, 23, 59, 59, 999);

    return _db.transactionModels
        .filter()
        .dateBetween(start, end)
        .watch(fireImmediately: true)
        .map((rows) {
          double income = 0;
          double expense = 0;

          for (final tr in rows) {
            if (tr.type == FlowType.income) {
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

  Future<List<Transaction>> _mapModelsToEntities(
    List<TransactionModel> models,
  ) async {
    final result = <Transaction>[];
    for (final tr in models) {
      await tr.category.load();
      Category? fallback;
      if (tr.category.value == null) {
        final catModel = await _db.categoryModels.getById(tr.categoryId);
        fallback = catModel?.toEntity();
      }
      result.add(tr.toEntity(fallback));
    }
    return result;
  }

  QueryBuilder<TransactionModel, TransactionModel, QAfterLimit> _buildQuery(
    TransactionFilter filter,
  ) {
    return _db.transactionModels
        .filter()
        .optional(
          filter.id != null,
          (q) => q.idEqualTo(filter.id!),
        )
        .optional(
          filter.categoryId != null,
          (q) => q.categoryIdEqualTo(filter.categoryId!),
        )
        .optional(
          filter.title != null && filter.title!.isNotEmpty,
          (q) => q.titleContains(filter.title!, caseSensitive: false),
        )
        .optional(
          filter.description != null && filter.description!.isNotEmpty,
          (q) =>
              q.descriptionContains(filter.description!, caseSensitive: false),
        )
        .optional(
          filter.type != null,
          (q) => q.typeEqualTo(filter.type!),
        )
        .optional(
          filter.maxValue != null,
          (q) => q.valueLessThan(filter.maxValue!, include: true),
        )
        .optional(
          filter.minValue != null,
          (q) => q.valueGreaterThan(filter.minValue!, include: true),
        )
        .optional(
          filter.initDate != null && filter.endDate != null,
          (q) => q.dateBetween(filter.initDate!, filter.endDate!),
        )
        .optional(
          filter.initDate != null && filter.endDate == null,
          (q) => q.dateGreaterThan(filter.initDate!, include: true),
        )
        .optional(
          filter.endDate != null && filter.initDate == null,
          (q) => q.dateLessThan(filter.endDate!, include: true),
        )
        .sortByDateDesc()
        .offset(filter.offset)
        .limit(filter.limit);
  }
}
