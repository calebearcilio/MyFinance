import 'package:flutter/material.dart';
import 'package:myfinance_app/presentation/components/category/category_item.dart';
import 'package:myfinance_app/models/category.dart';

class CategoryList extends StatelessWidget {
  final List<Category> categories;
  final String selectedCategoryId;
  final ValueChanged<BuildContext> onCreateCategory;
  final void Function(BuildContext, Category) onDeleteCategory;
  final ValueChanged<String> onCategotyTap;

  const CategoryList({
    super.key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onCreateCategory,
    required this.onDeleteCategory,
    required this.onCategotyTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 50,
        child: ListView.builder(
          scrollDirection: .horizontal,
          itemCount: categories.length + 1,
          itemBuilder: (context, index) {
            // Adicionar categoria
            if (index == categories.length) {
              return IconButton(
                onPressed: () => onCreateCategory(context),
                icon: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.add),
                ),
              );
            }

            final cat = categories[index];
            return CategoryItem(
              category: cat,
              isSelected: cat.id == selectedCategoryId,
              onTap: () => onCategotyTap(cat.id),
              onLongPress: () => onDeleteCategory(context, cat),
            );
          },
        ),
      ),
    );
  }
}
