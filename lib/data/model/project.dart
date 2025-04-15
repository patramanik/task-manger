// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class Project {
  final int? id;
  final String name;
  final String? description;
  final DateTime startDate;
  final DateTime endDate;
  final Color color;

  Project({
    this.id,
    required this.name,
    this.description,
    required this.startDate,
    required this.endDate,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'color': color.value,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      startDate: DateTime.parse(map['start_date']),
      endDate: DateTime.parse(map['end_date']),
      color: Color(map['color']),
    );
  }

  Project copyWith({
    int? id,
    String? name,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Color? color,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      color: color ?? this.color,
    );
  }
}