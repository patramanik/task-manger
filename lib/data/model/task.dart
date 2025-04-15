class Task {
  final int? id;
  final int projectId;
  final String title;
  final String? description;
  final bool isCompleted;
  final DateTime? dueDate;

  Task({
    this.id,
    required this.projectId,
    required this.title,
    this.description,
    this.isCompleted = false,
    this.dueDate,
  }) {
    // Validate required fields
    if (projectId <= 0) {
      throw ArgumentError('Project ID must be positive');
    }
    if (title.isEmpty) {
      throw ArgumentError('Title cannot be empty');
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'project_id': projectId,
      'title': title,
      'description': description,
      'is_completed': isCompleted ? 1 : 0,
      'due_date': dueDate?.toIso8601String(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    if (map['project_id'] == null || map['title'] == null) {
      throw ArgumentError('Required fields are missing in map');
    }

    return Task(
      id: map['id'] as int?,
      projectId: map['project_id'] as int,
      title: map['title'] as String,
      description: map['description'] as String?,
      isCompleted: (map['is_completed'] as int?) == 1,
      dueDate: map['due_date'] != null 
          ? DateTime.parse(map['due_date'] as String) 
          : null,
    );
  }

  Task copyWith({
    int? id,
    int? projectId,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? dueDate,
  }) {
    return Task(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      dueDate: dueDate ?? this.dueDate,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is Task &&
        other.id == id &&
        other.projectId == projectId &&
        other.title == title &&
        other.description == description &&
        other.isCompleted == isCompleted &&
        other.dueDate == dueDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        projectId.hashCode ^
        title.hashCode ^
        description.hashCode ^
        isCompleted.hashCode ^
        dueDate.hashCode;
  }

  @override
  String toString() {
    return 'Task(id: $id, projectId: $projectId, title: $title, '
        'description: $description, isCompleted: $isCompleted, '
        'dueDate: ${dueDate?.toIso8601String()})';
  }
}