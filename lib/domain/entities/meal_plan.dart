import 'package:equatable/equatable.dart';

class Meal extends Equatable {
  final String id;
  final String name;
  final String mealType; // Breakfast, Lunch, Dinner, Snack
  final int estimatedCalories;
  final List<String> ingredients;
  final String? description;
  final bool isCustom;

  const Meal({
    required this.id,
    required this.name,
    required this.mealType,
    required this.estimatedCalories,
    required this.ingredients,
    this.description,
    this.isCustom = false,
  });

  Meal copyWith({
    String? id,
    String? name,
    String? mealType,
    int? estimatedCalories,
    List<String>? ingredients,
    String? description,
    bool? isCustom,
  }) {
    return Meal(
      id: id ?? this.id,
      name: name ?? this.name,
      mealType: mealType ?? this.mealType,
      estimatedCalories: estimatedCalories ?? this.estimatedCalories,
      ingredients: ingredients ?? this.ingredients,
      description: description ?? this.description,
      isCustom: isCustom ?? this.isCustom,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        mealType,
        estimatedCalories,
        ingredients,
        description,
        isCustom,
      ];
}

class MealPlan extends Equatable {
  final String id;
  final String userId;
  final List<Meal> meals;
  final int totalCalories;
  final DateTime createdAt;
  final DateTime validFrom;
  final DateTime validUntil;
  final bool isActive;

  const MealPlan({
    required this.id,
    required this.userId,
    required this.meals,
    required this.totalCalories,
    required this.createdAt,
    required this.validFrom,
    required this.validUntil,
    this.isActive = true,
  });

  MealPlan copyWith({
    String? id,
    String? userId,
    List<Meal>? meals,
    int? totalCalories,
    DateTime? createdAt,
    DateTime? validFrom,
    DateTime? validUntil,
    bool? isActive,
  }) {
    return MealPlan(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      meals: meals ?? this.meals,
      totalCalories: totalCalories ?? this.totalCalories,
      createdAt: createdAt ?? this.createdAt,
      validFrom: validFrom ?? this.validFrom,
      validUntil: validUntil ?? this.validUntil,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        meals,
        totalCalories,
        createdAt,
        validFrom,
        validUntil,
        isActive,
      ];
}
