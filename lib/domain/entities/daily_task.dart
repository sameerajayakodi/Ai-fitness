import 'package:equatable/equatable.dart';

class DailyTask extends Equatable {
  final String id;
  final String userId;
  final String title;
  final String description;
  final String category; // Exercise, Meditation, Hydration, Sleep, Nutrition, Stretching
  final int durationMinutes;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime? completedAt;
  final DateTime dueDate;

  const DailyTask({
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

  DailyTask copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    String? category,
    int? durationMinutes,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? completedAt,
    DateTime? dueDate,
  }) {
    return DailyTask(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      dueDate: dueDate ?? this.dueDate,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        title,
        description,
        category,
        durationMinutes,
        isCompleted,
        createdAt,
        completedAt,
        dueDate,
      ];
}
