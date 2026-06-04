import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:myfinance_app/domain/models/transaction.dart';
import 'package:myfinance_app/domain/models/category.dart';
import 'package:myfinance_app/data/services_locator.dart';

class TransactionFormModal extends StatefulWidget {
  final Transaction? transactionToEdit;
  final String? initialCategoryId;

  const TransactionFormModal({
    super.key,
    this.transactionToEdit,
    this.initialCategoryId,
  });

  @override
  State<TransactionFormModal> createState() => _TransactionFormModalState();
}

class _TransactionFormModalState extends State<TransactionFormModal> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _valueController = TextEditingController();
  final _dateController = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();

  late bool _isEditing;
  late TransactionType _selectedType;
  late String? _selectedCategoryId;
  late DateTime _selectedDate;

  final _transactionRepository = ServiceLocator.transactionRepository;
  final _categoryRepository = ServiceLocator.categoryRepository;

  @override
  void initState() {
    _isEditing = widget.transactionToEdit != null;
    _selectedType = TransactionType.expense;
    _selectedCategoryId = widget.initialCategoryId;
    _selectedDate = DateTime.now();

    if (_isEditing) {
      final transaction = widget.transactionToEdit!;
      _titleController.text = transaction.title;
      _descriptionController.text = transaction.description ?? '';
      _valueController.text = transaction.value.toStringAsFixed(2);
      _selectedType = transaction.type;
      _selectedCategoryId = transaction.categoryId;
      _selectedDate = transaction.date;
      _dateController.text = DateFormat(
        "dd/MM/yyyy",
        "pt_BR",
      ).format(_selectedDate);
    } else {
      _dateController.text = DateFormat(
        "dd/MM/yyyy",
        "pt_BR",
      ).format(_selectedDate);
    }

    super.initState();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategoryId == null || _selectedCategoryId == 'all') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione uma categoria válida'),
        ),
      );
      return;
    }

    final title = _titleController.text;
    final description = _descriptionController.text.isEmpty
        ? null
        : _descriptionController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) return;

    try {
      if (_isEditing) {
        final updatedTransaction = widget.transactionToEdit!.copyWith(
          title: title,
          description: description,
          value: value,
          date: _selectedDate,
          type: _selectedType,
          categoryId: _selectedCategoryId!,
        );

        await _transactionRepository.updateTransaction(updatedTransaction);

        if (!mounted) return;

        Navigator.of(context).pop();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Transação atualizada com sucesso'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        final newTransaction = Transaction(
          id: const Uuid().v4(),
          title: title,
          description: description,
          value: value,
          date: _selectedDate,
          type: _selectedType,
          categoryId: _selectedCategoryId!,
        );

        await _transactionRepository.createTransaction(newTransaction);

        if (!mounted) return;

        Navigator.of(context).pop();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Transação criada com sucesso'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao salvar transação: $e'),
        ),
      );
    }
  }

  void _showDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = DateFormat(
          "dd/MM/yyyy",
          "pt_BR",
        ).format(pickedDate);
      });
    }
  }

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return "Campo obrigatório";
    }
    return null;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _valueController.dispose();
    _dateController.dispose();
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
            spacing: 15,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _isEditing ? "Editar Transação" : "Nova Transação",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              TextFormField(
                controller: _titleController,
                validator: _validateInput,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: "Título *",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              TextFormField(
                controller: _descriptionController,
                maxLines: 2,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: "Descrição",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              TextFormField(
                controller: _valueController,
                validator: _validateInput,
                textInputAction: TextInputAction.next,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: "Valor (R\$) *",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
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
                        child: RadioListTile<TransactionType>(
                          title: const Text("Receita"),
                          value: TransactionType.income,
                          groupValue: _selectedType,
                          onChanged: (value) =>
                              setState(() => _selectedType = value!),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<TransactionType>(
                          title: const Text("Despesa"),
                          value: TransactionType.expense,
                          groupValue: _selectedType,
                          onChanged: (value) =>
                              setState(() => _selectedType = value!),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              TextFormField(
                readOnly: true,
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: "Data",
                  prefixIcon: const Icon(Icons.calendar_month),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onTap: _showDatePicker,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Categoria *",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  StreamBuilder<List<Category>>(
                    stream: _categoryRepository.watchAllCategories(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      final categories = snapshot.data ?? [];
                      // Filter out 'all' category
                      final validCategories = categories
                          .where((c) => c.id != 'all')
                          .toList();

                      return DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedCategoryId != 'all'
                            ? _selectedCategoryId
                            : null,
                        hint: const Text("Selecione uma categoria"),
                        items: validCategories.map((category) {
                          return DropdownMenuItem<String>(
                            value: category.id,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: category.color,
                                  radius: 12,
                                  child: Icon(
                                    category.icon,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(category.name),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) =>
                            setState(() => _selectedCategoryId = value),
                      );
                    },
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
                    child: Text(
                      _isEditing ? "Atualizar" : "Salvar",
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
