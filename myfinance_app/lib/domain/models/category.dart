// import 'dart:convert';
import 'package:flutter/material.dart';

enum CategoryType { income, expense }

/// Modelo de domínio para Category
/// Mantém a compatibilidade com a camada de apresentação
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

  /// Factory para criar Category a partir de CategoryData do Drift
  factory Category.fromDriftData({
    required String id,
    required String name,
    required IconData icon,
    required Color color,
    required CategoryType type,
  }) {
    return Category(
      id: id,
      name: name,
      icon: icon,
      color: color,
      type: type,
    );
  }

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
/*
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'icon': icon.codePoint,
      'color': color.value,
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
*/
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
