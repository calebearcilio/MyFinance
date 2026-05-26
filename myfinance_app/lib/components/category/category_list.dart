import 'package:flutter/material.dart';
import 'package:myfinance_app/components/category/category_item.dart';
import 'package:myfinance_app/models/category.dart';

class CategoryList extends StatelessWidget {
  final List<Category> categories;
  final String selectedCategoryId;
  final ValueChanged<String> onCategotyTap;

  const CategoryList({
    super.key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onCategotyTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: .horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final cat = categories[index];
            return CategoryItem(
              category: cat,
              isSelected: cat.id == selectedCategoryId,
              onTap: () => onCategotyTap(cat.id),
            );
          },
        ),
      ),
    );
  }
}
