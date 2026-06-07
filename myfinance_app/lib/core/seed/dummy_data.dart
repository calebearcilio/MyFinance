import 'package:drift/drift.dart';
import 'package:myfinance_app/core/database/app_database.dart';

final now = DateTime.now();

/// Dados fictícios para testes durante desenvolvimento
/// Estes dados podem ser seedados no banco via seedInitialData()
/// 
class DummyTransactions {
  static final List<TransactionsCompanion> income = [
  // Salary
  TransactionsCompanion.insert(
    id: Value('salary1'),
    title: 'Salário',
    value: 2500,
    date: now.subtract(Duration(days: 0)),
    categoryId: 'salary',
    type: .income
  ),
  TransactionsCompanion.insert(
    id: Value('salary2'),
    title: 'Salário',
    value: 2500,
    date: now.subtract(Duration(days: 30)),
    categoryId: 'salary',
    type: .income
  ),
  TransactionsCompanion.insert(
    id: Value('salary3'),
    title: 'Salário',
    value: 2500,
    date: now.subtract(Duration(days: 60)),
    categoryId: 'salary',
    type: .income
  ),
  TransactionsCompanion.insert(
    id: Value('salary4'),
    title: 'Salário',
    value: 2500,
    date: now.subtract(Duration(days: 90)),
    categoryId: 'salary',
    type: .income
  ),
  
  // Investments (4)
  TransactionsCompanion.insert(
    id: Value('investment1'),
    title: 'Investimento',
    value: 731,
    date: now.subtract(Duration(days: 0)),
    categoryId: 'investment',
    type: .income
  ),
  TransactionsCompanion.insert(
    id: Value('investment2'),
    title: 'Investimento',
    value: 580,
    date: now.subtract(Duration(days: 30)),
    categoryId: 'investment',
    type: .income
  ),
  TransactionsCompanion.insert(
    id: Value('investment3'),
    title: 'Investimento',
    value: 863,
    date: now.subtract(Duration(days: 60)),
    categoryId: 'investment',
    type: .income
  ),
  TransactionsCompanion.insert(
    id: Value('investment4'),
    title: 'Investimento',
    value: 462,
    date: now.subtract(Duration(days: 90)),
    categoryId: 'investment',
    type: .income
  ),

  // Bonus (4)
  TransactionsCompanion.insert(
    id: Value('bonus1'),
    title: 'Bônus',
    value: 36,
    date: now.subtract(Duration(days: 6)),
    categoryId: 'bonus',
    type: .income
  ),
  TransactionsCompanion.insert(
    id: Value('bonus2'),
    title: 'Bônus',
    value: 60,
    date: now.subtract(Duration(days: 12)),
    categoryId: 'bonus',
    type: .income
  ),
  TransactionsCompanion.insert(
    id: Value('bonus3'),
    title: 'Bônus',
    value: 30,
    date: now.subtract(Duration(days: 14)),
    categoryId: 'bonus',
    type: .income
  ),
  TransactionsCompanion.insert(
    id: Value('bonus4'),
    title: 'Bônus',
    value: 55,
    date: now.subtract(Duration(days: 17)),
    categoryId: 'bonus',
    type: .income
  ),
  ];
  static final List<TransactionsCompanion> expenses = [
  // Food (10)
  TransactionsCompanion.insert(
    id: Value('food1'),
    title: 'Café',
    value: 6.50,
    date: now.subtract(Duration(days: 0)),
    categoryId: 'food',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('food2'),
    title: 'Almoço',
    value: 22.30,
    date: now.subtract(Duration(days: 1)),
    categoryId: 'food',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('food3'),
    title: 'Jantar',
    value: 45.00,
    date: now.subtract(Duration(days: 2)),
    categoryId: 'food',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('food4'),
    title: 'Lanche',
    value: 12.00,
    date: now.subtract(Duration(days: 3)),
    categoryId: 'food',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('food5'),
    title: 'Supermercado',
    value: 150.75,
    date: now.subtract(Duration(days: 4)),
    categoryId: 'food',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('food6'),
    title: 'Padaria',
    value: 8.90,
    date: now.subtract(Duration(days: 5)),
    categoryId: 'food',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('food7'),
    title: 'Delivery',
    value: 39.20,
    date: now.subtract(Duration(days: 6)),
    categoryId: 'food',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('food8'),
    title: 'Bebidas',
    value: 18.00,
    date: now.subtract(Duration(days: 7)),
    categoryId: 'food',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('food9'),
    title: 'Mercado Hortifruti',
    value: 62.10,
    date: now.subtract(Duration(days: 8)),
    categoryId: 'food',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('food10'),
    title: 'Restaurante',
    value: 88.40,
    date: now.subtract(Duration(days: 9)),
    categoryId: 'food',
    type: .expense
  ),

  // Transport (10)
  TransactionsCompanion.insert(
    id: Value('transport1'),
    title: 'Combustível',
    value: 120.00,
    date: now.subtract(Duration(days: 10)),
    categoryId: 'transport',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('transport2'),
    title: 'Táxi',
    value: 35.50,
    date: now.subtract(Duration(days: 11)),
    categoryId: 'transport',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('transport3'),
    title: 'Uber',
    value: 28.70,
    date: now.subtract(Duration(days: 12)),
    categoryId: 'transport',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('transport4'),
    title: 'Bilhete Ônibus',
    value: 4.40,
    date: now.subtract(Duration(days: 13)),
    categoryId: 'transport',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('transport5'),
    title: 'Estacionamento',
    value: 12.00,
    date: now.subtract(Duration(days: 14)),
    categoryId: 'transport',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('transport6'),
    title: 'Manutenção Carro',
    value: 300.00,
    date: now.subtract(Duration(days: 15)),
    categoryId: 'transport',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('transport7'),
    title: 'Peças',
    value: 85.99,
    date: now.subtract(Duration(days: 16)),
    categoryId: 'transport',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('transport8'),
    title: 'Lavagem',
    value: 25.00,
    date: now.subtract(Duration(days: 17)),
    categoryId: 'transport',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('transport9'),
    title: 'IPVA',
    value: 600.00,
    date: now.subtract(Duration(days: 18)),
    categoryId: 'transport',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('transport10'),
    title: 'Pedágio',
    value: 9.20,
    date: now.subtract(Duration(days: 19)),
    categoryId: 'transport',
    type: .expense
  ),

  // Health (10)
  TransactionsCompanion.insert(
    id: Value('health1'),
    title: 'Consulta Médica',
    value: 120.00,
    date: now.subtract(Duration(days: 20)),
    categoryId: 'health',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('health2'),
    title: 'Remédio',
    value: 32.50,
    date: now.subtract(Duration(days: 21)),
    categoryId: 'health',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('health3'),
    title: 'Exames',
    value: 200.00,
    date: now.subtract(Duration(days: 22)),
    categoryId: 'health',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('health4'),
    title: 'Fisioterapia',
    value: 75.00,
    date: now.subtract(Duration(days: 23)),
    categoryId: 'health',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('health5'),
    title: 'Vacina',
    value: 95.00,
    date: now.subtract(Duration(days: 24)),
    categoryId: 'health',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('health6'),
    title: 'Óculos',
    value: 250.00,
    date: now.subtract(Duration(days: 25)),
    categoryId: 'health',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('health7'),
    title: 'Dentista',
    value: 180.00,
    date: now.subtract(Duration(days: 26)),
    categoryId: 'health',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('health8'),
    title: 'Suplementos',
    value: 89.90,
    date: now.subtract(Duration(days: 27)),
    categoryId: 'health',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('health9'),
    title: 'Psicólogo',
    value: 150.00,
    date: now.subtract(Duration(days: 28)),
    categoryId: 'health',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('health10'),
    title: 'Clínica',
    value: 220.00,
    date: now.subtract(Duration(days: 29)),
    categoryId: 'health',
    type: .expense
  ),

  // Education (10)
  TransactionsCompanion.insert(
    id: Value('education1'),
    title: 'Curso Online',
    value: 59.90,
    date: now.subtract(Duration(days: 30)),
    categoryId: 'education',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('education2'),
    title: 'Livro',
    value: 45.00,
    date: now.subtract(Duration(days: 31)),
    categoryId: 'education',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('education3'),
    title: 'Material Escolar',
    value: 32.20,
    date: now.subtract(Duration(days: 32)),
    categoryId: 'education',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('education4'),
    title: 'Mensalidade',
    value: 800.00,
    date: now.subtract(Duration(days: 33)),
    categoryId: 'education',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('education5'),
    title: 'Palestra',
    value: 120.00,
    date: now.subtract(Duration(days: 34)),
    categoryId: 'education',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('education6'),
    title: 'Workshop',
    value: 200.00,
    date: now.subtract(Duration(days: 35)),
    categoryId: 'education',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('education7'),
    title: 'Certificação',
    value: 350.00,
    date: now.subtract(Duration(days: 36)),
    categoryId: 'education',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('education8'),
    title: 'Tutor',
    value: 90.00,
    date: now.subtract(Duration(days: 37)),
    categoryId: 'education',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('education9'),
    title: 'Software Educacional',
    value: 29.99,
    date: now.subtract(Duration(days: 38)),
    categoryId: 'education',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('education10'),
    title: 'Inscrição',
    value: 45.00,
    date: now.subtract(Duration(days: 39)),
    categoryId: 'education',
    type: .expense
  ),

  // Leisure (10)
  TransactionsCompanion.insert(
    id: Value('leisure1'),
    title: 'Cinema',
    value: 28.00,
    date: now.subtract(Duration(days: 40)),
    categoryId: 'leisure',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('leisure2'),
    title: 'Academia',
    value: 120.00,
    date: now.subtract(Duration(days: 41)),
    categoryId: 'leisure',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('leisure3'),
    title: 'Show',
    value: 180.00,
    date: now.subtract(Duration(days: 42)),
    categoryId: 'leisure',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('leisure4'),
    title: 'Parque',
    value: 15.00,
    date: now.subtract(Duration(days: 43)),
    categoryId: 'leisure',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('leisure5'),
    title: 'Viagem',
    value: 720.00,
    date: now.subtract(Duration(days: 44)),
    categoryId: 'leisure',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('leisure6'),
    title: 'Bar',
    value: 95.00,
    date: now.subtract(Duration(days: 45)),
    categoryId: 'leisure',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('leisure7'),
    title: 'Museu',
    value: 20.00,
    date: now.subtract(Duration(days: 46)),
    categoryId: 'leisure',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('leisure8'),
    title: 'Passeio',
    value: 60.00,
    date: now.subtract(Duration(days: 47)),
    categoryId: 'leisure',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('leisure9'),
    title: 'Evento',
    value: 130.00,
    date: now.subtract(Duration(days: 48)),
    categoryId: 'leisure',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('leisure10'),
    title: 'Aula de Dança',
    value: 70.00,
    date: now.subtract(Duration(days: 49)),
    categoryId: 'leisure',
    type: .expense
  ),

  // Shopping (10)
  TransactionsCompanion.insert(
    id: Value('shopping1'),
    title: 'Celular',
    description: Value('Compra online'),
    value: 1365.12,
    date: now.subtract(Duration(days: 50)),
    categoryId: 'shopping',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('shopping2'),
    title: 'Notebook',
    value: 2823.91,
    date: now.subtract(Duration(days: 51)),
    categoryId: 'shopping',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('shopping3'),
    title: 'Mouse',
    value: 63.37,
    date: now.subtract(Duration(days: 52)),
    categoryId: 'shopping',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('shopping4'),
    title: 'Mausepad',
    value: 23.45,
    date: now.subtract(Duration(days: 53)),
    categoryId: 'shopping',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('shopping5'),
    title: 'Monitor',
    value: 845.75,
    date: now.subtract(Duration(days: 54)),
    categoryId: 'shopping',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('shopping6'),
    title: 'Teclado',
    value: 325.68,
    date: now.subtract(Duration(days: 55)),
    categoryId: 'shopping',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('shopping7'),
    title: 'Camiseta',
    value: 49.90,
    date: now.subtract(Duration(days: 56)),
    categoryId: 'shopping',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('shopping8'),
    title: 'Tênis',
    value: 199.99,
    date: now.subtract(Duration(days: 57)),
    categoryId: 'shopping',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('shopping9'),
    title: 'Relógio',
    value: 499.00,
    date: now.subtract(Duration(days: 58)),
    categoryId: 'shopping',
    type: .expense
  ),
  TransactionsCompanion.insert(
    id: Value('shopping10'),
    title: 'Acessórios',
    value: 59.90,
    date: now.subtract(Duration(days: 59)),
    categoryId: 'shopping',
    type: .expense
  ),
];
}