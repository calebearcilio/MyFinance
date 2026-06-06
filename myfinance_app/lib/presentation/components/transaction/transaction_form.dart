import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:myfinance_app/data/services_locator.dart';
import 'package:myfinance_app/domain/category/category.dart';
import 'package:myfinance_app/domain/transaction/transaction.dart';
import 'package:myfinance_app/presentation/components/shared/loading_component.dart';
import 'package:myfinance_app/utils/date/date_time_formatters.dart';

class TransactionForm extends StatefulWidget {
  final Transaction? transactionToEdit;
  const TransactionForm({super.key, this.transactionToEdit});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _valueController = TextEditingController(
    text: "0,00",
  );
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  List<Category> _categories = [];
  late String _selectedCategoryId;
  TransactionType _type = TransactionType.expense;

  final _transactionRepository = ServiceLocator.transactionRepository;
  final _categoriesRepository = ServiceLocator.categoryRepository;

  bool _isLoading = true;

  String _dateFormat(DateTime? date) => date == null
      ? "dd/MM/yyyy"
      : DateFormat("dd/MM/yyyy").format(date);

  String _timeFormat(DateTime? time) => time == null
      ? "HH:mm"
      : DateFormat("HH:mm").format(time);

  Future<void> _loadData() async {
    _categories = await _categoriesRepository.getAllCategories();

    final transaction = widget.transactionToEdit;

    if (transaction != null) {
      _titleController.text = transaction.title;
      _descriptionController.text = transaction.description ?? "";
      _valueController.text = transaction.value.toString();
      _selectedCategoryId = transaction.categoryId;
      _type = transaction.type;
      _dateController.text = _dateFormat(transaction.date);
      _timeController.text = _timeFormat(transaction.date);
    } else {
      _selectedCategoryId = _categories.isEmpty ? "" : _categories.first.id;
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
      final dateTimeStr = "$dateStr $_timeController.text";
      
      final transaction = Transaction(
        id: widget.transactionToEdit?.id,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        value: double.parse(
          _valueController.text.replaceAll(".", "").replaceAll(",", "."),
        ),
        date: DateFormat("dd/MM/yyyy HH:mm").parse(dateTimeStr),
        type: _type,
        categoryId: _selectedCategoryId,
      );

      if (widget.transactionToEdit == null) {
        await _transactionRepository.createTransaction(transaction);
      } else {
        await _transactionRepository.updateTransaction(transaction);
      }
      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        Fluttertoast.showToast(msg: "Falha ao adicionar transação");
      }
    }
  }

  void _onCancel() {
    Navigator.pop(
      context,
      false,
    );
  }

  String? _validateInput(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Obrigatório";
    }
    return null;
  }

  Widget _textFieldBuild({
    required String label,
    String? prefixText,
    required TextEditingController controller,
    bool isRequired = true,
    TextInputType? inputType,
    List<TextInputFormatter>? masks,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      keyboardType: inputType,
      controller: controller,
      textInputAction: .next,
      decoration: InputDecoration(
        labelText: label,
        prefixText: prefixText,
        suffixIcon: suffixIcon,
      ),
      inputFormatters: masks,
      validator: isRequired ? _validateInput : null,
    );
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
                  widget.transactionToEdit == null
                      ? "Adicionando Transação"
                      : "Editando Transação",
                  style: themeContext.textTheme.headlineSmall,
                ),

                const SizedBox(height: 10),

                _textFieldBuild(
                  label: "Título*",
                  controller: _titleController,
                ),

                _textFieldBuild(
                  label: "Descrição",
                  controller: _descriptionController,
                  isRequired: false,
                ),

                _textFieldBuild(
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
                      flex: 2,
                      child: _textFieldBuild(
                        label: "Data*",
                        controller: _dateController,
                        inputType: TextInputType.number,
                        masks: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                        ],
                        suffixIcon: IconButton(
                          onPressed: _datePicker,
                          icon: const Icon(Icons.calendar_month),
                        ),
                      ),
                    ),
                    Expanded(
                      child: _textFieldBuild(
                        label: "Hora*",
                        controller: _timeController,
                        inputType: TextInputType.number,
                        masks: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9:]')),
                        ],
                        suffixIcon: IconButton(
                          onPressed: _timePicker,
                          icon: const Icon(Icons.access_time),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 60,
                  child: RadioGroup<TransactionType>(
                    groupValue: _type,
                    onChanged: (value) {
                      setState(() {
                        _type = value!;
                      });
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: RadioListTile<TransactionType>(
                            value: TransactionType.expense,
                            title: Text("Despesa"),
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<TransactionType>(
                            value: TransactionType.income,
                            title: Text("Receita"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                DropdownButtonFormField<String>(
                  initialValue: _categories.isEmpty ? null : _categories.first.id,
                  validator: _validateInput,
                  isExpanded: false,
                  decoration: const InputDecoration(
                    labelText: "Categoria*",
                  ),
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
                  onChanged: (value) {
                    setState(() {
                      _selectedCategoryId = value!;
                    });
                  },
                ),

                Row(
                  spacing: 20,
                  children: [
                    Expanded(
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: _onCancel,
                        child: const Text(
                          "Cancelar",
                        ),
                      ),
                    ),

                    Expanded(
                      child: FilledButton(
                        onPressed: _onSave,
                        child: const Text(
                          "Salvar",
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
