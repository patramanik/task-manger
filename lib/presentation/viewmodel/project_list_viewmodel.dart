import 'package:flutter/material.dart';

import '../../core/dao/project_dao.dart';
import '../../data/model/project.dart';

class ProjectViewModel with ChangeNotifier {
  final ProjectRepository _repository;

  ProjectViewModel(this._repository);

  List<Project> _projects = [];
  List<Project> get projects => _projects;

  Future<void> loadProjects() async {
    _projects = await _repository.getProjects();
    notifyListeners();
  }

  Future<int> addProject(Project project) async {
    final id = await _repository.createProject(project);
    await loadProjects();
    return id;
  }

  Future<void> updateProject(Project project) async {
    await _repository.updateProject(project);
    await loadProjects();
  }

  Future<void> deleteProject(int id) async {
    await _repository.deleteProject(id);
    await loadProjects();
  }
}
