import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myfinance_app/core/models/transaction.dart';
import 'package:myfinance_app/features/transaction/components/transaction_form.dart';

class TransactionActions {
  static void create(BuildContext context) async {
    showDialog<bool>(
      context: context,
      builder: (context) => TransactionForm(),
    ).then(
      (value) => Fluttertoast.showToast(
        msg: value == true ? "Transação Salva" : "Falha na operação",
      ),
    );
  }

  static void update(
    BuildContext context,
    Transaction transactionToEdit,
  ) async {
    showDialog<bool>(
      context: context,
      builder: (context) => TransactionForm(
        transaction: transactionToEdit,
      ),
    ).then(
      (value) => Fluttertoast.showToast(
        msg: value == true ? "Transação Atualizada" : "Falha na operação",
      ),
    );
  }

  static void delete(
    BuildContext context,
    String transactionId,
  ) async {
    showDialog<bool>(
      context: context,
      builder: (context) => TransactionForm(),
    );
  }

  static void view(
    BuildContext context,
    Transaction transactionToView,
  ) async {
    showDialog<bool>(
      context: context,
      builder: (context) => TransactionForm(
        transaction: transactionToView,
        isReadOnly: true,
      ),
    );
  }
}
