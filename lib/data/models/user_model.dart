import 'package:ai_fitness/domain/entities/user.dart';

class UserModel {
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

  UserModel({
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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String?,
      dailyCalorieGoal: json['dailyCalorieGoal'] as int? ?? 2000,
      currentStreak: json['currentStreak'] as int? ?? 0,
      longestStreak: json['longestStreak'] as int? ?? 0,
      unlockedBadges: List<String>.from(json['unlockedBadges'] as List? ?? []),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastNotificationTime: DateTime.parse(json['lastNotificationTime'] as String),
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      photoUrl: user.photoUrl,
      dailyCalorieGoal: user.dailyCalorieGoal,
      currentStreak: user.currentStreak,
      longestStreak: user.longestStreak,
      unlockedBadges: user.unlockedBadges,
      createdAt: user.createdAt,
      lastNotificationTime: user.lastNotificationTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'dailyCalorieGoal': dailyCalorieGoal,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'unlockedBadges': unlockedBadges,
      'createdAt': createdAt.toIso8601String(),
      'lastNotificationTime': lastNotificationTime.toIso8601String(),
    };
  }

  User toEntity() {
    return User(
      id: id,
      name: name,
      email: email,
      photoUrl: photoUrl,
      dailyCalorieGoal: dailyCalorieGoal,
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      unlockedBadges: unlockedBadges,
      createdAt: createdAt,
      lastNotificationTime: lastNotificationTime,
    );
  }
}
