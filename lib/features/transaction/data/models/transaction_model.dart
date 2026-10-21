import 'package:isar/isar.dart';
import 'package:my_finance/core/data/enums/flow_type.dart';
import 'package:my_finance/core/data/types/body_data.dart';
import 'package:my_finance/features/category/data/models/category_model.dart';
import 'package:my_finance/features/category/domain/entities/category.dart';
import 'package:my_finance/features/transaction/domain/entities/transaction.dart';

part 'transaction_model.g.dart';

@collection
class TransactionModel {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String id;

  @Index()
  late String categoryId;

  final category = IsarLink<CategoryModel>();

  @enumerated
  late FlowType type;

  late String title;
  String? description;
  late double value;
  late DateTime date;

  TransactionModel fromEntity(Transaction transaction) {
    return TransactionModel()
      ..id = transaction.id
      ..categoryId = transaction.category.id
      ..type = transaction.type
      ..title = transaction.title
      ..description = transaction.description
      ..value = transaction.value
      ..date = transaction.date;
  }

  Transaction toEntity([Category? fallbackCategory]) {
    final resolvedCategory =
        category.value?.toEntity() ??
        fallbackCategory ??
        Category(
          id: categoryId,
          name: 'Sem categoria',
          type: type,
          emoji: '📌',
          colorHex: '#9E9E9E',
        );

    return Transaction(
      id: id,
      title: title,
      description: description,
      value: value,
      category: resolvedCategory,
      date: date,
      type: type,
    );
  }

  BodyData toBody() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'value': value,
      'categoryId': categoryId,
      'date': date.toIso8601String(),
      'type': type.name,
    };
  }
}
