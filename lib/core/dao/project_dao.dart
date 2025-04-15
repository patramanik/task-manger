import '../../data/model/project.dart';
import '../../data/model/task.dart';
import '../database/app_database.dart';

class ProjectRepository {
  final DatabaseHelper dbHelper;

  ProjectRepository(this.dbHelper);

  Future<int> createProject(Project project) async {
    final db = await dbHelper.database;
    return await db.insert('projects', project.toMap());
  }

  Future<List<Project>> getProjects() async {
    final db = await dbHelper.database;
    final maps = await db.query('projects');
    return maps.map((map) => Project.fromMap(map)).toList();
  }

  Future<int> updateProject(Project project) async {
    final db = await dbHelper.database;
    return await db.update(
      'projects',
      project.toMap(),
      where: 'id = ?',
      whereArgs: [project.id],
    );
  }

  Future<int> deleteProject(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'projects',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

class TaskRepository {
  final DatabaseHelper dbHelper;

  TaskRepository(this.dbHelper);

  Future<int> createTask(Task task) async {
    final db = await dbHelper.database;
    return await db.insert('tasks', task.toMap());
  }

  Future<List<Task>> getTasksByProject(int projectId) async {
    final db = await dbHelper.database;
    final maps = await db.query(
      'tasks',
      where: 'project_id = ?',
      whereArgs: [projectId],
    );
    return maps.map((map) => Task.fromMap(map)).toList();
  }

  Future<List<Task>> getAllTasks() async {
    final db = await dbHelper.database;
    final maps = await db.query('tasks');
    return maps.map((map) => Task.fromMap(map)).toList();
  }

  Future<int> updateTask(Task task) async {
    final db = await dbHelper.database;
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> toggleTaskCompletion(int id, bool isCompleted) async {
    final db = await dbHelper.database;
    return await db.update(
      'tasks',
      {'is_completed': isCompleted ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}