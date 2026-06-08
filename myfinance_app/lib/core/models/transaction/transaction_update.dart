// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:myfinance_app/core/models/transaction/transaction.dart';

class TransactionUpdate {
  final String id;
  final String title;
  final double value;
  final String description;
  final DateTime date;
  final TransactionType type;
  final String categoryId;

  TransactionUpdate({
    required this.id,
    required this.title,
    required this.value,
    required this.description,
    required this.date,
    required this.type,
    required this.categoryId,
  });

  TransactionUpdate copyWith({
    String? id,
    String? title,
    double? value,
    String? description,
    DateTime? date,
    TransactionType? type,
    String? categoryId,
  }) {
    return TransactionUpdate(
      id: id ?? this.id,
      title: title ?? this.title,
      value: value ?? this.value,
      description: description ?? this.description,
      date: date ?? this.date,
      type: type ?? this.type,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  @override
  String toString() {
    return 'TransactionUpdate(id: $id, title: $title, value: $value, description: $description, date: $date, type: $type, categoryId: $categoryId)';
  }

  @override
  bool operator ==(covariant TransactionUpdate other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.value == value &&
      other.description == description &&
      other.date == date &&
      other.type == type &&
      other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      value.hashCode ^
      description.hashCode ^
      date.hashCode ^
      type.hashCode ^
      categoryId.hashCode;
  }
}
