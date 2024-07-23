import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:task_app/Models/TaskModel.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'task_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT, previsionTask INTEGER, createdAt INTEGER, finishAt INTEGER)',
        );
      },
    );
  }

  Future<int> _getNextId() async {
    final db = await database;
    final result = await db.rawQuery('SELECT MAX(id) AS maxId FROM tasks');
    final maxId = result.first['maxId'] as int?;
    return (maxId ?? 0) + 1;
  }

  Future<int> insertTask(Task task) async {
    final db = await database;
    final nextId = await _getNextId();
    final newTask = Task(
      id: nextId,
      title: task.title,
      description: task.description,
      previsionTask: task.previsionTask,
      createdAt: task.createdAt,
      finishAt: task.finishAt,
    );
    return await db.insert('tasks', newTask.toMap());
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');

    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  Future<int> updateTask(Task task) async {
    final db = await database;
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int id) async {
    final db = await database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
