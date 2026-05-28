import 'package:flutter/material.dart';

class CategoryFormModal extends StatefulWidget {
  const CategoryFormModal({super.key});

  @override
  State<CategoryFormModal> createState() => _CategoryFormModalState();
}

class _CategoryFormModalState extends State<CategoryFormModal> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),

      child: Form(
        child: Column(
          spacing: 20,
          crossAxisAlignment: .end,
          children: [
            Row(
              mainAxisAlignment: .center,
              children: [
                Text(
                  "Nova Categoria",
                  // style: Theme.of(context).textTheme,
                ),
              ],
            ),
            TextFormField(
              // controller: _nameController,
              // validator: _validateInput,
              textInputAction: .next,
              decoration: InputDecoration(labelText: "Nome"),
            ),
          ],
        ),
      ),
    );
  }
}
