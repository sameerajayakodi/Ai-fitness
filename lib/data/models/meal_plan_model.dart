import 'package:ai_fitness/domain/entities/meal_plan.dart';

class MealModel {
  final String id;
  final String name;
  final String mealType;
  final int estimatedCalories;
  final List<String> ingredients;
  final String? description;
  final bool isCustom;

  MealModel({
    required this.id,
    required this.name,
    required this.mealType,
    required this.estimatedCalories,
    required this.ingredients,
    this.description,
    this.isCustom = false,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      id: json['id'] as String,
      name: json['name'] as String,
      mealType: json['mealType'] as String,
      estimatedCalories: json['estimatedCalories'] as int,
      ingredients: List<String>.from(json['ingredients'] as List),
      description: json['description'] as String?,
      isCustom: json['isCustom'] as bool? ?? false,
    );
  }

  factory MealModel.fromEntity(Meal meal) {
    return MealModel(
      id: meal.id,
      name: meal.name,
      mealType: meal.mealType,
      estimatedCalories: meal.estimatedCalories,
      ingredients: meal.ingredients,
      description: meal.description,
      isCustom: meal.isCustom,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mealType': mealType,
      'estimatedCalories': estimatedCalories,
      'ingredients': ingredients,
      'description': description,
      'isCustom': isCustom,
    };
  }

  Meal toEntity() {
    return Meal(
      id: id,
      name: name,
      mealType: mealType,
      estimatedCalories: estimatedCalories,
      ingredients: ingredients,
      description: description,
      isCustom: isCustom,
    );
  }
}

class MealPlanModel {
  final String id;
  final String userId;
  final List<MealModel> meals;
  final int totalCalories;
  final DateTime createdAt;
  final DateTime validFrom;
  final DateTime validUntil;
  final bool isActive;

  MealPlanModel({
    required this.id,
    required this.userId,
    required this.meals,
    required this.totalCalories,
    required this.createdAt,
    required this.validFrom,
    required this.validUntil,
    this.isActive = true,
  });

  factory MealPlanModel.fromJson(Map<String, dynamic> json) {
    return MealPlanModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      meals: (json['meals'] as List)
          .map((e) => MealModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCalories: json['totalCalories'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      validFrom: DateTime.parse(json['validFrom'] as String),
      validUntil: DateTime.parse(json['validUntil'] as String),
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  factory MealPlanModel.fromEntity(MealPlan plan) {
    return MealPlanModel(
      id: plan.id,
      userId: plan.userId,
      meals: plan.meals.map((m) => MealModel.fromEntity(m)).toList(),
      totalCalories: plan.totalCalories,
      createdAt: plan.createdAt,
      validFrom: plan.validFrom,
      validUntil: plan.validUntil,
      isActive: plan.isActive,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'meals': meals.map((m) => m.toJson()).toList(),
      'totalCalories': totalCalories,
      'createdAt': createdAt.toIso8601String(),
      'validFrom': validFrom.toIso8601String(),
      'validUntil': validUntil.toIso8601String(),
      'isActive': isActive,
    };
  }

  MealPlan toEntity() {
    return MealPlan(
      id: id,
      userId: userId,
      meals: meals.map((m) => m.toEntity()).toList(),
      totalCalories: totalCalories,
      createdAt: createdAt,
      validFrom: validFrom,
      validUntil: validUntil,
      isActive: isActive,
    );
  }
}
