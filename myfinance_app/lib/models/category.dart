import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final IconData? icon;
  final Color color;

  Category({
    required this.id,
    required this.name,
    this.icon,
    required this.color,
  });
}

final List<Category> defaultCategries = [
  Category(
    id: "all",
    name: "Tudo",
    color: const Color.fromARGB(255, 110, 155, 115),
  ),
  Category(
    id: "food",
    name: "Alimentação",
    icon: Icons.restaurant_menu,
    color: const Color.fromARGB(255, 226, 75, 74),
  ),
  Category(
    id: "transport",
    name: "Transporte",
    icon: Icons.directions_car,
    color: const Color.fromARGB(255, 55, 138, 221),
  ),
  Category(
    id: "health",
    name: "Saúde",
    icon: Icons.medical_services,
    color: const Color.fromARGB(255, 29, 158, 117),
  ),
  Category(
    id: "education",
    name: "Educação",
    icon: Icons.school,
    color: const Color.fromARGB(255, 127, 119, 221),
  ),
  Category(
    id: "leisure",
    name: "Lazer",
    icon: Icons.fitness_center,
    color: const Color.fromARGB(255, 239, 159, 39),
  ),
  Category(
    id: "shopping",
    name: "Compras",
    icon: Icons.shopping_cart_sharp,
    color: const Color.fromARGB(255, 212, 83, 126),
  ),
];
