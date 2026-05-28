import 'dart:convert';

enum TransactionType { income, expense }

class Transaction {
  final String id;
  final String title;
  final double value;
  final String? description;
  final DateTime date;
  final TransactionType type;
  final String categoryId;
  final String userId;

  Transaction({
    required this.id,
    required this.title,
    required this.value,
    this.description,
    required this.date,
    required this.type,
    required this.categoryId,
    required this.userId,
  });

  Transaction copyWith({
    String? id,
    String? title,
    double? value,
    String? description,
    DateTime? date,
    TransactionType? type,
    String? categoryId,
    String? userId,
  }) {
    return Transaction(
      id: id ?? this.id,
      title: title ?? this.title,
      value: value ?? this.value,
      description: description ?? this.description,
      date: date ?? this.date,
      type: type ?? this.type,
      categoryId: categoryId ?? this.categoryId,
      userId: userId ?? this.userId,
    );
  }

  /// helper para retornar o valor com sinal
  double get signedValue => type == TransactionType.income ? value : -value;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'value': value,
      'description': description,
      'date': date.toIso8601String(),
      'type': type.name,
      'category_id': categoryId,
      'user_id': userId,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] as String,
      title: map['title'] as String,
      value: (map['value'] as num).toDouble(),
      description: map['description'] as String?,
      date: DateTime.parse(map["date"] as String),
      type: TransactionType.values.byName(map["type"] as String),
      categoryId: map['category_id'] as String,
      userId: map['user_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Transaction(id: $id, title: $title, value: $value, description: $description, date: $date, type: $type, categoryId: $categoryId, userId: $userId)';
  }

  @override
  bool operator ==(covariant Transaction other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.value == value &&
        other.description == description &&
        other.date == date &&
        other.type == type &&
        other.categoryId == categoryId &&
        other.userId == userId;
  }

  @override
  int get hashCode => Object.hash(id, title, value, description, date, type, categoryId, userId);
}

