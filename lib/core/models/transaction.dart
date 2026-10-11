// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:my_finance/core/models/category.dart';
import 'package:my_finance/core/models/transaction_type.dart';

class Transaction {
  final String id;
  final String title;
  final String? description;
  final double value;
  final Category category;
  final DateTime date;
  final TransactionType type;
  Transaction({
    required this.id,
    required this.title,
    this.description,
    required this.value,
    required this.category,
    required this.date,
    required this.type,
  });

  Transaction copyWith({
    String? id,
    String? title,
    String? description,
    double? value,
    Category? category,
    DateTime? date,
    TransactionType? type,
  }) {
    return Transaction(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      value: value ?? this.value,
      category: category ?? this.category,
      date: date ?? this.date,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'value': value,
      'category': category.id,
      'date': date.millisecondsSinceEpoch,
      'type': type.toString(),
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] != null ? map['description'] as String : null,
      value: map['value'] as double,
      category: map['category'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      type: map['type'] as TransactionType,
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) => Transaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Transaction(id: $id, title: $title, description: $description, value: $value, category: $category, date: $date, type: $type)';
  }

  @override
  bool operator ==(covariant Transaction other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.description == description &&
      other.value == value &&
      other.category == category &&
      other.date == date &&
      other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      value.hashCode ^
      category.hashCode ^
      date.hashCode ^
      type.hashCode;
  }
}
