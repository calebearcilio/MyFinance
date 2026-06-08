import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myfinance_app/core/services/services_locator.dart';
import 'package:myfinance_app/features/category/actions/category_actions.dart';
import 'package:myfinance_app/features/category/components/category_item.dart';
import 'package:myfinance_app/core/models/category/category.dart';
import 'package:myfinance_app/core/models/transaction/transaction_filter.dart';
import 'package:myfinance_app/features/common/components/loading_component.dart';

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
  List<Category> _categories = [];
  bool _loading = true;
  String? _selectedCategoryId;

  void _loadData() async {
    setState(() => _loading = true);
    try {
      _categories = await ServiceLocator.categoryRepository.getAll();
      setState(() => _loading = false);
    } catch (e) {
      setState(() => _loading = false);
      Fluttertoast.showToast(msg: "Erro ao carregar categorias");
    }
  }

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
    _loadData();
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
    if (_loading) {
      return const SliverToBoxAdapter(
        child: LoadingComponent(),
      );
    }

    return SliverToBoxAdapter(
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView.builder(
          scrollDirection: .horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          itemCount: _categories.length + 1,
          itemBuilder: (context, index) {
            // botção de dicionar categoria
            if (index == _categories.length) {
              return IconButton(
                onPressed: () {
                  CategoryActions.create(context);
                  _loadData();
                },
                icon: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              );
            }

            final cat = _categories[index];
            final isSelected = cat.id == _selectedCategoryId;
            return CategoryItem(
              category: cat,
              onTap: () => _selectCategory(cat.id),
              isSelected: isSelected,
              onLongPress: () => CategoryActions.delete(context, cat),
            );
          },
        ),
      ),
    );
  }
}
