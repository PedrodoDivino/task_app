import 'package:get/get.dart';
import 'package:task_app/Models/TaskModel.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs;

  void addTask(Task task) {
    tasks.add(task);
  }

  void updateTask(int index, Task task) {
    tasks[index] = task;
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
  }
}
