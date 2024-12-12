import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/file_item.dart';

class StorageService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'file_manager.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE files(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            path TEXT,
            category TEXT,
            dateAdded TEXT,
            fileType TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertFile(FileItem file) async {
    final db = await database;
    return await db.insert('files', file.toMap());
  }

  Future<List<FileItem>> getFilesByCategory(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'files',
      where: 'category = ?',
      whereArgs: [category],
    );

    return List.generate(maps.length, (i) {
      return FileItem.fromMap(maps[i]);
    });
  }

  Future<List<FileItem>> getAllFiles() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('files');

    return List.generate(maps.length, (i) {
      return FileItem.fromMap(maps[i]);
    });
  }

  Future<List<FileItem>> searchFiles(String query) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'files',
      where: 'name LIKE ? OR category LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );

    return List.generate(maps.length, (i) {
      return FileItem.fromMap(maps[i]);
    });
  }

  Future<void> deleteFile(int id) async {
    final db = await database;
    await db.delete(
      'files',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateFile(FileItem file) async {
    final db = await database;
    await db.update(
      'files',
      file.toMap(),
      where: 'id = ?',
      whereArgs: [file.id],
    );
  }

  Future<void> clearDatabase() async {
    final db = await database;
    await db.delete('files');
  }
}
