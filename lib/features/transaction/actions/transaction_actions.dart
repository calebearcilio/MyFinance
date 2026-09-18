import 'package:flutter/material.dart';
import 'package:myfinance_app/core/models/transaction/transaction.dart';
import 'package:myfinance_app/features/transaction/components/transaction_details.dart';
import 'package:myfinance_app/features/transaction/components/transaction_form.dart';

class TransactionActions {
  static void openFormCreate(BuildContext context) async {
    showDialog<bool>(
      context: context,
      builder: (context) => TransactionForm(mode: .create),
    );
  }

  static void openFormEdit(
    BuildContext context,
    Transaction transactionToEdit,
  ) async {
    showDialog<bool>(
      context: context,
      builder: (context) => TransactionForm(
        transaction: transactionToEdit,
        mode: .edit,
      ),
    );
  }

  static void openModalView(
    BuildContext context,
    Transaction transaction,
  ) async {
    showDialog<bool>(
      context: context,
      builder: (context) => TransactionDetails(transaction: transaction),
    );
  }
}
