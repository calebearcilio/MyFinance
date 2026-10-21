import 'package:my_finance/core/data/enums/flow_type.dart';

class CategoryFilter {
  String? categorySelectedId;
  String? name;
  FlowType? type;
  double? maxValueTotal;
  double? minValueTotal;
  int offset;
  int limit;

  CategoryFilter({
    this.categorySelectedId,
    this.name,
    this.type,
    this.maxValueTotal,
    this.minValueTotal,
    this.offset = 0,
    this.limit = 50,
  });

  CategoryFilter copyWith({
    String? categorySelectedId,
    bool clearCategorySelectedId = false,
    String? name,
    FlowType? type,
    double? maxValueTotal,
    double? minValueTotal,
    int? offset,
    int? limit,
  }) {
    return CategoryFilter(
      categorySelectedId: clearCategorySelectedId
          ? null
          : (categorySelectedId ?? this.categorySelectedId),
      name: name ?? this.name,
      type: type ?? this.type,
      maxValueTotal: maxValueTotal ?? this.maxValueTotal,
      minValueTotal: minValueTotal ?? this.minValueTotal,
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
    );
  }
}
