import 'package:flutter/material.dart';
import 'package:myfinance_app/core/services/services_locator.dart';
import 'package:myfinance_app/features/category/actions/category_actions.dart';
import 'package:myfinance_app/features/category/components/category_item.dart';
import 'package:myfinance_app/core/models/transaction/transaction_filter.dart';

class CategoryListFilter extends StatefulWidget {
  final TransactionFilter filter;
  final Function(TransactionFilter newFilter) onFilterChange;

  const CategoryListFilter({
    super.key,
    required this.filter,
    required this.onFilterChange,
  });

  @override
  State<CategoryListFilter> createState() => _CategoryListFilterState();
}

class _CategoryListFilterState extends State<CategoryListFilter> {
  String? _selectedCategoryId;

  void _selectCategory(String? categoryId) {
    setState(
      () => _selectedCategoryId = _selectedCategoryId == categoryId
          ? null
          : categoryId,
    );

    final newFilter = _selectedCategoryId == null
        ? widget.filter.clearCategoryOnly()
        : widget.filter.copyWith(categoryId: _selectedCategoryId);

    widget.onFilterChange(newFilter);
  }

  @override
  void initState() {
    super.initState();
    _selectedCategoryId = widget.filter.categoryId;
  }

  @override
  void didUpdateWidget(covariant CategoryListFilter oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.filter.categoryId != widget.filter.categoryId) {
      _selectedCategoryId = widget.filter.categoryId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ServiceLocator.categoryRepository.watchAll(),
      builder: (context, snapshot) {
        final categories = snapshot.data!;
        return SliverToBoxAdapter(
          child: Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView.builder(
              scrollDirection: .horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              itemCount: categories.length + 1,
              itemBuilder: (context, index) {
                // botção de dicionar categoria
                if (index == categories.length) {
                  return IconButton(
                    onPressed: () => CategoryActions.openFormCreate(context),
                    icon: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  );
                }

                final cat = categories[index];
                final isSelected = cat.id == _selectedCategoryId;
                return CategoryItem(
                  category: cat,
                  onTap: () => _selectCategory(cat.id),
                  isSelected: isSelected,
                  onLongPress: () =>
                      CategoryActions.openDeleteDialog(context, cat),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
