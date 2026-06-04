import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:myfinance_app/data/services_locator.dart';
import 'package:myfinance_app/domain/models/category.dart';

class CategoryFormModal extends StatefulWidget {
  const CategoryFormModal({super.key});

  @override
  State<CategoryFormModal> createState() => _CategoryFormModalState();
}

class _CategoryFormModalState extends State<CategoryFormModal> {
  final _categoryRepository = ServiceLocator.categoryRepository;
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  IconData? _selectedIcon;
  Color? _selectedColor;
  CategoryType? _selectedType;

  final List<IconData> _availableIcons = [
    Icons.restaurant_menu,
    Icons.directions_car,
    Icons.medical_services,
    Icons.school,
    Icons.fitness_center,
    Icons.shopping_cart_sharp,
    Icons.category,
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

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedIcon == null ||
        _selectedColor == null ||
        _selectedType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione um ícone, cor e tipo'),
        ),
      );
      return;
    }

    try {
      final category = Category(
        id: const Uuid().v4(),
        name: _nameController.text,
        icon: _selectedIcon!,
        color: _selectedColor!,
        type: _selectedType!,
      );

      await _categoryRepository.createCategory(category);

      if (!mounted) return;

      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Categoria criada com sucesso'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao criar categoria: $e'),
        ),
      );
    }
  }

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return "Campo obrigatório";
    }
    if (value.length < 3) {
      return "Mínimo 3 caracteres";
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
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 20,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Nova Categoria",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              TextFormField(
                controller: _nameController,
                validator: _validateInput,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: "Nome da Categoria",
                  hintText: "ex: Alimentação",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ícone",
                    style: Theme.of(context).textTheme.labelLarge,
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
                            onTap: () => setState(() => _selectedIcon = icon),
                            child: CircleAvatar(
                              backgroundColor: isSelected
                                  ? Theme.of(context).primaryColor
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
                    "Cor",
                    style: Theme.of(context).textTheme.labelLarge,
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
                            onTap: () => setState(() => _selectedColor = color),
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
                    "Tipo",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<CategoryType>(
                          title: const Text("Receita"),
                          value: CategoryType.income,
                          groupValue: _selectedType,
                          onChanged: (value) =>
                              setState(() => _selectedType = value),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<CategoryType>(
                          title: const Text("Despesa"),
                          value: CategoryType.expense,
                          groupValue: _selectedType,
                          onChanged: (value) =>
                              setState(() => _selectedType = value),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 10,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Cancelar"),
                  ),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text("Criar"),
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
