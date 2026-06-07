import 'package:flutter/material.dart';
import 'package:myfinance_app/core/models/category.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const CategoryItem({
    super.key,
    required this.category,
    this.isSelected = false,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      onTap: onTap,
      child: SizedBox(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(99),
          ),
          color: isSelected ? category.color.withAlpha(200) : null,
          child: Row(
            spacing: 5,
            children: [
              CircleAvatar(
                backgroundColor: category.color,
                child: Icon(
                  category.icon,
                  color: Colors.white,
                ),
              ),

              FittedBox(
                child: Text(
                  category.name,
                  maxLines: 2,
                  overflow: .ellipsis,
                  textAlign: .center,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),

              const SizedBox(width: 3),
            ],
          ),
        ),
      ),
    );
  }
}
