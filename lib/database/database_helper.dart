import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/blocs/categories/models/category.dart';
import 'package:todoapp/blocs/tasks/models/task.dart';

class DatabaseHelper {
  static const _databaseName = "todoapp_database.db";
  static const _databaseVersion = 1;

  static const tasksTable = 'tasks_table';
  static const categoriesTable = 'categories_table';

  static const taskColumnId = 'id';
  static const taskColumnName = 'name';
  static const taskColumnIsCompleted = 'isCompleted';
  static const taskColumnCategory = 'category';
  static const taskColumnDate = 'date';

  static const categoryColumnId = 'id';
  static const categoryColumnName = 'categoryName';
  static const categoryColumnIsSelected = 'isSelected';

  Future<Database> get database async {
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(
      join(await getDatabasesPath(), _databaseName),
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tasksTable(
            $taskColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $taskColumnCategory TEXT,
            $taskColumnName TEXT,
            $taskColumnIsCompleted INTEGER,
            $taskColumnDate TEXT
          )
          ''');

    await db.execute('''
          CREATE TABLE $categoriesTable(
            $categoryColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $categoryColumnName TEXT,
            $categoryColumnIsSelected INTEGER
          )
          ''');
  }

  Future<void> insertTask(Task task) async {
    final db = await database;

    await db.insert(
      tasksTable,
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Task>> getTasks() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(tasksTable);

    return List.generate(maps.length, (index) {
      return Task(
        id: maps[index]['id'],
        category: maps[index]['category'],
        isCompleted: maps[index]['isCompleted'],
        taskName: maps[index]['name'],
        date: maps[index]['date'],
      );
    });
  }

  Future<void> updateTask(Task task) async {
    final db = await database;

    await db.update(
      tasksTable,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(int id) async {
    final db = await database;

    await db.delete(
      tasksTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteTasksByCategory(String category) async {
    final db = await database;

    await db.delete(
      tasksTable,
      where: 'category = ?',
      whereArgs: [category],
    );
  }

  Future<List<Category>> getCategories() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(categoriesTable);

    return List.generate(maps.length, (index) {
      return Category(
        categoryName: maps[index]['categoryName'],
        id: maps[index]['id'],
      );
    });
  }

  Future<void> insertCategory(Category category) async {
    final db = await database;

    await db.insert(
      categoriesTable,
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteCategory(String category) async {
    final db = await database;

    await db.delete(
      categoriesTable,
      where: 'categoryName = ?',
      whereArgs: [category],
    );
  }
}
