import 'package:ai_fitness/domain/entities/daily_task.dart';

class DailyTaskModel {
  final String id;
  final String userId;
  final String title;
  final String description;
  final String category;
  final int durationMinutes;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime? completedAt;
  final DateTime dueDate;

  DailyTaskModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.category,
    required this.durationMinutes,
    this.isCompleted = false,
    required this.createdAt,
    this.completedAt,
    required this.dueDate,
  });

  factory DailyTaskModel.fromJson(Map<String, dynamic> json) {
    return DailyTaskModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      durationMinutes: json['durationMinutes'] as int,
      isCompleted: json['isCompleted'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      dueDate: DateTime.parse(json['dueDate'] as String),
    );
  }

  factory DailyTaskModel.fromEntity(DailyTask task) {
    return DailyTaskModel(
      id: task.id,
      userId: task.userId,
      title: task.title,
      description: task.description,
      category: task.category,
      durationMinutes: task.durationMinutes,
      isCompleted: task.isCompleted,
      createdAt: task.createdAt,
      completedAt: task.completedAt,
      dueDate: task.dueDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'category': category,
      'durationMinutes': durationMinutes,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
    };
  }

  DailyTask toEntity() {
    return DailyTask(
      id: id,
      userId: userId,
      title: title,
      description: description,
      category: category,
      durationMinutes: durationMinutes,
      isCompleted: isCompleted,
      createdAt: createdAt,
      completedAt: completedAt,
      dueDate: dueDate,
    );
  }
}
