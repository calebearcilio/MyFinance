import 'package:drift/drift.dart';
import 'package:myfinance_app/core/database/converters/color_converter.dart';
import 'package:myfinance_app/core/database/converters/icon_converter.dart';
import 'package:myfinance_app/core/models/category.dart';
import 'package:uuid/uuid.dart';

@DataClassName('CategoryData')
class Categories extends Table {
  /// Primary key da tabela
  TextColumn get id => text().clientDefault(() => Uuid().v1())();

  /// Nome da categoria
  TextColumn get name => text().withLength(min: 1, max: 100)();

  /// Código do ícone Material Icons (codePoint)
  IntColumn get icon => integer().map(const IconConverter())();

  /// Valor ARGB32 da cor
  IntColumn get color => integer().map(const ColorConverter())();

  /// Tipo: 'income' ou 'expense'
  TextColumn get type => textEnum<CategoryType>()();

  /// Validar se é padrão ou não
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();

  /// Timestamp de criação
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Timestamp de atualização
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  String get tableName => 'categories';

  @override
  Set<Column> get primaryKey => {id};
}
