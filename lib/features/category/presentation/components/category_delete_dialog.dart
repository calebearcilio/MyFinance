import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_finance/features/category/data/repositories/category_repository.dart';
import 'package:my_finance/features/category/domain/entities/category.dart';
import 'package:provider/provider.dart';

class CategoryDeleteDialog extends StatelessWidget {
  final Category categoryToDelete;
  const CategoryDeleteDialog(this.categoryToDelete, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Excluir Categoria '${categoryToDelete.name}' ?"),
      content: const Text(
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
          onPressed: () async {
            final repo = context.read<CategoryRepository>();
            final deleted = await repo.delete(categoryToDelete);
            if (!deleted) {
              Fluttertoast.showToast(
                msg:
                    "Não é possível excluir categoria padrão ou com transações vinculadas",
              );
            }
            if (context.mounted) {
              Navigator.of(context).pop(deleted);
            }
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
