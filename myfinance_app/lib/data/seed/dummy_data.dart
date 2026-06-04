import 'package:myfinance_app/domain/models/category.dart';
import 'package:myfinance_app/domain/models/transaction.dart';
import 'package:flutter/material.dart';

/// Dados dummy para testes durante desenvolvimento
/// Estes dados podem ser seedados no banco via seedInitialData()

final now = DateTime.now();

final List<Transaction> dummyTransactions = [
  // Food (10)
  Transaction(
    id: 'food1',
    title: 'Café',
    value: 6.50,
    date: now.subtract(const Duration(days: 0)),
    type: TransactionType.expense,
    categoryId: 'food',
  ),
  Transaction(
    id: 'food2',
    title: 'Almoço',
    value: 22.30,
    date: now.subtract(const Duration(days: 1)),
    type: TransactionType.expense,
    categoryId: 'food',
  ),
  Transaction(
    id: 'food3',
    title: 'Jantar',
    value: 45.00,
    date: now.subtract(const Duration(days: 2)),
    type: TransactionType.expense,
    categoryId: 'food',
  ),
  Transaction(
    id: 'food4',
    title: 'Lanche',
    value: 12.00,
    date: now.subtract(const Duration(days: 3)),
    type: TransactionType.expense,
    categoryId: 'food',
  ),
  Transaction(
    id: 'food5',
    title: 'Supermercado',
    value: 150.75,
    date: now.subtract(const Duration(days: 4)),
    type: TransactionType.expense,
    categoryId: 'food',
  ),
  Transaction(
    id: 'food6',
    title: 'Padaria',
    value: 8.90,
    date: now.subtract(const Duration(days: 5)),
    type: TransactionType.expense,
    categoryId: 'food',
  ),
  Transaction(
    id: 'food7',
    title: 'Delivery',
    value: 39.20,
    date: now.subtract(const Duration(days: 6)),
    type: TransactionType.expense,
    categoryId: 'food',
  ),
  Transaction(
    id: 'food8',
    title: 'Bebidas',
    value: 18.00,
    date: now.subtract(const Duration(days: 7)),
    type: TransactionType.expense,
    categoryId: 'food',
  ),
  Transaction(
    id: 'food9',
    title: 'Mercado Hortifruti',
    value: 62.10,
    date: now.subtract(const Duration(days: 8)),
    type: TransactionType.expense,
    categoryId: 'food',
  ),
  Transaction(
    id: 'food10',
    title: 'Restaurante',
    value: 88.40,
    date: now.subtract(const Duration(days: 9)),
    type: TransactionType.expense,
    categoryId: 'food',
  ),

  // Transport (10)
  Transaction(
    id: 'transport1',
    title: 'Combustível',
    value: 120.00,
    date: now.subtract(const Duration(days: 10)),
    type: TransactionType.expense,
    categoryId: 'transport',
  ),
  Transaction(
    id: 'transport2',
    title: 'Táxi',
    value: 35.50,
    date: now.subtract(const Duration(days: 11)),
    type: TransactionType.expense,
    categoryId: 'transport',
  ),
  Transaction(
    id: 'transport3',
    title: 'Uber',
    value: 28.70,
    date: now.subtract(const Duration(days: 12)),
    type: TransactionType.expense,
    categoryId: 'transport',
  ),
  Transaction(
    id: 'transport4',
    title: 'Bilhete Ônibus',
    value: 4.40,
    date: now.subtract(const Duration(days: 13)),
    type: TransactionType.expense,
    categoryId: 'transport',
  ),
  Transaction(
    id: 'transport5',
    title: 'Estacionamento',
    value: 12.00,
    date: now.subtract(const Duration(days: 14)),
    type: TransactionType.expense,
    categoryId: 'transport',
  ),
];

final List<Category> defaultCategories = [
  Category(
    id: 'all',
    name: 'Tudo',
    icon: Icons.category,
    color: const Color.fromARGB(255, 110, 155, 115),
    type: CategoryType.expense,
  ),
  Category(
    id: 'food',
    name: 'Alimentação',
    icon: Icons.restaurant_menu,
    color: const Color.fromARGB(255, 226, 75, 74),
    type: CategoryType.expense,
  ),
  Category(
    id: 'transport',
    name: 'Transporte',
    icon: Icons.directions_car,
    color: const Color.fromARGB(255, 55, 138, 221),
    type: CategoryType.expense,
  ),
  Category(
    id: 'health',
    name: 'Saúde',
    icon: Icons.medical_services,
    color: const Color.fromARGB(255, 29, 158, 117),
    type: CategoryType.expense,
  ),
  Category(
    id: 'education',
    name: 'Educação',
    icon: Icons.school,
    color: const Color.fromARGB(255, 127, 119, 221),
    type: CategoryType.expense,
  ),
  Category(
    id: 'leisure',
    name: 'Lazer',
    icon: Icons.fitness_center,
    color: const Color.fromARGB(255, 239, 159, 39),
    type: CategoryType.expense,
  ),
  Category(
    id: 'shopping',
    name: 'Compras',
    icon: Icons.shopping_cart_sharp,
    color: const Color.fromARGB(255, 212, 83, 126),
    type: CategoryType.expense,
  ),
];
