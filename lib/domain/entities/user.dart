import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final int dailyCalorieGoal;
  final int currentStreak;
  final int longestStreak;
  final List<String> unlockedBadges;
  final DateTime createdAt;
  final DateTime lastNotificationTime;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    this.dailyCalorieGoal = 2000,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.unlockedBadges = const [],
    required this.createdAt,
    required this.lastNotificationTime,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    int? dailyCalorieGoal,
    int? currentStreak,
    int? longestStreak,
    List<String>? unlockedBadges,
    DateTime? createdAt,
    DateTime? lastNotificationTime,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      dailyCalorieGoal: dailyCalorieGoal ?? this.dailyCalorieGoal,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      unlockedBadges: unlockedBadges ?? this.unlockedBadges,
      createdAt: createdAt ?? this.createdAt,
      lastNotificationTime: lastNotificationTime ?? this.lastNotificationTime,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        photoUrl,
        dailyCalorieGoal,
        currentStreak,
        longestStreak,
        unlockedBadges,
        createdAt,
        lastNotificationTime,
      ];
}
