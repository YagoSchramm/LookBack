import 'package:look_back/domain/services/storage.dart';
import 'package:look_back/entities/database/look_back_database.dart';
import 'package:look_back/entities/database/tables/memory_table.dart';
import 'package:look_back/entities/models/memory.dart';
import 'package:sqflite/sqflite.dart';

class _StorageService implements StorageService {
  final LookBackDatabase _database;

  _StorageService(this._database);

  @override
  Future<int> createMemory(Memory memory) async {
    try {
      final db = await _database.database;
      int id = await db.insert(MemoryTable.tableName, memory.toJSON());
      return id;
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<Memory>?> listAllMemories() async {
    try {
      final db = await _database.database;
      final List<Map<String, dynamic>> data = await db.query(
        MemoryTable.tableName,
        orderBy: '${MemoryTable.columnCreatedAt} DESC',
      );
      if (data.isEmpty) return null;
      return data.map((map) => Memory.fromMap(map)).toList();
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<Memory?> getMemoryById(int id) async {
    try {
      final db = await _database.database;
      final List<Map<String, dynamic>> data = await db.query(
        MemoryTable.tableName,
        where: '${MemoryTable.columnID} = ?',
        whereArgs: [id],
      );
      if (data.isEmpty) return null;
      return Memory.fromMap(data.first);
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> updateMemory(Memory memory) async {
    try {
      final db = await _database.database;
      await db.update(
        MemoryTable.tableName,
        memory.toJSON(),
        where: '${MemoryTable.columnID} = ?',
        whereArgs: [memory.id],
      );
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deleteMemory(int id) async {
    try {
      final db = await _database.database;
      await db.delete(
        MemoryTable.tableName,
        where: '${MemoryTable.columnID} = ?',
        whereArgs: [id],
      );
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<Memory>?> searchMemoriesByTitle(String title) async {
    try {
      final db = await _database.database;
      final List<Map<String, dynamic>> data = await db.query(
        MemoryTable.tableName,
        where: '${MemoryTable.columnTitle} LIKE ?',
        whereArgs: ['%$title%'],
        orderBy: '${MemoryTable.columnCreatedAt} DESC',
      );
      if (data.isEmpty) return null;
      return data.map((map) => Memory.fromMap(map)).toList();
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<int> countMemories() async {
    try {
      final db = await _database.database;
      final result = await db.rawQuery('SELECT COUNT(*) as count FROM ${MemoryTable.tableName}');
      return Sqflite.firstIntValue(result) ?? 0;
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAllMemories() async {
    try {
      final db = await _database.database;
      await db.delete(MemoryTable.tableName);
    } on Exception catch (_) {
      rethrow;
    }
  }
}

/// Factory para criar uma nova instância do StorageService
StorageService newStorageService() {
  return _StorageService(LookBackDatabase());
}
