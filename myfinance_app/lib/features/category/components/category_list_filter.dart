import 'package:flutter/material.dart';
import 'package:myfinance_app/core/services/services_locator.dart';
import 'package:myfinance_app/features/category/actions/category_actions.dart';
import 'package:myfinance_app/features/category/components/category_item.dart';
import 'package:myfinance_app/core/models/category.dart';
import 'package:myfinance_app/features/common/model/transaction_filter.dart';

class CategoryListFilter extends StatefulWidget {
  final TransactionFilter filter;

  const CategoryListFilter({
    super.key,
    required this.filter,
  });

  @override
  State<CategoryListFilter> createState() => _CategoryListFilterState();
}

class _CategoryListFilterState extends State<CategoryListFilter> {
  bool loading = true;
  List<Category> categories = [];

  void loadData() async {
    categories = await ServiceLocator.categoryRepository
        .getAllCategories();
        
    setState(() => loading = false);
    
  }

  @override
  void didUpdateWidget(covariant CategoryListFilter oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.filter != widget.filter) {
      loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView.builder(
          scrollDirection: .horizontal,
          itemCount: categories.length + 1,
          itemBuilder: (context, index) {
            // Adicionar categoria
            if (index == categories.length) {
              return IconButton(
                onPressed: () => CategoryActions.create(context),
                icon: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.add),
                ),
              );
            }

            final cat = categories[index];
            return CategoryItem(
              category: cat,
              isSelected: cat.id == widget.filter.categoryId,
              onLongPress: () => CategoryActions.delete(context, cat),
            );
          },
        ),
      ),
    );
  }
}
