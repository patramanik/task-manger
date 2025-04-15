// import 'package:flutter/material.dart';


// import '../../data/model/Project.dart';
// import '../../data/model/Task.dart';


// class TaskFormDialog extends StatefulWidget {
//   final Task? task;
//   final List<Project> projects;
//   final Function(Task) onSubmit;

//   const TaskFormDialog({
//     super.key,
//     this.task,
//     required this.projects,
//     required this.onSubmit,
//   });

//   @override
//   State<TaskFormDialog> createState() => _TaskFormDialogState();
// }

// class _TaskFormDialogState extends State<TaskFormDialog> {
//   late final _formKey = GlobalKey<FormState>();
//   late String _title;
//   late String _description;
//   late DateTime? _dueDate;
//   late int _projectId;

//   @override
//   void initState() {
//     super.initState();
//     final task = widget.task;
//     _title = task?.title ?? '';
//     _description = task?.description ?? '';
//     _dueDate = task?.dueDate;
//     _projectId = task?.projectId ?? widget.projects.first.id!;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
//       content: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               if (widget.task == null)
//                 DropdownButtonFormField<int>(
//                   value: _projectId,
//                   items: widget.projects
//                       .map((project) => DropdownMenuItem(
//                             value: project.id,
//                             child: Text(project.name),
//                           ))
//                       .toList(),
//                   onChanged: (value) => _projectId = value!,
//                   decoration: const InputDecoration(
//                     labelText: 'Project',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//               if (widget.task == null) const SizedBox(height: 16),
//               TextFormField(
//                 initialValue: _title,
//                 decoration: const InputDecoration(
//                   labelText: 'Task Title',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a task title';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => _title = value!,
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 initialValue: _description,
//                 decoration: const InputDecoration(
//                   labelText: 'Description (Optional)',
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: 3,
//                 onSaved: (value) => _description = value ?? '',
//               ),
//               const SizedBox(height: 16),
//               InkWell(
//                 onTap: () => _selectDate(context),
//                 child: InputDecorator(
//                   decoration: const InputDecoration(
//                     labelText: 'Due Date (Optional)',
//                     border: OutlineInputBorder(),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         _dueDate != null
//                             ? _dueDate!.format('MMM dd, yyyy')
//                             : 'Select a date',
//                       ),
//                       const Icon(Icons.calendar_today),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           child: const Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: _submitForm,
//           child: const Text('Save'),
//         ),
//       ],
//     );
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final pickedDate = await showDatePicker(
//       context: context,
//       initialDate: _dueDate ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );

//     if (pickedDate != null) {
//       setState(() => _dueDate = pickedDate);
//     }
//   }

//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       widget.onSubmit(
//         Task(
//           id: widget.task?.id,
//           projectId: _projectId,
//           title: _title,
//           description: _description,
//           dueDate: _dueDate,
//           isCompleted: widget.task?.isCompleted ?? false,
//         ),
//       );
//       Navigator.of(context).pop();
//     }
//   }
// }