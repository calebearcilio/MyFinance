// ignore_for_file: non_const_argument_for_const_parameter

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

class IconConverter extends TypeConverter<IconData, int> {
  const IconConverter();

  @override
  IconData fromSql(int fromDb) => IconData(fromDb, fontFamily: "MaterialIcons");

  @override
  int toSql(IconData value) => value.codePoint;
}
