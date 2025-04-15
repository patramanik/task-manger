// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/model/task.dart';
import '../../viewmodel/task_list_viewmodel.dart';
import '../project_list/widgets/empty_state.dart';
import 'widgets/task_item.dart';
import 'widgets/add_task_dialog.dart';

class TaskListScreen extends StatefulWidget {
  final int projectId;
  final String projectName;

  const TaskListScreen({
    super.key,
    required this.projectId,
    required this.projectName,
  });

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskViewModel>().loadTasks(widget.projectId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskViewModel = context.watch<TaskViewModel>();
    final tasks = taskViewModel.tasks;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.projectName),
        actions: [
          IconButton(icon: const Icon(Icons.sort), onPressed: _showSortOptions),
        ],
      ),
      body:
          tasks.isEmpty
              ? const EmptyState(
                message: 'No tasks yet!\nTap + to add one',
                icon: Icons.task,
              )
              : ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return TaskItem(
                    task: task,
                    onToggleCompleted: (value) {
                      taskViewModel.toggleTaskCompletion(
                        task.id!,
                        value ?? false,
                        widget.projectId,
                      );
                    },
                    onDelete: () => _showDeleteDialog(context, task),
                    onEdit: () {
                      
                    },
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AddTaskDialog(
            projectId: widget.projectId,
            onCreate: (task) async {
              await context.read<TaskViewModel>().addTask(task);
              if (mounted) {
                setState(() {});
              }
            },
          ),
    );
  }

  void _showDeleteDialog(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Task?'),
          content: Text('Are you sure you want to delete "${task.title}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await context.read<TaskViewModel>().deleteTask(
                  task.id!,
                  widget.projectId,
                );
                if (mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Sort by Due Date'),
              onTap: () {
                context.read<TaskViewModel>().sortTasksByDueDate();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Sort by Completion'),
              onTap: () {
                context.read<TaskViewModel>().sortTasksByCompletion();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Sort by Title'),
              onTap: () {
                context.read<TaskViewModel>().sortTasksByTitle();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
