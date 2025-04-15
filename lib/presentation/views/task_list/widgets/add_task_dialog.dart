import 'package:flutter/material.dart';

import '../../../../data/model/task.dart';

class AddTaskDialog extends StatefulWidget {
  final int projectId;
  final Function(Task) onCreate;

  const AddTaskDialog({
    super.key,
    required this.projectId,
    required this.onCreate,
  });

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _dueDate;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Task'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Task Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            _buildDatePickerField(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _createTask,
          child: const Text('Add Task'),
        ),
      ],
    );
  }

  Widget _buildDatePickerField() {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: _dueDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (date != null) {
          setState(() => _dueDate = date);
        }
      },
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Due Date (optional)',
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.calendar_today),
        ),
        child: Text(
          _dueDate == null 
              ? 'No due date' 
              : _formatDate(_dueDate!),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return date.toLocal().toString().split(' ')[0];
  }

  void _createTask() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task title is required')),
      );
      return;
    }

    final task = Task(
      projectId: widget.projectId,
      title: _titleController.text,
      description: _descriptionController.text.isEmpty 
          ? null 
          : _descriptionController.text,
      dueDate: _dueDate,
    );

    widget.onCreate(task);
    Navigator.pop(context);
  }
}