import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myfinance_app/models/transaction.dart';

class TransactionFormModal extends StatefulWidget {
  final Transaction? transactionToEdit;
  final void Function(Transaction) onSubmit;
  const TransactionFormModal({
    super.key,
    this.transactionToEdit,
    required this.onSubmit,
  });

  @override
  State<TransactionFormModal> createState() => _TransactionFormModalState();
}

class _TransactionFormModalState extends State<TransactionFormModal> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  final _dateController = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();
  late bool isEditing;

  @override
  void initState() {
    isEditing = widget.transactionToEdit != null;
    if (widget.transactionToEdit != null) {
      _titleController.text = widget.transactionToEdit!.title;
      _valueController.text = widget.transactionToEdit!.value.toString();
      _dateController.text = DateFormat(
        "dd/MM/yyyy",
        "pt_BR",
      ).format(widget.transactionToEdit!.date);
    }
    super.initState();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;
    final date =
        DateFormat("dd/MM/yyyy", "pt_BR").tryParse(_dateController.text) ??
        DateTime.now();

    if (title.isEmpty || value <= 0) return;

    // final transaction = Transaction(title: title, value: value, date: date);
    // if (isEditing) {
    //   transaction.id = widget.transactionToEdit!.id;
    // }

    // widget.onSubmit(transaction);
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: isEditing ? widget.transactionToEdit!.date : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _dateController.text = DateFormat(
          "dd/MM/yyyy",
          "pt_BR",
        ).format(pickedDate);
      });
    });
  }

  String? _validateInput(String? value) {
    if (value == null || value == "") {
      return "Campo obrigatório";
    }

    return null;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _valueController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          spacing: 20,
          crossAxisAlignment: .end,
          children: [
            Row(
              mainAxisAlignment: .center,
              children: [
                Text(
                  isEditing ? "Editar Despesa" : "Nova Despesa",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            TextFormField(
              controller: _titleController,
              validator: _validateInput,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: "Título *"),
            ),
            TextFormField(
              controller: _valueController,
              validator: _validateInput,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: "Valor (R\$) *"),
            ),
            TextFormField(
              readOnly: true,
              controller: _dateController,
              decoration: InputDecoration(
                labelText: "Selecione a data",
                prefixIcon: Icon(Icons.calendar_month),
              ),
              onTap: _showDatePicker,
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text(
                isEditing ? "Atualizar" : "Salvar",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
