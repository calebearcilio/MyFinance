import 'package:isar/isar.dart';
import 'package:my_finance/core/data/enums/flow_type.dart';
import 'package:my_finance/core/data/types/body_data.dart';
import 'package:my_finance/features/category/domain/entities/category.dart';

part 'category_model.g.dart';

@collection
class CategoryModel {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String id;

  @enumerated
  late FlowType type;

  late String name;
  late String emoji;
  late String colorHex;
  bool isDefault = false;

  final parentCategory = IsarLink<CategoryModel>();

  CategoryModel fromEntity(Category category) {
    return CategoryModel()
      ..id = category.id
      ..type = category.type
      ..name = category.name
      ..emoji = category.emoji
      ..colorHex = category.colorHex
      ..isDefault = category.isDefault;
  }

  Category toEntity() {
    return Category(
      id: id,
      name: name,
      type: type,
      emoji: emoji,
      colorHex: colorHex,
      isDefault: isDefault,
      parentCategory: parentCategory.value?.toEntity(),
    );
  }

  BodyData toBody() {
    return {
      'id': id,
      'type': type.name,
      'name': name,
      'emoji': emoji,
      'colorHex': colorHex,
      'isDefault': isDefault,
      'parentCategoryId': parentCategory.value?.id,
    };
  }
}
