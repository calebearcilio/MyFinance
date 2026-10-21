import 'package:flutter/material.dart';
import 'package:my_finance/core/data/enums/flow_type.dart';

class Category {
  /// UUID
  String id;
  String name;
  FlowType type;

  /// String UTF-8
  String emoji;

  /// Format #RRGGBB
  String colorHex;

  bool isDefault;

  /// Categoria pai (quando esta categoria for uma subcategoria)
  Category? parentCategory;

  Category({
    required this.id,
    required this.name,
    required this.type,
    required this.emoji,
    required this.colorHex,
    this.isDefault = false,
    this.parentCategory,
  });

  bool get isSubcategory => parentCategory != null;

  Color get color {
    try {
      return Color(int.parse(colorHex.replaceFirst("#", "0XFF")));
    } catch (_) {
      return Colors.grey;
    }
  }

  static String colorToHex(Color color) {
    final r = (color.r * 255).round().toRadixString(16).padLeft(2, '0');
    final g = (color.g * 255).round().toRadixString(16).padLeft(2, '0');
    final b = (color.b * 255).round().toRadixString(16).padLeft(2, '0');
    return '#${(r + g + b).toUpperCase()}';
  }
}
