import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_finance/features/category/data/repositories/category_repository.dart';
import 'package:my_finance/features/category/domain/entities/category.dart';
import 'package:my_finance/features/category/presentation/components/category_delete_dialog.dart';
import 'package:my_finance/features/category/presentation/components/category_form.dart';
import 'package:my_finance/features/category/presentation/components/category_item.dart';
import 'package:my_finance/features/filters/domain/models/category_filter.dart';
import 'package:my_finance/features/filters/domain/providers/filter_provider.dart';
import 'package:provider/provider.dart';

class CategoryListFilter extends StatefulWidget {
  final CategoryFilter filter;

  const CategoryListFilter({
    super.key,
    required this.filter,
  });

  @override
  State<CategoryListFilter> createState() => _CategoryListFilterState();
}

class _CategoryListFilterState extends State<CategoryListFilter> {
  String? _selectedCategoryId;

  void _selectCategory(String? categoryId) {
    final filterProvider = Provider.of<FilterProvider>(context, listen: false);
    setState(
      () => _selectedCategoryId = _selectedCategoryId == categoryId
          ? null
          : categoryId,
    );

    filterProvider.selectCategoryForTransactions(_selectedCategoryId);
  }

  void _openFormCreate(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (_) => const CategoryForm(),
    );
  }

  void _openDeleteDialog(BuildContext context, Category category) {
    if (category.isDefault) {
      Fluttertoast.showToast(msg: "Categorias padrão não podem ser excluídas");
      return;
    }

    showDialog<bool>(
      context: context,
      builder: (_) => CategoryDeleteDialog(category),
    );
  }

  @override
  void initState() {
    super.initState();
    _selectedCategoryId = widget.filter.categorySelectedId;
  }

  @override
  void didUpdateWidget(covariant CategoryListFilter oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.filter.categorySelectedId !=
        widget.filter.categorySelectedId) {
      _selectedCategoryId = widget.filter.categorySelectedId;
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryRepository = context.read<CategoryRepository>();

    return StreamBuilder<List<Category>>(
      stream: categoryRepository.watchAll(),
      initialData: const [],
      builder: (context, snapshot) {
        final categories = snapshot.data ?? [];
        return SliverToBoxAdapter(
          child: Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),

            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              itemCount: categories.length + 1,
              itemBuilder: (context, index) {
                // botão de adicionar categoria
                if (index == categories.length) {
                  return IconButton(
                    onPressed: () => _openFormCreate(context),
                    icon: const CircleAvatar(
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
                  onLongPress: () => _openDeleteDialog(context, cat),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
