import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_finance/core/data/enums/flow_type.dart';
import 'package:my_finance/features/category/data/repositories/category_repository.dart';
import 'package:my_finance/features/category/domain/entities/category.dart';
import 'package:my_finance/features/common/components/app_forms.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CategoryForm extends StatefulWidget {
  const CategoryForm({super.key});

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late String _selectedEmoji;
  late Color _selectedColor;
  late FlowType _selectedType;
  Category? _selectedParentCategory;
  List<Category> _availableParentCategories = [];

  bool get _isFormValid => _nameController.text.trim().isNotEmpty;

  final List<String> _availableEmojis = [
    "🏷️",
    "🏠",
    "📶",
    "💧",
    "⚡",
    "🛠️",
    "🍽️",
    "🚗",
    "🏥",
    "🎓",
    "🏋️",
    "🛒",
    "💼",
    "📈",
    "🎁",
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

  Future<void> _loadParentCategories() async {
    final repo = context.read<CategoryRepository>();
    final all = await repo.getAll();
    if (!mounted) return;
    setState(() {
      _availableParentCategories = all;
    });
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final category = Category(
      id: const Uuid().v4(),
      name: _nameController.text.trim(),
      emoji: _selectedEmoji,
      colorHex: Category.colorToHex(_selectedColor),
      type: _selectedType,
      parentCategory: _selectedParentCategory,
    );
    try {
      await context.read<CategoryRepository>().save(category);

      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        Fluttertoast.showToast(msg: "Falha na operação");
        Navigator.of(context).pop();
      }
    }
  }

  @override
  void initState() {
    _selectedEmoji = _availableEmojis.first;
    _selectedColor = _availableColors.first;
    _selectedType = FlowType.expense;
    _nameController.addListener(() {
      if (mounted) setState(() {});
    });
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadParentCategories();
    });
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
    final parentOptions = _availableParentCategories
        .where((c) => c.type == _selectedType && !c.isSubcategory)
        .toList();

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

                // Ícone / Emoji
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ícone",
                      style: themeContext.textTheme.labelLarge,
                    ),

                    // Opções de escolha do emoji
                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _availableEmojis.length,
                        itemBuilder: (context, index) {
                          final emoji = _availableEmojis[index];
                          final isSelected = _selectedEmoji == emoji;

                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedEmoji = emoji),
                              child: CircleAvatar(
                                backgroundColor: isSelected
                                    ? _selectedColor
                                    : Colors.grey.shade200,
                                child: Text(
                                  emoji,
                                  style: const TextStyle(fontSize: 20),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                AppRadioGroup<FlowType>(
                  selectedValue: _selectedType,
                  onChanged: (value) {
                    setState(() {
                      _selectedType = value!;
                      if (_selectedParentCategory?.type != _selectedType) {
                        _selectedParentCategory = null;
                      }
                    });
                  },
                  options: const {
                    FlowType.expense: "Despesa",
                    FlowType.income: "Receita",
                  },
                ),

                // Categoria Pai (opcional para Subcategoria)
                if (parentOptions.isNotEmpty)
                  DropdownButtonFormField<Category?>(
                    initialValue: _selectedParentCategory,
                    decoration: const InputDecoration(
                      labelText: "Categoria pai (opcional)",
                    ),
                    items: [
                      const DropdownMenuItem<Category?>(
                        value: null,
                        child: Text("Nenhuma (Categoria principal)"),
                      ),
                      ...parentOptions.map((cat) {
                        return DropdownMenuItem<Category?>(
                          value: cat,
                          child: Row(
                            spacing: 8,
                            children: [
                              Text(cat.emoji),
                              Text(cat.name),
                            ],
                          ),
                        );
                      }),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedParentCategory = value;
                      });
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
