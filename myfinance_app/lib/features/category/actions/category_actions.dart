import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myfinance_app/core/models/category/category.dart';
import 'package:myfinance_app/features/category/components/category_delete_dialog.dart';
import 'package:myfinance_app/features/category/components/category_form.dart';

class CategoryActions {
  static Future<bool?> openForm(
    BuildContext context,
  ) async {
    return showDialog<bool>(
      context: context,
      builder: (_) => const CategoryForm(),
    );
  }

  static Future<bool?> openDeleteDialog(
    BuildContext context,
    Category category,
  ) async {
    if (category.isDefault) {
      Fluttertoast.showToast(msg: "Categorias padrão não podem ser excluídas ");
      return false;
    }

    return showDialog<bool>(
      context: context,
      builder: (_) => CategoryDeleteDialog(category),
    );
  }
}
