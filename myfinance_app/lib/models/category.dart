import 'dart:convert';
import 'package:flutter/material.dart';

enum CategoryType { income, expense }

class Category {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final CategoryType type;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.type,
  });

  Category copyWith({
    String? id,
    String? name,
    IconData? icon,
    Color? color,
    CategoryType? type,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'icon': icon.codePoint,
      'color': color.toARGB32(),
      'type': type.name,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as String,
      name: map['name'] as String,
      icon: IconData(map['icon'] as int, fontFamily: 'MaterialIcons'),
      color: Color(map['color'] as int),
      type: CategoryType.values.byName(map['type'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Category(id: $id, name: $name, icon: $icon, color: $color), type: $type';
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

final List<Category> defaultCategries = [
  Category(
    id: "all",
    name: "Tudo",
    icon: Icons.category,
    color: const Color.fromARGB(255, 110, 155, 115),
    type: .expense
  ),
  Category(
    id: "food",
    name: "Alimentação",
    icon: Icons.restaurant_menu,
    color: const Color.fromARGB(255, 226, 75, 74),
    type: .expense
  ),
  Category(
    id: "transport",
    name: "Transporte",
    icon: Icons.directions_car,
    color: const Color.fromARGB(255, 55, 138, 221),
    type: .expense
  ),
  Category(
    id: "health",
    name: "Saúde",
    icon: Icons.medical_services,
    color: const Color.fromARGB(255, 29, 158, 117),
    type: .expense
  ),
  Category(
    id: "education",
    name: "Educação",
    icon: Icons.school,
    color: const Color.fromARGB(255, 127, 119, 221),
    type: .expense
  ),
  Category(
    id: "leisure",
    name: "Lazer",
    icon: Icons.fitness_center,
    color: const Color.fromARGB(255, 239, 159, 39),
    type: .expense
  ),
  Category(
    id: "shopping",
    name: "Compras",
    icon: Icons.shopping_cart_sharp,
    color: const Color.fromARGB(255, 212, 83, 126),
    type: .expense
  ),
];
