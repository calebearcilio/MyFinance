// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/painting.dart';
import 'package:my_finance/core/models/transaction_type.dart';

class Category {
  final String id;
  final String name;
  final TransactionType type;
  final String emoji;
  final String _corHex;

  Category({
    required this.id,
    required this.name,
    required this.type,
    required this.emoji,
    required this._corHex,
  });

  Color get color => Color(int.parse(_corHex.replaceFirst("#", "0xFF")));

  set color(Color color) {
    _corHex = color;
  }

  Category copyWith({
    String? id,
    String? name,
    TransactionType? type,
    String? emoji,
    String? corHex,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      emoji: emoji ?? this.emoji,
      corHex: corHex ?? _corHex,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'type': type.toString(),
      'emoji': emoji,
      'color': _corHex,
    };
  }

  factory Category.fromMap(String id, Map<String, dynamic> map) {
    return Category(
      id: id,
      name: map['name'] as String,
      type: map['type'] as TransactionType,
      emoji: map['emoji'] as String,
      corHex: map['color'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String id, String source) =>
      Category.fromMap(id, json.decode(source));

  @override
  String toString() {
    return 'Category(id: $id, name: $name, type: $type, emoji: $emoji, corHex: $_corHex)';
  }

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.type == type &&
        other.emoji == emoji &&
        other._corHex == _corHex;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        type.hashCode ^
        emoji.hashCode ^
        _corHex.hashCode;
  }
}
