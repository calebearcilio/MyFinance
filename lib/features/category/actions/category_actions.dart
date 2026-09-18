import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myfinance_app/core/models/category/category.dart';
import 'package:myfinance_app/features/category/components/category_delete_dialog.dart';
import 'package:myfinance_app/features/category/components/category_form.dart';

class CategoryActions {
  static void openFormCreate(
    BuildContext context,
  ) async {
    showDialog<bool>(
      context: context,
      builder: (_) => const CategoryForm(),
    );
  }

  static void openDeleteDialog(
    BuildContext context,
    Category category,
  ) async {
    if (category.isDefault) {
      Fluttertoast.showToast(msg: "Categorias padrão não podem ser excluídas ");
      return;
    }

    showDialog<bool>(
      context: context,
      builder: (_) => CategoryDeleteDialog(category),
    );
  }
}
