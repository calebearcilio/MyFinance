import 'package:my_finance/core/data/enums/flow_type.dart';
import 'package:my_finance/features/category/domain/entities/category.dart';

class Transaction {
  String id;
  String title;
  String? description;
  double value;
  Category category;
  DateTime date;
  FlowType type;

  String get categoryId => category.id;

  Transaction({
    required this.id,
    required this.title,
    this.description,
    required this.value,
    required this.category,
    required this.date,
    required this.type,
  });
}
