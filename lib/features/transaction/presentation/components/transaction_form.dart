import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:my_finance/core/data/enums/flow_type.dart';
import 'package:my_finance/features/category/data/repositories/category_repository.dart';
import 'package:my_finance/features/category/domain/entities/category.dart';
import 'package:my_finance/features/common/components/app_forms.dart';
import 'package:my_finance/features/common/components/loading_component.dart';
import 'package:my_finance/features/transaction/data/repositories/transaction_repository.dart';
import 'package:my_finance/features/transaction/domain/entities/transaction.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Transaction? transaction;
  final FormMode mode;

  const TransactionForm({
    super.key,
    this.transaction,
    required this.mode,
  });

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _valueController = TextEditingController(text: "0,00");
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  String? _selectedCategoryId;
  FlowType _selectedType = FlowType.expense;

  List<Category> _categories = [];

  bool _isLoading = true;

  String _dateFormat(DateTime? date) =>
      date == null ? "dd/MM/yyyy" : DateFormat("dd/MM/yyyy").format(date);

  String _timeFormat(DateTime? time) =>
      time == null ? "HH:mm" : DateFormat("HH:mm").format(time);

  Future<void> _loadData() async {
    final categoryRepo = context.read<CategoryRepository>();
    _categories = await categoryRepo.getAll();

    final transaction = widget.transaction;

    if (transaction != null) {
      _titleController.text = transaction.title;
      _descriptionController.text = transaction.description ?? "";
      _valueController.text = transaction.value.obterRealSemSimbolo();
      _selectedCategoryId = transaction.category.id;
      _selectedType = transaction.type;
      _dateController.text = _dateFormat(transaction.date);
      _timeController.text = _timeFormat(transaction.date);
    } else {
      if (_categories.isNotEmpty) {
        final matchingCategories = _categories
            .where((c) => c.type == _selectedType)
            .toList();
        _selectedCategoryId = matchingCategories.isNotEmpty
            ? matchingCategories.first.id
            : _categories.first.id;
      }
      final now = DateTime.now();
      _dateController.text = _dateFormat(now);
      _timeController.text = _timeFormat(now);
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _datePicker() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      currentDate: now,
      initialDate: now,
      firstDate: DateTime(2020),
      lastDate: DateTime(now.year + 1, 12, 31),
    );

    if (date == null) return;

    if (!mounted) return;

    setState(() {
      _dateController.text = _dateFormat(date);
    });
  }

  Future<void> _timePicker() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    if (!mounted) return;

    final dateTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      time.hour,
      time.minute,
    );

    setState(() {
      _timeController.text = _timeFormat(dateTime);
    });
  }

  Future<void> _onSave() async {
    if (!_formKey.currentState!.validate() || _selectedCategoryId == null) {
      return;
    }

    try {
      final dateStr = _dateController.text;
      final timeStr = _timeController.text;
      final dateTimeStr = "$dateStr $timeStr";

      final selectedCategory = _categories.firstWhere(
        (c) => c.id == _selectedCategoryId,
        orElse: () => _categories.first,
      );

      final parsedDescription = _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim();

      final parsedValue = double.parse(
        _valueController.text.replaceAll(".", "").replaceAll(",", "."),
      );

      final parsedDate = DateFormat(
        "${_dateFormat(null)} ${_timeFormat(null)}",
      ).parse(dateTimeStr);

      final transaction = Transaction(
        id: widget.transaction?.id ?? const Uuid().v4(),
        title: _titleController.text.trim(),
        description: parsedDescription,
        value: parsedValue,
        date: parsedDate,
        type: selectedCategory.type,
        category: selectedCategory,
      );

      await context.read<TransactionRepository>().save(
        transaction,
        selectedCategory,
      );

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        Fluttertoast.showToast(msg: "Falha na Operação");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _valueController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context);
    final availableWidth = MediaQuery.of(context).size.width;
    final isCreate = widget.mode == FormMode.create;
    final isEdit = widget.mode == FormMode.edit;
    final isReadOnly = widget.mode == FormMode.read;

    if (_isLoading) return const LoadingComponent();

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),

      child: Container(
        width: availableWidth * 0.95,
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              spacing: 16,
              children: [
                Text(
                  isCreate
                      ? "Adicionando Transação"
                      : isEdit
                      ? "Editando Transação"
                      : "Detalhes da Transação",
                  style: themeContext.textTheme.headlineSmall,
                ),

                const SizedBox(height: 10),

                AppTextFormField(
                  label: "Título*",
                  controller: _titleController,
                ),

                AppTextFormField(
                  label: "Descrição",
                  controller: _descriptionController,
                  isRequired: false,
                ),

                AppTextFormField(
                  label: "Valor*",
                  prefixText: "R\$ ",
                  suffixIcon: const Icon(Icons.money),
                  controller: _valueController,
                  inputType: TextInputType.number,
                  masks: [
                    FilteringTextInputFormatter.digitsOnly,
                    CentavosInputFormatter(),
                  ],
                ),

                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      flex: 3,
                      child: AppTextFormField(
                        label: "Data*",
                        controller: _dateController,
                        inputType: TextInputType.number,
                        masks: [
                          FilteringTextInputFormatter.digitsOnly,
                          DataInputFormatter(),
                        ],
                        suffixIcon: IconButton(
                          onPressed: _datePicker,
                          icon: const Icon(Icons.calendar_month),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: AppTextFormField(
                        label: "Hora*",
                        controller: _timeController,
                        inputType: TextInputType.number,
                        masks: [
                          FilteringTextInputFormatter.digitsOnly,
                          HoraInputFormatter(),
                        ],
                        suffixIcon: IconButton(
                          onPressed: _timePicker,
                          icon: const Icon(Icons.access_time),
                        ),
                      ),
                    ),
                  ],
                ),

                AppRadioGroup<FlowType>(
                  selectedValue: _selectedType,
                  onChanged: widget.mode == FormMode.read
                      ? (value) {}
                      : (value) {
                          setState(() {
                            _selectedType = value!;
                          });
                        },
                  options: const {
                    FlowType.expense: "Despesa",
                    FlowType.income: "Receita",
                  },
                ),

                DropdownButtonFormField<String>(
                  initialValue: _selectedCategoryId,
                  validator: appDefaultValidateInput,
                  isExpanded: false,
                  decoration: const InputDecoration(
                    labelText: "Categoria*",
                  ),
                  onChanged: isReadOnly
                      ? (value) {}
                      : (value) {
                          setState(() {
                            _selectedCategoryId = value!;
                            final cat = _categories
                                .where((c) => c.id == value)
                                .firstOrNull;
                            if (cat != null) {
                              _selectedType = cat.type;
                            }
                          });
                        },
                  items: _categories.map((category) {
                    return DropdownMenuItem(
                      value: category.id,
                      child: SizedBox(
                        width: 150,
                        child: Row(
                          spacing: 10,
                          children: [
                            Text(
                              category.emoji,
                              style: const TextStyle(fontSize: 18),
                            ),
                            Expanded(
                              child: Text(
                                category.name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),

                if (!isReadOnly) AppActionsButtons(onSubmit: _onSave),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
