import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_app/Components/DefaultDatePicker.dart';
import 'package:task_app/Components/DefaultTextField.dart';
import 'package:task_app/Models/TaskModel.dart';


class TaskForm extends StatefulWidget {
  final Task? task;

  const TaskForm({Key? key, this.task}) : super(key: key);

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _previsionTaskController = TextEditingController();
  DateTime? _previsionTask;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _previsionTask = widget.task!.previsionTask;
      _previsionTaskController.text = DateFormat('dd/MM/yyyy').format(_previsionTask!);
    }
  }

  void _saveTask() {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty || _previsionTask == null) {
      return;
    }

    final task = Task(
      id: widget.task?.id ?? 0,
      title: _titleController.text,
      description: _descriptionController.text,
      previsionTask: _previsionTask!,
      createdAt: widget.task?.createdAt,
      finishAt: widget.task?.finishAt,
    );

    Navigator.pop(context, task);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Nova Tarefa' : 'Editar Tarefa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            DefaultTextField(
              controller: _titleController,
              label: 'Título da Tarefa:',
            ),
            DefaultTextField(
              controller: _descriptionController,
              label: 'Descrição:',
            ),
            DefaultDatePicker(
              controller: _previsionTaskController,
              labelText: 'Data de Conclusão:',
              initialDate: _previsionTask,
              onDatePicked: (date) {
                setState(() {
                  _previsionTask = date;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTask,
              child: Text(widget.task == null ? 'Adicionar Nova' : 'Atualizar'),
            ),
          ],
        ),
      ),
    );
  }
}
