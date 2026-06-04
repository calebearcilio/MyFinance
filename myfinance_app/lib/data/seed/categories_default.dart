import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:myfinance_app/data/database/app_database.dart';

class CategoriesDefault {
  static final expenses = [
    CategoriesCompanion.insert(
      id: Value("food"),
      name: "Alimentação",
      icon: Icons.restaurant,
      color: const Color.fromARGB(255, 226, 75, 74),
      type: .expense,
    ),
    CategoriesCompanion.insert(
      id: Value("transport"),
      name: "Transporte",
      icon: Icons.directions_car,
      color: const Color.fromARGB(255, 55, 138, 221),
      type: .expense,
    ),
    CategoriesCompanion.insert(
      id: Value("health"),
      name: "Saúde",
      icon: Icons.medical_services,
      color: const Color.fromARGB(255, 29, 158, 117),
      type: .expense,
    ),
    CategoriesCompanion.insert(
      id: Value("education"),
      name: "Educação",
      icon: Icons.school,
      color: const Color.fromARGB(255, 127, 119, 221),
      type: .expense,
    ),
    CategoriesCompanion.insert(
      id: Value("leisure"),
      name: "Lazer",
      icon: Icons.fitness_center,
      color: const Color.fromARGB(255, 239, 159, 39),
      type: .expense,
    ),
    CategoriesCompanion.insert(
      id: Value("shopping"),
      name: "Compras",
      icon: Icons.shopping_cart_sharp,
      color: const Color.fromARGB(255, 212, 83, 126),
      type: .expense,
    ),
  ];
  static final income = [
    CategoriesCompanion.insert(
      id: Value("salary"),
      name: "Salário",
      icon: Icons.shopping_cart_sharp,
      color: const Color.fromARGB(255, 16, 194, 37),
      type: .income,
    ),
    CategoriesCompanion.insert(
      id: Value("invertment"),
      name: "Investimentos",
      icon: Icons.shopping_cart_sharp,
      color: const Color.fromARGB(255, 118, 12, 199),
      type: .income,
    ),
    CategoriesCompanion.insert(
      id: Value("bonus"),
      name: "Bônus",
      icon: Icons.shopping_cart_sharp,
      color: const Color.fromARGB(255, 42, 35, 226),
      type: .income,
    ),
  ];
}
