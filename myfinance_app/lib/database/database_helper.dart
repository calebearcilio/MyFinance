import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // instancia singleton da classe
  static final DatabaseHelper instance = DatabaseHelper._init();

  // instancia do SQLite
  static Database? _database;

  // construtor privado para garantir a existência de apenas uma instância
  DatabaseHelper._init();

  // getter da instânica do SQLite
  Future<Database> get database async {
    // condição para garantir instanciar apenas uma vez
    if (_database != null) return _database!;

    return await _initDatabase();
  }

  // método de inicialização do SQLite
  Future<Database> _initDatabase() async {
    // caminho para o arquivo do banco de dados
    final dbPath = await getDatabasesPath();

    // criação do arquivo do banco de dados
    final path = join(dbPath, "myfinance.db");

    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(_categoryCreateTableSQL);
    await db.execute(_transactionCreateTableSQL);
  }

  String get _categoryCreateTableSQL => """
    CREATE TABLE categories(
      id TEXT PRIMARY KEY
      name TEXT NOT NULL
      icon INTEGER NOT NULL
      color INTEGER NOT NULL
      type TEXT NOT NULL
        CHECK(type IN('income', 'expense'))
      created_at TEXT NOT NULL DEFAULT(datetime('now'))
    )
  """;

  String get _transactionCreateTableSQL => """
    CREATE TABLE IF NOT EXISTS transactions(
      id TEXT PRIMARY KEY,
      title TEXT NOT NULL,
      value REAL NOT NULL
        CHECK(value >= 0),
      description TEXT,
      date TEXT NOT NULL,
      type TEXT NOT NULL
        CHECK(type IN('income', 'expense')),
      category_id TEXT NOT NULL
      FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
    )
""";
}
