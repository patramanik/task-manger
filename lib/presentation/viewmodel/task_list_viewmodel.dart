import 'package:flutter/material.dart';

import '../../core/dao/project_dao.dart';
import '../../data/model/task.dart';

class TaskViewModel with ChangeNotifier {
  final TaskRepository _repository;

  TaskViewModel(this._repository);

  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  Future<void> loadTasks(int projectId) async {
    _tasks = await _repository.getTasksByProject(projectId);
    notifyListeners();
  }

  Future<void> loadAllTasks() async {
    _tasks = await _repository.getAllTasks();
    notifyListeners();
  }

  Future<int> addTask(Task task) async {
    final id = await _repository.createTask(task);
    await loadTasks(task.projectId);
    return id;
  }

  Future<void> updateTask(Task task) async {
    await _repository.updateTask(task);
    await loadTasks(task.projectId);
  }

  Future<void> deleteTask(int id, int projectId) async {
    await _repository.deleteTask(id);
    await loadTasks(projectId);
  }

  Future<void> toggleTaskCompletion(
    int id,
    bool isCompleted,
    int projectId,
  ) async {
    await _repository.toggleTaskCompletion(id, isCompleted);
    await loadTasks(projectId);
  }

  void sortTasksByDueDate() {
    _tasks.sort((a, b) {
      if (a.dueDate == null && b.dueDate == null) return 0;
      if (a.dueDate == null) return 1; // Tasks without dates go to bottom
      if (b.dueDate == null) return -1; // Tasks with dates come first
      return a.dueDate!.compareTo(b.dueDate!);
    });
    notifyListeners();
  }

  void sortTasksByCompletion() {
    _tasks.sort((a, b) {
      // Incomplete tasks first (false comes before true)
      if (a.isCompleted == b.isCompleted) return 0;
      return a.isCompleted ? 1 : -1;
    });
    notifyListeners();
  }

  void sortTasksByTitle() {
    _tasks.sort((a, b) => a.title.compareTo(b.title));
    notifyListeners();
  }
}
