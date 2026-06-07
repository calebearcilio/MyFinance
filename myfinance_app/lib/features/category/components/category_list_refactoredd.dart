import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import 'package:myfinance_app/core/services/services_locator.dart';
import 'package:myfinance_app/core/models/category.dart';
import 'package:myfinance_app/features/category/components/category_item.dart';

class CategoryLista extends StatefulWidget {
  final String selectedCategoryId;
  final ValueChanged<String> onCategorySelected;
  final VoidCallback? onCategoriesUpdated;

  const CategoryLista({
    super.key,
    required this.selectedCategoryId,
    required this.onCategorySelected,
    this.onCategoriesUpdated,
  });

  @override
  State<CategoryLista> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryLista> {
  final _categoryRepository = ServiceLocator.categoryRepository;
  List<Category> _categories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    setState(() => _isLoading = true);
    try {
      final categories = await _categoryRepository.getAllCategories();
      setState(() {
        _categories = categories;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (!mounted) return;
      Fluttertoast.showToast(msg: 'Erro ao carregar categorias: $e');
    }
  }

  void _showCreateCategoryDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.outline,
      isScrollControlled: true,
      builder: (ctx) => _CategoryFormModal(
        onCategoryCreated: () {
          Navigator.of(ctx).pop();
          _loadCategories();
          widget.onCategoriesUpdated?.call();
        },
      ),
    );
  }

