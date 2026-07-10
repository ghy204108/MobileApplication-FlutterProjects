import 'package:sqflite/sqflite.dart';

class DatabaseService {
  // Create table
  static Future<void> createTable(Database database) async {
    await database.execute("""
      CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT
      )
    """);
  }

  // Open database
  static Future<Database> db() async {
    return openDatabase(
      'notes.db',
      version: 1,
      onCreate: (Database database, int version) async {
        await createTable(database);
      },
    );
  }

  // Create: add a new note
  static Future<int> createItem(String title, String description) async {
    final db = await DatabaseService.db();

    final data = {
      'title': title,
      'description': description,
    };

    final id = await db.insert(
      'items',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return id;
  }

  // Read: get all notes
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await DatabaseService.db();

    return db.query(
      'items',
      orderBy: 'id',
    );
  }

  // Update: edit an existing note
  static Future<int> updateItem(
    int id,
    String title,
    String description,
  ) async {
    final db = await DatabaseService.db();

    final data = {
      'title': title,
      'description': description,
    };

    final result = await db.update(
      'items',
      data,
      where: 'id = ?',
      whereArgs: [id],
    );

    return result;
  }

  // Delete: remove a note
  static Future<void> deleteItem(int id) async {
    final db = await DatabaseService.db();

    try {
      await db.delete(
        'items',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error deleting item: $e');
    }
  }
}