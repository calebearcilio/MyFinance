import 'package:flutter/material.dart';

enum CategoryType { income, expense }

class Category {
  late String id;
  final String name;
  final IconData icon;
  final Color color;
  final CategoryType type;
  final bool isDefault;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.type,
    this.isDefault = false,
  });
  
  Category.insert({
    required this.name,
    required this.icon,
    required this.color,
    required this.type,
    this.isDefault = false,
  });

  factory Category.fromDriftData({
    required String id,
    required String name,
    required IconData icon,
    required Color color,
    required CategoryType type,
    required bool isDefault,
  }) {
    return Category(
      id: id,
      name: name,
      icon: icon,
      color: color,
      type: type,
      isDefault: isDefault,
    );
  }

  Category copyWith({
    String? id,
    String? name,
    IconData? icon,
    Color? color,
    CategoryType? type,
    bool? isDefault,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      type: type ?? this.type,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  String toString() {
    return 'Category(id: $id, name: $name, icon: $icon, color: $color, type: $type)';
  }

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.icon == icon &&
        other.color == color &&
        other.type == type;
  }

  @override
  int get hashCode => Object.hash(id, name, icon, color, type);
}
