import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myfinance_app/core/models/category.dart';
import 'package:myfinance_app/features/category/components/category_delete_dialog.dart';
import 'package:myfinance_app/features/category/components/category_form_modal.dart';

class CategoryActions {
  static Future<bool?> create(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => CategoryFormModal(),
    ).then(
      (value) => Fluttertoast.showToast(
        msg: value == true ? "Categoria salva" : "Falha na operação",
      ),
    );
  }

  static Future<bool?> delete(BuildContext context, Category category) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => CategoryDeleteDialog(category: category),
    ).then(
      (value) => Fluttertoast.showToast(
        msg: value == true ? "Categoria excluida" : "Falha na operação",
      ),
    );
  }
}
