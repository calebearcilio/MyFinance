import 'package:drift/drift.dart';
import 'package:myfinance_app/core/database/tables/category_table.dart';
import 'package:myfinance_app/core/models/transaction/transaction.dart';
import 'package:uuid/uuid.dart';

@DataClassName('TransactionData')
class Transactions extends Table {
  /// Primary key da tabela
  TextColumn get id => text().clientDefault(() => Uuid().v1())();

  /// Título/descrição da transação
  TextColumn get title => text().withLength(min: 1, max: 255)();

  /// Descrição detalhada (opcional)
  TextColumn get description => text().nullable()();

  /// Valor da transação
  // ignore: recursive_getters
  RealColumn get value => real().check(value.isBiggerOrEqualValue(0))();
  //  RealColumn get value => real().customConstraint('CHECK (estoque >= 0)')();

  /// Data da transação
  DateTimeColumn get date => dateTime()();

  /// Tipo: 'income' ou 'expense'
  TextColumn get type => textEnum<TransactionType>()();

  /// Foreign key para Categories
  TextColumn get categoryId =>
      text().references(Categories, #id, onDelete: KeyAction.restrict)();

  /// Timestamp de criação
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Timestamp de atualização
  DateTimeColumn get updatedAt =>
      dateTime().clientDefault(() => DateTime.now())();

  @override
  String get tableName => 'transactions';

  @override
  Set<Column> get primaryKey => {id};
}
