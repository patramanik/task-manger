// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/model/project.dart';
import '../../viewmodel/project_list_viewmodel.dart';

import '../task_list/task_list_screen.dart';
import 'widgets/project_card.dart';
import 'widgets/add_project_dialog.dart';
import 'widgets/empty_state.dart';

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({super.key});

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProjectViewModel>().loadProjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    final projectViewModel = context.watch<ProjectViewModel>();
    final projects = projectViewModel.projects;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Projects'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: projects.isEmpty
            ? const EmptyState(
                message: 'No projects yet!\nTap + to create one',
                icon: Icons.folder_open,
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.9,
                ),
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  final project = projects[index];
                  return ProjectCard(
                    project: project,
                    onTap: () => _navigateToProjectDetail(context, project),
                    onDelete: () => _showDeleteDialog(context, project),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddProjectDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('New Project'),
        elevation: 2,
      ),
    );
  }

  void _navigateToProjectDetail(BuildContext context, Project project) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TaskListScreen(
          projectId: project.id!,
          projectName: project.name,
        ),
      ),
    );
  }

  void _showAddProjectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddProjectDialog(
        onCreate: (project) async {
          await context.read<ProjectViewModel>().addProject(project);
          if (mounted) {
            setState(() {});
          }
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Project project) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Project?'),
          content: Text('All tasks in "${project.name}" will be permanently deleted.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await context.read<ProjectViewModel>().deleteProject(project.id!);
                if (mounted) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}