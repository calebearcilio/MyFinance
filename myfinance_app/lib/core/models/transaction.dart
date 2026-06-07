import 'package:myfinance_app/core/models/category.dart';

enum TransactionType { income, expense }

class Transaction {
  late String id;
  final String title;
  final double value;
  final String? description;
  final DateTime date;
  final TransactionType type;
  late Category category;

  Transaction({
    required this.id,
    required this.title,
    required this.value,
    this.description,
    required this.date,
    required this.type,
    required this.category,
  });

  Transaction.insert({
    required this.title,
    required this.value,
    this.description,
    required this.date,
    required this.type,
    required String categoryId,
  }) {
    category.id = categoryId;
  }

  double get signedValue => type == TransactionType.income ? value : -value;

  Transaction copyWith({
    String? id,
    String? title,
    double? value,
    String? description,
    DateTime? date,
    TransactionType? type,
    Category? category,
  }) {
    return Transaction(
      id: id ?? this.id,
      title: title ?? this.title,
      value: value ?? this.value,
      description: description ?? this.description,
      date: date ?? this.date,
      type: type ?? this.type,
      category: category ?? this.category,
    );
  }

  @override
  String toString() {
    return 'Transaction(id: $id, title: $title, value: $value, description: $description, date: $date, type: $type, category:\n$category \n)';
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
        other.category == category;
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    value,
    description,
    date,
    type,
    category,
  );
}
