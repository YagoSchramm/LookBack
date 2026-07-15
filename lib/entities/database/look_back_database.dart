import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'tables/memory_table.dart';

class LookBackDatabase {
  // Construtor privado para singleton
  LookBackDatabase._internal();

  static final LookBackDatabase _instance = LookBackDatabase._internal();

  factory LookBackDatabase() => _instance;

  static Database? _database; // Cache da conexão
  static const int _databaseVersion = 1;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'look_back.db');

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(MemoryTable.createMemoryTable());
  }

  /// Fecha a conexão com o banco de dados
  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
