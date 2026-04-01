import 'package:equatable/equatable.dart';

class NutritionLog extends Equatable {
  final String id;
  final String userId;
  final String foodName;
  final String? foodImageUrl;
  final int calories;
  final double? protein;
  final double? carbs;
  final double? fat;
  final String? analysisText; // Detailed nutritional analysis from Gemini
  final DateTime timestamp;

  const NutritionLog({
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

  NutritionLog copyWith({
    String? id,
    String? userId,
    String? foodName,
    String? foodImageUrl,
    int? calories,
    double? protein,
    double? carbs,
    double? fat,
    String? analysisText,
    DateTime? timestamp,
  }) {
    return NutritionLog(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      foodName: foodName ?? this.foodName,
      foodImageUrl: foodImageUrl ?? this.foodImageUrl,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fat: fat ?? this.fat,
      analysisText: analysisText ?? this.analysisText,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        foodName,
        foodImageUrl,
        calories,
        protein,
        carbs,
        fat,
        analysisText,
        timestamp,
      ];
}
