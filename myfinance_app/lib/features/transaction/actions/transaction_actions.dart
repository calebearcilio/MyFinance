import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myfinance_app/core/models/transaction/transaction.dart';
import 'package:myfinance_app/core/services/services_locator.dart';
import 'package:myfinance_app/features/transaction/components/transaction_form.dart';

class TransactionActions {
  static void create(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => TransactionForm(),
    );

    if (result == true) {
      Fluttertoast.showToast(msg: "Transação Salva");
    }
  }

  static void update(
    BuildContext context,
    Transaction transactionToEdit,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => TransactionForm(
        transaction: transactionToEdit,
      ),
    );

    if (result == true) {
      Fluttertoast.showToast(msg: "Transação Salva");
    }
  }

  static void delete(
    BuildContext context,
    String transactionId,
  ) async {
    final result = await ServiceLocator.transactionRepository.delete(
      transactionId,
    );

    if (result == true) {
      Fluttertoast.showToast(msg: "Transação Deletada");
    }
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
