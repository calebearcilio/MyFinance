import 'package:flutter/material.dart';
import 'package:myfinance_app/models/category.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  final bool isSelected;
  final VoidCallback? onTap;

  const CategoryItem({
    super.key,
    required this.category,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 96,
      child: Card(
        color: isSelected ? category.color.withAlpha(200) : null,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: .center,
              children: [
                CircleAvatar(
                  backgroundColor: category.color,
                  child: Icon(
                    category.icon ?? Icons.category,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 8),

                FittedBox(
                  child: Text(
                    category.name,
                    maxLines: 2,
                    overflow: .ellipsis,
                    textAlign: .center,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
