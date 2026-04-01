# AI Fitness - AI-Powered Fitness Application

A comprehensive Flutter application that combines AI, personalized fitness tracking, nutrition management, and daily motivation to help users achieve their fitness goals.

## 🎯 Features

### Core Features

- **Main Application Interface** - Clean, intuitive English interface
- **Gemini AI Chatbot** - Understand and respond in Sinhala & English
- **AI Food Recognition** - Analyze food photos for nutritional information
- **Personalized Meal Plans** - Weekly plans with randomization option
- **Daily Task Lists** - Custom 10-minute exercises and activities
- **Progress Tracking** - Visualize completed daily tasks

### Engagement & Motivation

- **Daily Motivation Notifications** - Morning motivational messages (configurable time)
- **Gamification System**
  - Daily streak tracking
  - Achievement badges (First Step, Week Warrior, Century Climber, etc.)
  - Progress visualization
- **Nutrition Logging** - Track calorie intake and nutritional info

## 📁 Project Structure

```
lib/
├── core/
│   ├── constants/        # App constants and configuration
│   ├── theme/           # App theming
│   └── utils/           # Logger and utilities
├── data/
│   ├── datasources/
│   │   ├── local/       # Local storage (notifications, preferences)
│   │   └── remote/      # Firebase, Firestore, Gemini API
│   ├── models/          # Data models for serialization
│   └── repositories/    # Data repository implementations
├── domain/
│   ├── entities/        # Business entities
│   ├── repositories/    # Repository interfaces
│   └── usecases/        # Business logic
├── presentation/
│   ├── pages/           # UI pages
│   │   ├── home/
│   │   ├── chat/
│   │   ├── food_recognition/
│   │   ├── meal_plans/
│   │   ├── tasks/
│   │   └── profile/
│   ├── providers/       # Riverpod state management
│   └── widgets/         # Shared widgets
└── main.dart            # App entry point
```

## 🛠️ Tech Stack

- **Framework**: Flutter 3.0+
- **State Management**: Riverpod
- **Backend**: Firebase
  - Authentication
  - Firestore Database
  - Cloud Storage
- **AI/ML**: Google Generative AI (Gemini)
- **Local Storage**: SharedPreferences, Hive
- **Notifications**: flutter_local_notifications
- **Image Processing**: image_picker, cached_network_image

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.0+
- Firebase CLI
- Gemini API Key

### 1. Clone & Setup

```bash
git clone <repository-url>
cd ai-fitness
flutter pub get
```

### 2. Firebase Configuration

See [FIREBASE_SETUP.md](FIREBASE_SETUP.md) for detailed setup instructions.

Key steps:

1. Create Firebase project
2. Enable Authentication, Firestore, Storage
3. Download configuration files
4. Update `firebase_options.dart`
5. Set up Firestore security rules

### 3. Gemini API Setup

1. Get API key from [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Update `lib/core/constants/app_constants.dart`

### 4. Run the App

```bash
# Clean setup
flutter clean
flutter pub get

# Run on connected device
flutter run

# Run specific platform
flutter run -d android    # Android device
flutter run -d ios        # iOS device
```

## 📱 App Pages

### Home Page

- Welcome interface
- Quick navigation to all features
- User profile overview
- Current streak display

### Chat Page

- AI-powered fitness coach
- Bilingual support (English & Sinhala)
- Conversation history
- Contextual fitness advice

### Food Recognition

- Camera integration
- Photo gallery access
- AI-powered food analysis
- Nutritional breakdown
- Log nutrition data

### Meal Plans

- Weekly meal suggestions
- Personalized calorie targets
- Randomize for variety
- Track planned vs. actual

### Daily Tasks

- Customizable task list
- Progress tracking
- Task categories (10 exercises, meditation, hydration, etc.)
- Streak counter

### Profile

- User stats
- Longest streak
- Achievements/badges
- Calorie goals
- Settings

## 🔐 Security & Privacy

- Firebase Authentication for secure login
- User-scoped Firestore rules
- Data encryption in transit
- Local-only storage for sensitive data
- No third-party analytics by default

## 🎨 Theme & UI

- Material Design 3
- Custom color scheme
  - Primary: Purple (#6C63FF)
  - Secondary: Red (#FF6B6B)
  - Accent: Teal (#4ECDC4)
- Responsive design
- Dark mode ready

## 📊 Database Schema

See [FIREBASE_SETUP.md](FIREBASE_SETUP.md) for complete Firestore schema.

Key collections:

- `users` - User profiles
- `dailyTasks` - Daily task assignments
- `mealPlans` - Weekly meal plans
- `chatHistory` - Chat conversations
- `nutritionLogs` - Food logging
- `userProgress` - Streak & stats

## 🔔 Notifications

Configured via `lib/data/datasources/local/notification_service.dart`:

- **Daily Motivation**: 6:00 AM (configurable)
  - Randomized motivational messages
  - Local notifications (no push)
  - Works offline

## 🎮 Gamification System

Three tier system:

1. **Streaks** - Consecutive days of completed tasks
2. **Badges** - Unlocked at milestones:
   - First Step (1 task)
   - Week Warrior (7 days)
   - Month Master (30 days)
   - Streak Starter (5-day streak)
   - Perfect Week (All tasks for 7 days)
   - And more...
3. **Progress** - Visual/numerical tracking

## 📝 API Integration

### Gemini API

- **Chat**: `geminiProModel`
- **Food Recognition**: `geminiProVisionModel`
- Bilingual support
- Context-aware responses

## 🧪 Testing

Testing framework setup:

```bash
flutter test
```

## 📦 Build & Release

### Android

```bash
flutter build apk --release
# or
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

## 🐛 Known Issues & Limitations

- Food recognition accuracy depends on image quality
- Gemini API has rate limits on free tier
- Notifications require proper permissions granted
- iOS requires physical device or simulator setup

## 📚 Documentation

- [Firebase Setup](FIREBASE_SETUP.md) - Complete Firebase configuration
- [Gemini API Docs](https://ai.google.dev/tutorials/android_quickstart)
- [Flutter Docs](https://flutter.dev/docs)

## 🤝 Contributing

1. Create a feature branch
2. Make your changes
3. Submit a pull request

## 📄 License

This project is licensed under the MIT License.

## 🎓 Learning Resources

- [Flutter Documentation](https://flutter.dev)
- [Firebase for Flutter](https://firebase.flutter.dev)
- [Riverpod Guide](https://riverpod.dev)
- [Google Generative AI](https://ai.google.dev)

## 📞 Support

For issues or questions:

1. Check the [FIREBASE_SETUP.md](FIREBASE_SETUP.md) troubleshooting section
2. Review the project's GitHub issues
3. Check Flutter/Firebase documentation

## 🚀 Future Enhancements

- Cloud Functions for complex meal generation
- ML Kit integration for better food recognition
- Google Sign-In support
- Wearable integration (Apple Watch, Wear OS)
- Social features (friend challenges)
- Advanced analytics dashboard
- Offline-first capability
- Multiple language support beyond Sinhala/English

---

**Happy coding! Transform your fitness journey with AI Fitness! 💪**
