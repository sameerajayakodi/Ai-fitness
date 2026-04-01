class AppConstants {
  // API Keys
  static const String geminiApiKey = 'YOUR_GEMINI_API_KEY'; // To be set from environment

  // Gemini Models
  static const String geminiProModel = 'gemini-pro';
  static const String geminiProVisionModel = 'gemini-pro-vision';

  // Database Collections
  static const String usersCollection = 'users';
  static const String mealPlansCollection = 'mealPlans';
  static const String dailyTasksCollection = 'dailyTasks';
  static const String userProgressCollection = 'userProgress';
  static const String chatHistoryCollection = 'chatHistory';
  static const String nutritionLogsCollection = 'nutritionLogs';

  // Notification
  static const int notificationId = 1;
  static const String notificationChannelId = 'daily_motivation';
  static const String notificationChannelName = 'Daily Motivation';
  static const String notificationChannelDescription =
      'Receive daily motivational messages to keep you going!';
  static const int defaultNotificationHour = 6; // 6 AM
  static const int defaultNotificationMinute = 0;

  // Task Categories
  static const List<String> taskCategories = [
    'Exercise',
    'Meditation',
    'Hydration',
    'Sleep',
    'Nutrition',
    'Stretching',
  ];

  // Exercise Types
  static const List<String> exerciseTypes = [
    'Cardio',
    'Strength',
    'Flexibility',
    'Yoga',
    'Pilates',
    'HIIT',
  ];

  // Meal Types
  static const List<String> mealTypes = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snack',
  ];

  // Calorie Limits (Default)
  static const int defaultDailyCalorieLimit = 2000;

  // Gamification
  static const List<String> achievementBadges = [
    'First Step',
    'Week Warrior',
    'Month Master',
    'Century Climber',
    'Streak Starter',
    'Perfect Week',
    '7-Day Streak',
    '30-Day Streak',
  ];

  // Strings for motivation messages
  static const List<String> motivationMessages = [
    'Good morning! Today is a new opportunity to be better than yesterday.',
    'Your body can stand almost anything. It\'s your mind you need to convince.',
    'The only bad workout is the one that didn\'t happen.',
    'Don\'t stop when you\'re tired. Stop when you\'re done! 💪',
    'Progress is progress, no matter how small. Keep going!',
    'Make yourself proud today!',
    'Believe in yourself and you\'re halfway there.',
    'The pain you feel today will be the strength you feel tomorrow.',
    'Success is the sum of small efforts repeated day in and day out.',
    'You\'re already winning by showing up. Now let\'s make it count!',
  ];
}
