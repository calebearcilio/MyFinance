import 'package:myfinance_app/core/models/category/category.dart';
import 'package:myfinance_app/core/models/category/category_create.dart';
import 'package:myfinance_app/core/services/services_locator.dart';

class CategoryService {
  static Future<void> create(
    CategoryCreate category,
  ) async {
    await ServiceLocator.categoryRepository.insert(
      category,
    );
  }

  static Future<void> delete(
    Category category,
  ) async {
    if (category.isDefault) {
      throw Exception(
        'Categorias padrão não podem ser excluídas',
      );
    }

    await ServiceLocator.categoryRepository.deleteCategory(
      category.id,
    );
  }
}
