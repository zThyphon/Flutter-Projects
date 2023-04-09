import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import "../models/note_model.dart";

class DbHelper {
  final _databaseName = 'notebook_app.db';
  final _databaseVersion = 1;

  // Make the constructor private so that it can't be instantiated from outside the class.
  DbHelper._privateConstructor();
  static final DbHelper instance = DbHelper._privateConstructor();

  static Database? _database;

  // Define the getter for the database object.
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  // Initialize the database.
  Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, _databaseName);

    return await openDatabase(
      databasePath,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // Create the table in the database.
  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, content TEXT NOT NULL, date TEXT NOT NULL, colorId INTEGER NOT NULL)');
  }

  // Define the CRUD operations.

  // Insert data into the table.
  Future<void> addNote(Note note) async {
    final db = await database;

    await db.insert(
      "notes",
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Query all data from the table.
  Future<List<Map<String, dynamic>>> getNotes() async {
    final db = await database;
    return await db.query("notes");
  }

  // Update data in the table.
  Future<void> updateNote(int id, String updatedNoteTitle,
      String updatedNoteContent, String updateDate, int colorId) async {
    final db = await database;
    await db.update(
      "notes",
      {
        "title": updatedNoteTitle,
        "content": updatedNoteContent,
        "date": updateDate,
        "colorId": colorId,
      },
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // Delete data from the table.
  Future<int> delete(int id) async {
    final db = await database;
    return await db.rawDelete("DELETE FROM notes WHERE id=?", [id]);
  }
}
