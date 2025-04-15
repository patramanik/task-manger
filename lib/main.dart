import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/dao/project_dao.dart';
import 'core/database/app_database.dart';
import 'presentation/viewmodel/task_list_viewmodel.dart';
import 'presentation/viewmodel/project_list_viewmodel.dart';
import 'presentation/views/project_list/project_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DatabaseHelper.instance;
  final projectRepo = ProjectRepository(dbHelper);
  final taskRepo = TaskRepository(dbHelper);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProjectViewModel(projectRepo)),
        ChangeNotifierProvider(create: (_) => TaskViewModel(taskRepo)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ProjectListScreen(),
    );
  }
}