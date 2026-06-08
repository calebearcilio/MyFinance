import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myfinance_app/core/models/category/category.dart';
import 'package:myfinance_app/core/services/services_locator.dart';

class CategoryDeleteDialog extends StatelessWidget {
  final Category categoryToDelete;
  final _categoryRepository = ServiceLocator.categoryRepository;
  CategoryDeleteDialog(this.categoryToDelete, {super.key});

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
          child: Text(
            "Excluir",
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
          onPressed: () async {
            _categoryRepository
                .deleteCategory(
                  categoryToDelete.id,
                )
                .then(
                  (value) {
                    Navigator.of(context).pop();
                    Fluttertoast.showToast(msg: "Categoria excluida");
                  },
                );
          },
        ),
      ],
    );
  }
}
