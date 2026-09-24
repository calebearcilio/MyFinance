import 'package:flutter/material.dart';
import 'package:my_finance/core/models/category/category.dart';
import 'package:my_finance/features/category/service/category_service.dart';

class CategoryDeleteDialog extends StatelessWidget {
  final Category categoryToDelete;
  const CategoryDeleteDialog(this.categoryToDelete, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Excluir Categoria '${categoryToDelete.name}' ?"),
      content: Text(
        "Tem certeza que deseja deletar esta categoria ?",
      ),
      actions: [
        TextButton(
          child: const Text("Cancelar"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          onPressed: () {
            CategoryService.delete(categoryToDelete);
            Navigator.of(context).pop();
          },
          child: Text(
            "Excluir",
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ),
      ],
    );
  }
}
