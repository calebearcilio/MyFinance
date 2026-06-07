import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:myfinance_app/core/services/services_locator.dart';
import 'package:myfinance_app/core/models/category.dart';
import 'package:myfinance_app/core/models/transaction.dart';
import 'package:myfinance_app/features/common/components/loading_component.dart';

class TransactionForm extends StatefulWidget {
  final Transaction? transaction;
  final bool? isReadOnly;
  const TransactionForm({
    super.key,
    this.transaction,
    this.isReadOnly = false,
  });

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

  String _dateFormat(DateTime? date) =>
      date == null ? "dd/MM/yyyy" : DateFormat("dd/MM/yyyy").format(date);

  String _timeFormat(DateTime? time) =>
      time == null ? "HH:mm" : DateFormat("HH:mm").format(time);

  Future<void> _loadData() async {
    _categories = await _categoriesRepository.getAllCategories();

    final transaction = widget.transaction;

    if (transaction != null) {
      _titleController.text = transaction.title;
      _descriptionController.text = transaction.description ?? "";
      _valueController.text = transaction.value.toString();
      _selectedCategoryId = transaction.category.id;
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
      final dateTimeStr = "$dateStr $timeStr";

      final transaction = Transaction.insert(
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
        type: _type,
        categoryId: _selectedCategoryId,
      );

      if (widget.transaction == null) {
        await _transactionRepository.createTransaction(transaction);
      } else {
        transaction.id = widget.transaction!.id;
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
    Navigator.pop(context);
  }

  String? _validateInput(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Obrigatório";
    }
    return null;
  }

  Widget _buildTextField({
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
      textInputAction: TextInputAction.next,
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
                  widget.transaction == null
                      ? "Adicionando Transação"
                      : "Editando Transação",
                  style: themeContext.textTheme.headlineSmall,
                ),

                const SizedBox(height: 10),

                _buildTextField(
                  label: "Título*",
                  controller: _titleController,
                ),

                _buildTextField(
                  label: "Descrição",
                  controller: _descriptionController,
                  isRequired: false,
                ),

                _buildTextField(
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
                      child: _buildTextField(
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
                      child: _buildTextField(
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
                  initialValue: _categories.isEmpty
                      ? null
                      : _categories.first.id,
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
