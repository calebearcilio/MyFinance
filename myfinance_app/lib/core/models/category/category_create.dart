import 'package:flutter/material.dart';
import 'package:myfinance_app/core/models/category/category.dart';

class CategoryCreate {
  final String name;
  final IconData icon;
  final Color color;
  final CategoryType type;

  CategoryCreate({
    required this.name,
    required this.icon,
    required this.color,
    required this.type,
  });
}
