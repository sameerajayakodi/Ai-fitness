import 'package:ai_fitness/domain/entities/nutrition_log.dart';

class NutritionLogModel {
  final String id;
  final String userId;
  final String foodName;
  final String? foodImageUrl;
  final int calories;
  final double? protein;
  final double? carbs;
  final double? fat;
  final String? analysisText;
  final DateTime timestamp;

  NutritionLogModel({
    required this.id,
    required this.userId,
    required this.foodName,
    this.foodImageUrl,
    required this.calories,
    this.protein,
    this.carbs,
    this.fat,
    this.analysisText,
    required this.timestamp,
  });

  factory NutritionLogModel.fromJson(Map<String, dynamic> json) {
    return NutritionLogModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      foodName: json['foodName'] as String,
      foodImageUrl: json['foodImageUrl'] as String?,
      calories: json['calories'] as int,
      protein: (json['protein'] as num?)?.toDouble(),
      carbs: (json['carbs'] as num?)?.toDouble(),
      fat: (json['fat'] as num?)?.toDouble(),
      analysisText: json['analysisText'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  factory NutritionLogModel.fromEntity(NutritionLog log) {
    return NutritionLogModel(
      id: log.id,
      userId: log.userId,
      foodName: log.foodName,
      foodImageUrl: log.foodImageUrl,
      calories: log.calories,
      protein: log.protein,
      carbs: log.carbs,
      fat: log.fat,
      analysisText: log.analysisText,
      timestamp: log.timestamp,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'foodName': foodName,
      'foodImageUrl': foodImageUrl,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'analysisText': analysisText,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  NutritionLog toEntity() {
    return NutritionLog(
      id: id,
      userId: userId,
      foodName: foodName,
      foodImageUrl: foodImageUrl,
      calories: calories,
      protein: protein,
      carbs: carbs,
      fat: fat,
      analysisText: analysisText,
      timestamp: timestamp,
    );
  }
}
