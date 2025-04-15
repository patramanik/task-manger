// // ignore_for_file: deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';


// import '../../data/model/Project.dart';

// class ProjectFormDialog extends StatefulWidget {
//   final Project? project;
//   final Function(Project) onSubmit;

//   const ProjectFormDialog({
//     super.key,
//     this.project,
//     required this.onSubmit,
//   });

//   @override
//   State<ProjectFormDialog> createState() => _ProjectFormDialogState();
// }

// class _ProjectFormDialogState extends State<ProjectFormDialog> {
//   late final _formKey = GlobalKey<FormState>();
//   late String _name;
//   late String _description;
//   late DateTime _startDate;
//   late DateTime _endDate;
//   late Color _color;

//   @override
//   void initState() {
//     super.initState();
//     final project = widget.project;
//     _name = project?.name ?? '';
//     _description = project?.description ?? '';
//     _startDate = project?.startDate ?? DateTime.now();
//     _endDate = project?.endDate ?? DateTime.now().add(const Duration(days: 7));
//     _color = project?.color ?? Colors.blue;
//   }

//   @override
//   Widget build(BuildContext context) {
//     Theme.of(context);

//     return AlertDialog(
//       title: Text(widget.project == null ? 'Add Project' : 'Edit Project'),
//       content: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextFormField(
//                 initialValue: _name,
//                 decoration: const InputDecoration(
//                   labelText: 'Project Name',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a project name';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => _name = value!,
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
//               Row(
//                 children: [
//                   Expanded(
//                     child: InkWell(
//                       onTap: () => _selectDate(context, isStartDate: true),
//                       child: InputDecorator(
//                         decoration: const InputDecoration(
//                           labelText: 'Start Date',
//                           border: OutlineInputBorder(),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(_startDate.format('MMM dd, yyyy')),
//                             const Icon(Icons.calendar_today),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: InkWell(
//                       onTap: () => _selectDate(context, isStartDate: false),
//                       child: InputDecorator(
//                         decoration: const InputDecoration(
//                           labelText: 'End Date',
//                           border: OutlineInputBorder(),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(_endDate.format('MMM dd, yyyy')),
//                             const Icon(Icons.calendar_today),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               InkWell(
//                 onTap: () => _selectColor(context),
//                 child: InputDecorator(
//                   decoration: const InputDecoration(
//                     labelText: 'Project Color',
//                     border: OutlineInputBorder(),
//                   ),
//                   child: Row(
//                     children: [
//                       Container(
//                         width: 24,
//                         height: 24,
//                         decoration: BoxDecoration(
//                           color: _color,
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Text(_color.toHex()),
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

//   Future<void> _selectDate(BuildContext context, {required bool isStartDate}) async {
//     final pickedDate = await showDatePicker(
//       context: context,
//       initialDate: isStartDate ? _startDate : _endDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );

//     if (pickedDate != null) {
//       setState(() {
//         if (isStartDate) {
//           _startDate = pickedDate;
//           if (_endDate.isBefore(_startDate)) {
//             _endDate = _startDate.add(const Duration(days: 1));
//           }
//         } else {
//           _endDate = pickedDate;
//         }
//       });
//     }
//   }

//   Future<void> _selectColor(BuildContext context) async {
//     await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Pick a color'),
//         content: SingleChildScrollView(
//           child: ColorPicker(
//             pickerColor: _color,
//             onColorChanged: (color) => setState(() => _color = color),
//             showLabel: true,
//             pickerAreaHeightPercent: 0.8,
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('Select'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       widget.onSubmit(
//         Project(
//           id: widget.project?.id,
//           name: _name,
//           description: _description,
//           startDate: _startDate,
//           endDate: _endDate,
//           color: _color,
//         ),
//       );
//       Navigator.of(context).pop();
//     }
//   }
// }