final now = DateTime.now();
final List<Transaction> dummyTransactions = [
  // Food (10)
  Transaction(
    id: 'food1',
    title: 'Café',
    value: 6.50,
    date: now.subtract(const Duration(days: 0)),
    type: .expense,
    userId: "",
    categoryId: 'food',
  ),
  Transaction(
    id: 'food2',
    title: 'Almoço',
    value: 22.30,
    date: now.subtract(const Duration(days: 1)),
    type: .expense,
    userId: "",
    categoryId: 'food',
  ),
  Transaction(
    id: 'food3',
    title: 'Jantar',
    value: 45.00,
    date: now.subtract(const Duration(days: 2)),
    type: .expense,
    userId: "",
    categoryId: 'food',
  ),
  Transaction(
    id: 'food4',
    title: 'Lanche',
    value: 12.00,
    date: now.subtract(const Duration(days: 3)),
    type: .expense,
    userId: "",
    categoryId: 'food',
  ),
  Transaction(
    id: 'food5',
    title: 'Supermercado',
    value: 150.75,
    date: now.subtract(const Duration(days: 4)),
    type: .expense,
    userId: "",
    categoryId: 'food',
  ),
  Transaction(
    id: 'food6',
    title: 'Padaria',
    value: 8.90,
    date: now.subtract(const Duration(days: 5)),
    type: .expense,
    userId: "",
    categoryId: 'food',
  ),
  Transaction(
    id: 'food7',
    title: 'Delivery',
    value: 39.20,
    date: now.subtract(const Duration(days: 6)),
    type: .expense,
    userId: "",
    categoryId: 'food',
  ),
  Transaction(
    id: 'food8',
    title: 'Bebidas',
    value: 18.00,
    date: now.subtract(const Duration(days: 7)),
    type: .expense,
    userId: "",
    categoryId: 'food',
  ),
  Transaction(
    id: 'food9',
    title: 'Mercado Hortifruti',
    value: 62.10,
    date: now.subtract(const Duration(days: 8)),
    type: .expense,
    userId: "",
    categoryId: 'food',
  ),
  Transaction(
    id: 'food10',
    title: 'Restaurante',
    value: 88.40,
    date: now.subtract(const Duration(days: 9)),
    type: .expense,
    userId: "",
    categoryId: 'food',
  ),

  // Transport (10)
  Transaction(
    id: 'transport1',
    title: 'Combustível',
    value: 120.00,
    date: now.subtract(const Duration(days: 10)),
    type: .expense,
    userId: "",
    categoryId: 'transport',
  ),
  Transaction(
    id: 'transport2',
    title: 'Táxi',
    value: 35.50,
    date: now.subtract(const Duration(days: 11)),
    type: .expense,
    userId: "",
    categoryId: 'transport',
  ),
  Transaction(
    id: 'transport3',
    title: 'Uber',
    value: 28.70,
    date: now.subtract(const Duration(days: 12)),
    type: .expense,
    userId: "",
    categoryId: 'transport',
  ),
  Transaction(
    id: 'transport4',
    title: 'Bilhete Ônibus',
    value: 4.40,
    date: now.subtract(const Duration(days: 13)),
    type: .expense,
    userId: "",
    categoryId: 'transport',
  ),
  Transaction(
    id: 'transport5',
    title: 'Estacionamento',
    value: 12.00,
    date: now.subtract(const Duration(days: 14)),
    type: .expense,
    userId: "",
    categoryId: 'transport',
  ),
  Transaction(
    id: 'transport6',
    title: 'Manutenção Carro',
    value: 300.00,
    date: now.subtract(const Duration(days: 15)),
    type: .expense,
    userId: "",
    categoryId: 'transport',
  ),
  Transaction(
    id: 'transport7',
    title: 'Peças',
    value: 85.99,
    date: now.subtract(const Duration(days: 16)),
    type: .expense,
    userId: "",
    categoryId: 'transport',
  ),
  Transaction(
    id: 'transport8',
    title: 'Lavagem',
    value: 25.00,
    date: now.subtract(const Duration(days: 17)),
    type: .expense,
    userId: "",
    categoryId: 'transport',
  ),
  Transaction(
    id: 'transport9',
    title: 'IPVA',
    value: 600.00,
    date: now.subtract(const Duration(days: 18)),
    type: .expense,
    userId: "",
    categoryId: 'transport',
  ),
  Transaction(
    id: 'transport10',
    title: 'Pedágio',
    value: 9.20,
    date: now.subtract(const Duration(days: 404)),
    type: .expense,
    userId: "",
    categoryId: 'transport',
  ),

  // Health (10)
  Transaction(
    id: 'health1',
    title: 'Consulta Médica',
    value: 120.00,
    date: now.subtract(const Duration(days: 20)),
    type: .expense,
    userId: "",
    categoryId: 'health',
  ),
  Transaction(
    id: 'health2',
    title: 'Remédio',
    value: 32.50,
    date: now.subtract(const Duration(days: 21)),
    type: .expense,
    userId: "",
    categoryId: 'health',
  ),
  Transaction(
    id: 'health3',
    title: 'Exames',
    value: 200.00,
    date: now.subtract(const Duration(days: 22)),
    type: .expense,
    userId: "",
    categoryId: 'health',
  ),
  Transaction(
    id: 'health4',
    title: 'Fisioterapia',
    value: 75.00,
    date: now.subtract(const Duration(days: 23)),
    type: .expense,
    userId: "",
    categoryId: 'health',
  ),
  Transaction(
    id: 'health5',
    title: 'Vacina',
    value: 95.00,
    date: now.subtract(const Duration(days: 24)),
    type: .expense,
    userId: "",
    categoryId: 'health',
  ),
  Transaction(
    id: 'health6',
    title: 'Óculos',
    value: 250.00,
    date: now.subtract(const Duration(days: 25)),
    type: .expense,
    userId: "",
    categoryId: 'health',
  ),
  Transaction(
    id: 'health7',
    title: 'Dentista',
    value: 180.00,
    date: now.subtract(const Duration(days: 26)),
    type: .expense,
    userId: "",
    categoryId: 'health',
  ),
  Transaction(
    id: 'health8',
    title: 'Suplementos',
    value: 89.90,
    date: now.subtract(const Duration(days: 27)),
    type: .expense,
    userId: "",
    categoryId: 'health',
  ),
  Transaction(
    id: 'health9',
    title: 'Psicólogo',
    value: 150.00,
    date: now.subtract(const Duration(days: 28)),
    type: .expense,
    userId: "",
    categoryId: 'health',
  ),
  Transaction(
    id: 'health10',
    title: 'Clínica',
    value: 220.00,
    date: now.subtract(const Duration(days: 403)),
    type: .expense,
    userId: "",
    categoryId: 'health',
  ),

  // Education (10)
  Transaction(
    id: 'education1',
    title: 'Curso Online',
    value: 59.90,
    date: now.subtract(const Duration(days: 30)),
    type: .expense,
    userId: "",
    categoryId: 'education',
  ),
  Transaction(
    id: 'education2',
    title: 'Livro',
    value: 45.00,
    date: now.subtract(const Duration(days: 31)),
    type: .expense,
    userId: "",
    categoryId: 'education',
  ),
  Transaction(
    id: 'education3',
    title: 'Material Escolar',
    value: 32.20,
    date: now.subtract(const Duration(days: 32)),
    type: .expense,
    userId: "",
    categoryId: 'education',
  ),
  Transaction(
    id: 'education4',
    title: 'Mensalidade',
    value: 800.00,
    date: now.subtract(const Duration(days: 33)),
    type: .expense,
    userId: "",
    categoryId: 'education',
  ),
  Transaction(
    id: 'education5',
    title: 'Palestra',
    value: 120.00,
    date: now.subtract(const Duration(days: 34)),
    type: .expense,
    userId: "",
    categoryId: 'education',
  ),
  Transaction(
    id: 'education6',
    title: 'Workshop',
    value: 200.00,
    date: now.subtract(const Duration(days: 35)),
    type: .expense,
    userId: "",
    categoryId: 'education',
  ),
  Transaction(
    id: 'education7',
    title: 'Certificação',
    value: 350.00,
    date: now.subtract(const Duration(days: 36)),
    type: .expense,
    userId: "",
    categoryId: 'education',
  ),
  Transaction(
    id: 'education8',
    title: 'Tutor',
    value: 90.00,
    date: now.subtract(const Duration(days: 37)),
    type: .expense,
    userId: "",
    categoryId: 'education',
  ),
  Transaction(
    id: 'education9',
    title: 'Software Educacional',
    value: 29.99,
    date: now.subtract(const Duration(days: 38)),
    type: .expense,
    userId: "",
    categoryId: 'education',
  ),
  Transaction(
    id: 'education10',
    title: 'Inscrição',
    value: 45.00,
    date: now.subtract(const Duration(days: 402)),
    type: .expense,
    userId: "",
    categoryId: 'education',
  ),

  // Leisure (10)
  Transaction(
    id: 'leisure1',
    title: 'Cinema',
    value: 28.00,
    date: now.subtract(const Duration(days: 40)),
    type: .expense,
    userId: "",
    categoryId: 'leisure',
  ),
  Transaction(
    id: 'leisure2',
    title: 'Academia',
    value: 120.00,
    date: now.subtract(const Duration(days: 41)),
    type: .expense,
    userId: "",
    categoryId: 'leisure',
  ),
  Transaction(
    id: 'leisure3',
    title: 'Show',
    value: 180.00,
    date: now.subtract(const Duration(days: 42)),
    type: .expense,
    userId: "",
    categoryId: 'leisure',
  ),
  Transaction(
    id: 'leisure4',
    title: 'Parque',
    value: 15.00,
    date: now.subtract(const Duration(days: 43)),
    type: .expense,
    userId: "",
    categoryId: 'leisure',
  ),
  Transaction(
    id: 'leisure5',
    title: 'Viagem',
    value: 720.00,
    date: now.subtract(const Duration(days: 44)),
    type: .expense,
    userId: "",
    categoryId: 'leisure',
  ),
  Transaction(
    id: 'leisure6',
    title: 'Bar',
    value: 95.00,
    date: now.subtract(const Duration(days: 45)),
    type: .expense,
    userId: "",
    categoryId: 'leisure',
  ),
  Transaction(
    id: 'leisure7',
    title: 'Museu',
    value: 20.00,
    date: now.subtract(const Duration(days: 46)),
    type: .expense,
    userId: "",
    categoryId: 'leisure',
  ),
  Transaction(
    id: 'leisure8',
    title: 'Passeio',
    value: 60.00,
    date: now.subtract(const Duration(days: 47)),
    type: .expense,
    userId: "",
    categoryId: 'leisure',
  ),
  Transaction(
    id: 'leisure9',
    title: 'Evento',
    value: 130.00,
    date: now.subtract(const Duration(days: 48)),
    type: .expense,
    userId: "",
    categoryId: 'leisure',
  ),
  Transaction(
    id: 'leisure10',
    title: 'Aula de Dança',
    value: 70.00,
    date: now.subtract(const Duration(days: 401)),
    type: .expense,
    userId: "",
    categoryId: 'leisure',
  ),

  // Shopping (10)
  Transaction(
    id: 'shopping1',
    title: 'Celular',
    description: 'Compra online',
    value: 1365.12,
    date: now.subtract(const Duration(days: 50)),
    type: .expense,
    userId: "",
    categoryId: 'shopping',
  ),
  Transaction(
    id: 'shopping2',
    title: 'Notebook',
    value: 2823.91,
    date: now.subtract(const Duration(days: 51)),
    type: .expense,
    userId: "",
    categoryId: 'shopping',
  ),
  Transaction(
    id: 'shopping3',
    title: 'Mouse',
    value: 63.37,
    date: now.subtract(const Duration(days: 52)),
    type: .expense,
    userId: "",
    categoryId: 'shopping',
  ),
  Transaction(
    id: 'shopping4',
    title: 'Mausepad',
    value: 23.45,
    date: now.subtract(const Duration(days: 53)),
    type: .expense,
    userId: "",
    categoryId: 'shopping',
  ),
  Transaction(
    id: 'shopping5',
    title: 'Monitor',
    value: 845.75,
    date: now.subtract(const Duration(days: 54)),
    type: .expense,
    userId: "",
    categoryId: 'shopping',
  ),
  Transaction(
    id: 'shopping6',
    title: 'Teclado',
    value: 325.68,
    date: now.subtract(const Duration(days: 55)),
    type: .expense,
    userId: "",
    categoryId: 'shopping',
  ),
  Transaction(
    id: 'shopping7',
    title: 'Camiseta',
    value: 49.90,
    date: now.subtract(const Duration(days: 56)),
    type: .expense,
    userId: "",
    categoryId: 'shopping',
  ),
  Transaction(
    id: 'shopping8',
    title: 'Tênis',
    value: 199.99,
    date: now.subtract(const Duration(days: 57)),
    type: .expense,
    userId: "",
    categoryId: 'shopping',
  ),
  Transaction(
    id: 'shopping9',
    title: 'Relógio',
    value: 499.00,
    date: now.subtract(const Duration(days: 58)),
    type: .expense,
    userId: "",
    categoryId: 'shopping',
  ),
  Transaction(
    id: 'shopping10',
    title: 'Acessórios',
    value: 59.90,
    date: now.subtract(const Duration(days: 400)),
    type: .expense,
    userId: "",
    categoryId: 'shopping',
  ),
];
