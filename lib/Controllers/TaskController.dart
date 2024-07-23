import 'package:task_app/Models/TaskModel.dart';
import 'package:task_app/helpers/dataBase_helper.dart';

class TaskController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> addTask(Task task) async {
    return await _dbHelper.insertTask(task);
  }

  Future<List<Task>> getTasks() async {
    return await _dbHelper.getTasks();
  }

  Future<int> updateTask(Task task) async {
    return await _dbHelper.updateTask(task);
  }

  Future<int> deleteTask(int id) async {
    return await _dbHelper.deleteTask(id);
  }
}
