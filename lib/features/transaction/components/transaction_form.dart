import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:myfinance_app/core/models/transaction/transaction_create.dart';
import 'package:myfinance_app/core/models/transaction/transaction_update.dart';
import 'package:myfinance_app/core/services/services_locator.dart';
import 'package:myfinance_app/core/models/category/category.dart';
import 'package:myfinance_app/core/models/transaction/transaction.dart';
import 'package:myfinance_app/features/common/components/app_forms.dart';
import 'package:myfinance_app/features/common/components/loading_component.dart';
import 'package:myfinance_app/features/transaction/service/transaction_service.dart';

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
  late String _selectedCategoryId;
  TransactionType _selectedType = TransactionType.expense;

  List<Category> _categories = [];

  bool _isLoading = true;

  String _dateFormat(DateTime? date) =>
      date == null ? "dd/MM/yyyy" : DateFormat("dd/MM/yyyy").format(date);

  String _timeFormat(DateTime? time) =>
      time == null ? "HH:mm" : DateFormat("HH:mm").format(time);

  Future<void> _loadData() async {
    _categories = await ServiceLocator.categoryRepository.getAll();

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
      _selectedCategoryId = _categories.last.id;
      final now = DateTime.now();
      _dateController.text = _dateFormat(now);
      _timeController.text = _timeFormat(now);
    }

    setState(() => _isLoading = false);
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
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      final dateStr = _dateController.text;
      final timeStr = _timeController.text;
      final dateTimeStr = "$dateStr $timeStr";

      if (widget.transaction == null) {
        final transaction = TransactionCreate(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
          value: double.parse(
            _valueController.text.replaceAll(".", "").replaceAll(",", "."),
          ),
          date: DateFormat(
            "${_dateFormat(null)} ${_timeFormat(null)}",
          ).parse(dateTimeStr),
          type: _selectedType,
          categoryId: _selectedCategoryId,
        );

        await TransactionService.create(transaction);
      } else {
        final transaction = TransactionUpdate(
          id: widget.transaction!.id,
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          value: double.parse(
            _valueController.text.replaceAll(".", "").replaceAll(",", "."),
          ),
          date: DateFormat(
            "${_dateFormat(null)} ${_timeFormat(null)}",
          ).parse(dateTimeStr),
          type: _selectedType,
          categoryId: _selectedCategoryId,
        );

        await TransactionService.update(transaction);
      }
      if (mounted) {
        Navigator.pop(context);
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
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _valueController.dispose();
    _dateController.dispose();
    _timeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context);
    final availableWidth = MediaQuery.of(context).size.width;
    final isCreate = widget.mode == .create;
    final isEdit = widget.mode == .edit;
    final isReadOnly = widget.mode == .read;

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
                  suffixIcon: Icon(Icons.money),
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

                AppRadioGroup<TransactionType>(
                  selectedValue: _selectedType,
                  onChanged: widget.mode == .read
                      ? (value) {}
                      : (value) {
                          setState(() {
                            _selectedType = value!;
                          });
                        },
                  options: {
                    TransactionType.expense: "Despesa",
                    TransactionType.income: "Receita",
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
                            Icon(
                              category.icon,
                              color: category.color,
                            ),
                            Text(category.name),
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
