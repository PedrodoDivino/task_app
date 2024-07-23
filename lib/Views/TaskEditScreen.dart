import 'package:flutter/material.dart';
import 'package:task_app/Controllers/TaskController.dart';
import 'package:task_app/Models/TaskModel.dart';

class TaskEditScreen extends StatefulWidget {
  final Task? task;
  final VoidCallback onSave;

  const TaskEditScreen({Key? key, this.task, required this.onSave}) : super(key: key);

  @override
  _TaskEditScreenState createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  final TaskController _taskController = TaskController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _previsionTask;
  DateTime? _createAt;
  DateTime? _finishAt;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _previsionTask = widget.task!.previsionTask;
      _createAt = widget.task!.createdAt;
      _finishAt = widget.task!.finishAt;
    }
  }

  void _saveTask() async {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final previsionTask = _previsionTask ?? DateTime.now();
    final createAt = _createAt ?? DateTime.now();
    final finishAt = _finishAt;

    if (widget.task == null) {
      final newTask = Task(
        id: 0,
        title: title,
        description: description,
        previsionTask: previsionTask,
        createdAt: createAt,
        finishAt: finishAt,
      );
      await _taskController.addTask(newTask);
    } else {
      final updatedTask = Task(
        id: widget.task!.id,
        title: title,
        description: description,
        previsionTask: previsionTask,
        createdAt: createAt,
        finishAt: finishAt,
      );
      await _taskController.updateTask(updatedTask);
    }
    widget.onSave();
    Navigator.pop(context);   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
        actions: [
          TextButton(
            onPressed: _saveTask,
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16.0),
            // DateTime pickers for previsionTask, createAt, and finishAt
            TextButton(
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: _previsionTask ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (selectedDate != null && selectedDate != _previsionTask) {
                  setState(() {
                    _previsionTask = selectedDate;
                  });
                }
              },
              child: Text(_previsionTask != null
                  ? 'Prevision Date: ${_previsionTask!.toLocal()}'
                  : 'Select Prevision Date'),
            ),
            // Add more DateTime pickers if needed
          ],
        ),
      ),
    );
  }
}
