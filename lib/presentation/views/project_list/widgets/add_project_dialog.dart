import 'package:flutter/material.dart';
import '../../../../data/model/project.dart';

class AddProjectDialog extends StatefulWidget {
  final Function(Project) onCreate;

  const AddProjectDialog({super.key, required this.onCreate});

  @override
  State<AddProjectDialog> createState() => _AddProjectDialogState();
}

class _AddProjectDialogState extends State<AddProjectDialog> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  late DateTime _startDate;
  late DateTime _endDate;
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _startDate = DateTime.now();
    _endDate = DateTime.now().add(const Duration(days: 7));
    _selectedColor = Colors.blue;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create New Project'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Project Name',
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
            _buildDatePickerField(
              'Start Date',
              _startDate,
              (date) => setState(() => _startDate = date!),
            ),
            const SizedBox(height: 16),
            _buildDatePickerField(
              'End Date',
              _endDate,
              (date) => setState(() => _endDate = date!),
            ),
            const SizedBox(height: 16),
            _buildColorPicker(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _createProject,
          style: ElevatedButton.styleFrom(
            backgroundColor: _selectedColor,
            foregroundColor: Colors.white,
          ),
          child: const Text('Create'),
        ),
      ],
    );
  }

  Widget _buildDatePickerField(
    String label,
    DateTime initialDate,
    ValueChanged<DateTime?> onDateSelected,
  ) {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (date != null) {
          onDateSelected(date);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        child: Text(initialDate.toLocal().toString().split(' ')[0]),
      ),
    );
  }

  Widget _buildColorPicker() {
    const colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
      Colors.pink,
      Colors.teal,
      Colors.indigo,
      Colors.amber,
      Colors.cyan,
      Colors.deepOrange,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Color',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: colors.map((color) {
            return GestureDetector(
              onTap: () => setState(() => _selectedColor = color),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _selectedColor == color
                          ? Colors.black
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: _selectedColor == color
                      ? const Icon(Icons.check, color: Colors.white)
                      : null,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _createProject() {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Project name is required')),
      );
      return;
    }

    final project = Project(
      name: _nameController.text,
      description: _descriptionController.text.isEmpty
          ? null
          : _descriptionController.text,
      startDate: _startDate,
      endDate: _endDate,
      color: _selectedColor,
    );

    widget.onCreate(project);
    Navigator.pop(context);
  }
}