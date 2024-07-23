import 'package:flutter/material.dart';
import 'package:task_app/Controllers/TaskController.dart';
import 'package:task_app/Models/TaskModel.dart';
import 'TaskEditScreen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TaskController _taskController = TaskController();
  late Future<List<Task>> _tasks;

  @override
  void initState() {
    super.initState();
    _tasks = _taskController.getTasks();
  }

  void _refreshTasks() {
    setState(() {
      _tasks = _taskController.getTasks();
    });
  }

  void _navigateToEditTask([Task? task]) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TaskEditScreen(
          task: task,
          onSave: () {
            Navigator.of(context).pop();
            _refreshTasks();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _navigateToEditTask(),
          ),
        ],
      ),
      body: FutureBuilder<List<Task>>(
        future: _tasks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No tasks available'));
          } else {
            final tasks = snapshot.data!;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _navigateToEditTask(task),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await _taskController.deleteTask(task.id);
                          _refreshTasks();
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
