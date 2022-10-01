import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/database/models/task.dart';
import 'package:todoapp/models/task_model.dart';

class DatabaseHelper {
  static const _databaseName = "tasks_database.db";
  static const _databaseVersion = 1;

  static const table = 'tasks_table';

  static const columnId = 'id';
  static const columnName = 'name';
  static const columnIsCompleted = 'isCompleted';

  Future<Database> get database async {
    WidgetsFlutterBinding.ensureInitialized();
    print(await getDatabasesPath());

    return openDatabase(
      join(await getDatabasesPath(), _databaseName),
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT,
            $columnIsCompleted INTEGER
          )
          ''');
  }

  Future<void> insertTask(Task task) async {
    final db = await database;

    await db.insert(
      table,
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Task>> getTasks() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(table);

    return List.generate(maps.length, (index) {
      return Task(
        id: maps[index]['id'],
        isCompleted: maps[index]['isCompleted'],
        taskName: maps[index]['name'],
      );
    });
  }

  Future<void> updateTask(Task task) async {
    final db = await database;

    await db.update(
      table,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(int id) async {
    final db = await database;

    await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
