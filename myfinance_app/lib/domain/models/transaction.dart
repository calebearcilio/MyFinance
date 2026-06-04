// import 'dart:convert';

enum TransactionType { income, expense }

/// Modelo de domínio para Transaction
/// Mantém a compatibilidade com a camada de apresentação
class Transaction {
  final String id;
  final String title;
  final double value;
  final String? description;
  final DateTime date;
  final TransactionType type;
  final String categoryId;

  Transaction({
    required this.id,
    required this.title,
    required this.value,
    this.description,
    required this.date,
    required this.type,
    required this.categoryId,
  });

  /// Factory para criar Transaction a partir de TransactionData do Drift
  factory Transaction.fromDriftData({
    required String id,
    required String title,
    required String? description,
    required double value,
    required DateTime date,
    required TransactionType type,
    required String categoryId,
  }) {
    return Transaction(
      id: id,
      title: title,
      description: description,
      value: value, // Converter cents para double
      date: date,
      type: type,
      categoryId: categoryId,
    );
  }

  /// Helper para retornar o valor com sinal
  double get signedValue => type == TransactionType.income ? value : -value;

  /// Converter value (double) para amountInCents (int)
  int get amountInCents => (value * 100).round();

  Transaction copyWith({
    String? id,
    String? title,
    double? value,
    String? description,
    DateTime? date,
    TransactionType? type,
    String? categoryId,
  }) {
    return Transaction(
      id: id ?? this.id,
      title: title ?? this.title,
      value: value ?? this.value,
      description: description ?? this.description,
      date: date ?? this.date,
      type: type ?? this.type,
      categoryId: categoryId ?? this.categoryId,
    );
  }
/*
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'value': value,
      'description': description,
      'date': date.toIso8601String(),
      'type': type.name,
      'category_id': categoryId,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] as String,
      title: map['title'] as String,
      value: (map['value'] as num).toDouble(),
      description: map['description'] as String?,
      date: DateTime.parse(map['date'] as String),
      type: TransactionType.values.byName(map['type'] as String),
      categoryId: map['category_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source) as Map<String, dynamic>);
*/
  @override
  String toString() {
    return 'Transaction(id: $id, title: $title, value: $value, description: $description, date: $date, type: $type, categoryId: $categoryId)';
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
        other.categoryId == categoryId;
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    value,
    description,
    date,
    type,
    categoryId,
  );
}