  Future<void> _deleteCategory(Category category) async {
    // Verificar se é categoria padrão
    if (category.isDefault) {
      Fluttertoast.showToast(
        msg: 'Não é possível deletar categorias padrão',
        backgroundColor: Colors.orange,
      );
      return;
    }

    // Confirmar exclusão
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Excluir categoria?'),
        content: Text('Tem certeza que deseja deletar "${category.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              'Excluir',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );

    if (shouldDelete != true) return;

    try {
      final success = await _categoryRepository.deleteCategory(category.id);

      if (!mounted) return;

      if (success) {
        // Se a categoria deletada era a selecionada, resetar para "all"
        if (widget.selectedCategoryId == category.id) {
          widget.onCategorySelected('all');
        }

        Fluttertoast.showToast(
          msg: 'Categoria "${category.name}" deletada com sucesso',
          backgroundColor: Colors.green,
        );

        _loadCategories();
        widget.onCategoriesUpdated?.call();
      } else {
        Fluttertoast.showToast(
          msg: 'Não é possível deletar uma categoria com transações vinculadas',
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      if (!mounted) return;
      Fluttertoast.showToast(
        msg: 'Erro ao deletar categoria: $e',
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return SliverToBoxAdapter(
        child: SizedBox(
          height: 50,
          child: Center(
            child: SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        ),
      );
    }

    return SliverToBoxAdapter(
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _categories.length + 1,
          itemBuilder: (context, index) {
            // Botão de adicionar categoria
            if (index == _categories.length) {
              return IconButton(
                onPressed: _showCreateCategoryDialog,
                icon: const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.add),
                ),
              );
            }

            final cat = _categories[index];
            return GestureDetector(
              onLongPress: () => _deleteCategory(cat),
              child: CategoryItem(
                category: cat,
                isSelected: cat.id == widget.selectedCategoryId,
                onTap: () => widget.onCategorySelected(cat.id),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Modal para criar nova categoria (integrado no CategoryList)
class _CategoryFormModal extends StatefulWidget {
  final VoidCallback onCategoryCreated;

  const _CategoryFormModal({
    required this.onCategoryCreated,
  });

  @override
  State<_CategoryFormModal> createState() => _CategoryFormModalState();
}

class _CategoryFormModalState extends State<_CategoryFormModal> {
  final _categoryRepository = ServiceLocator.categoryRepository;
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  IconData? _selectedIcon;
  Color? _selectedColor;
  CategoryType? _selectedType;
  bool _isSubmitting = false;

  final List<IconData> _availableIcons = [
    Icons.category,
    Icons.home,
    Icons.wifi,
    Icons.water_drop,
    Icons.energy_savings_leaf,
    Icons.engineering,
    Icons.restaurant_menu,
    Icons.directions_car,
    Icons.medical_services,
    Icons.school,
    Icons.fitness_center,
    Icons.shopping_cart_sharp,
  ];

  final List<Color> _availableColors = [
    const Color.fromARGB(255, 226, 75, 74),
    const Color.fromARGB(255, 55, 138, 221),
    const Color.fromARGB(255, 29, 158, 117),
    const Color.fromARGB(255, 127, 119, 221),
    const Color.fromARGB(255, 239, 159, 39),
    const Color.fromARGB(255, 212, 83, 126),
    const Color.fromARGB(255, 110, 155, 115),
  ];

  @override
  void initState() {
    _selectedIcon = _availableIcons.first;
    _selectedColor = _availableColors.first;
    _selectedType = CategoryType.expense;
    super.initState();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedIcon == null ||
        _selectedColor == null ||
        _selectedType == null) {
      Fluttertoast.showToast(msg: 'Selecione um ícone, cor e tipo');
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final category = Category(
        id: const Uuid().v4(),
        name: _nameController.text,
        icon: _selectedIcon!,
        color: _selectedColor!,
        type: _selectedType!,
        isDefault: false,
      );

      await _categoryRepository.createCategory(category);

      if (!mounted) return;

      Fluttertoast.showToast(
        msg: 'Categoria "${category.name}" criada com sucesso',
        backgroundColor: Colors.green,
      );

      widget.onCategoryCreated();
    } catch (e) {
      if (!mounted) return;
      Fluttertoast.showToast(
        msg: 'Erro ao criar categoria: $e',
        backgroundColor: Colors.red,
      );
      setState(() => _isSubmitting = false);
    }
  }

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (value.length < 3) {
      return 'Mínimo 3 caracteres';
    }
    return null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 20,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Nova Categoria',
                    style: themeContext.textTheme.titleLarge,
                  ),
                ],
              ),
              TextFormField(
                controller: _nameController,
                validator: _validateInput,
                textInputAction: TextInputAction.next,
                enabled: !_isSubmitting,
                decoration: InputDecoration(
                  labelText: 'Nome da Categoria',
                  hintText: 'ex: Alimentação',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ícone',
                    style: themeContext.textTheme.labelLarge,
                  ),
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _availableIcons.length,
                      itemBuilder: (context, index) {
                        final icon = _availableIcons[index];
                        final isSelected = _selectedIcon == icon;

                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: _isSubmitting
                                ? null
                                : () => setState(() => _selectedIcon = icon),
                            child: CircleAvatar(
                              backgroundColor: isSelected
                                  ? _selectedColor
                                  : Colors.grey.shade200,
                              child: Icon(
                                icon,
                                color: isSelected ? Colors.white : Colors.grey,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cor',
                    style: themeContext.textTheme.labelLarge,
                  ),
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _availableColors.length,
                      itemBuilder: (context, index) {
                        final color = _availableColors[index];
                        final isSelected = _selectedColor == color;

                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: _isSubmitting
                                ? null
                                : () => setState(() => _selectedColor = color),
                            child: CircleAvatar(
                              backgroundColor: color,
                              child: isSelected
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tipo',
                    style: themeContext.textTheme.labelLarge,
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _isSubmitting
                              ? null
                              : () => setState(
                                  () => _selectedType = CategoryType.expense,
                                ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                _selectedType == CategoryType.expense
                                ? Colors.red
                                : Colors.grey.shade300,
                          ),
                          child: Text(
                            'Gasto',
                            style: TextStyle(
                              color: _selectedType == CategoryType.expense
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _isSubmitting
                              ? null
                              : () => setState(
                                  () => _selectedType = CategoryType.income,
                                ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                _selectedType == CategoryType.income
                                ? Colors.green
                                : Colors.grey.shade300,
                          ),
                          child: Text(
                            'Renda',
                            style: TextStyle(
                              color: _selectedType == CategoryType.income
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: _isSubmitting
                          ? null
                          : () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isSubmitting ? null : _submitForm,
                      child: _isSubmitting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : const Text('Criar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
