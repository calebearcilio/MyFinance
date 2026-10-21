// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:my_finance/core/data/enums/flow_type.dart';

class TransactionFilter {
  String? id;
  String? title;
  String? description;
  double? maxValue;
  double? minValue;
  FlowType? type;
  String? categoryId;
  DateTime? initDate;
  DateTime? endDate;
  int offset;
  int limit;

  TransactionFilter({
    this.id,
    this.title,
    this.description,
    this.maxValue,
    this.minValue,
    this.type,
    this.categoryId,
    this.initDate,
    this.endDate,
    this.offset = 0,
    this.limit = 100,
  });

  TransactionFilter copyWith({
    String? id,
    String? title,
    String? description,
    double? maxValue,
    double? minValue,
    FlowType? type,
    String? categoryId,
    bool clearCategoryId = false,
    DateTime? initDate,
    DateTime? endDate,
    int? offset,
    int? limit,
  }) {
    return TransactionFilter(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      maxValue: maxValue ?? this.maxValue,
      minValue: minValue ?? this.minValue,
      type: type ?? this.type,
      categoryId: clearCategoryId ? null : (categoryId ?? this.categoryId),
      initDate: initDate ?? this.initDate,
      endDate: endDate ?? this.endDate,
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
    );
  }
}
