import 'package:flutter/material.dart';
import 'package:myfinance_app/core/models/category/category.dart';
import 'package:myfinance_app/core/models/category/category_create.dart';
import 'package:myfinance_app/features/category/service/category_service.dart';
import 'package:myfinance_app/features/common/components/app_forms.dart';

class CategoryForm extends StatefulWidget {
  const CategoryForm({super.key});

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late IconData _selectedIcon;
  late Color _selectedColor;
  late CategoryType _selectedType;

  bool get _isFormValid => _nameController.text.trim().isNotEmpty;

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

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final category = CategoryCreate(
      name: _nameController.text,
      icon: _selectedIcon,
      color: _selectedColor,
      type: _selectedType,
    );
    try {
      await CategoryService.create(category);

      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {}
  }

  @override
  void initState() {
    _selectedIcon = _availableIcons.first;
    _selectedColor = _availableColors.first;
    _selectedType = CategoryType.expense;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context);
    final availableWidth = MediaQuery.of(context).size.width;

    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 8.0,
      ),

      title: const Text("Nova categoria"),

      content: SizedBox(
        width: availableWidth * 0.95,

        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              spacing: 16,
              children: [
                // Nome
                AppTextFormField(
                  label: "Nome*",
                  controller: _nameController,
                ),

                // Ícone
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      "Ícone",
                      style: themeContext.textTheme.labelLarge,
                    ),

                    // Opções de escolha do ícone
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
                              onTap: () => setState(() => _selectedIcon = icon),
                              child: CircleAvatar(
                                backgroundColor: isSelected
                                    ? _selectedColor
                                    : Colors.grey.shade200,
                                child: Icon(
                                  icon,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),

                // Cor
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      "Cor",
                      style: themeContext.textTheme.labelLarge,
                    ),

                    // Opções de escolha da Cor
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
                              onTap: () =>
                                  setState(() => _selectedColor = color),
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

                // Tipo (Despesa ou Receita)
                AppRadioGroup<CategoryType>(
                  selectedValue: _selectedType,
                  onChanged: (value) {
                    setState(() {
                      _selectedType = value!;
                    });
                  },
                  options: {
                    .expense: "Despesa",
                    .income: "Receita",
                  },
                ),
              ],
            ),
          ),
        ),
      ),

      actions: [
        AppActionsButtons(
          onSubmit: _submit,
          isSubmitEnabled: _isFormValid,
        ),
      ],
    );
  }
}
