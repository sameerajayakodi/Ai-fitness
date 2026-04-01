# AI Fitness - Implementation Guide

This guide walks through implementing and integrating all features of the AI Fitness app.

## Table of Contents

1. [Initial Setup](#initial-setup)
2. [Firebase Integration](#firebase-integration)
3. [Gemini API Integration](#gemini-api-integration)
4. [State Management](#state-management)
5. [Feature Implementation](#feature-implementation)
6. [Testing](#testing)

## Initial Setup

### 1.1 Project Structure

The project follows Clean Architecture with three layers:

- **Data Layer**: DataSources, Models, Repositories
- **Domain Layer**: Entities, Use Cases, Repository Interfaces
- **Presentation Layer**: Pages, Widgets, Providers (State Management)

### 1.2 Dependencies Verification

Verify all dependencies installed:

```bash
flutter pub get
flutter pub run build_runner build  # For Hive
```

### 1.3 Asset Setup

Create necessary directories:

```bash
mkdir -p assets/{images,animations,icons}
```

## Firebase Integration

### 2.1 Complete Setup Checklist

- [ ] Create Firebase project
- [ ] Configure authentication (Email/Password)
- [ ] Enable Firestore Database
- [ ] Enable Cloud Storage
- [ ] Set Firestore security rules
- [ ] Download config files (google-services.json, GoogleService-Info.plist)
- [ ] Update firebase_options.dart
- [ ] Update package names (Android & iOS)

_For detailed instructions, see FIREBASE_SETUP.md_

### 2.2 Initialize Firebase in main.dart

Current implementation in `lib/main.dart`:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}
```

This is already configured and ready to use.

### 2.3 Firestore Collections Setup

Required collections (auto-created on first write):

- `users` - User profiles
- `dailyTasks` - Daily task assignments
- `mealPlans` - Meal plans
- `chatHistory` - Chat messages
- `nutritionLogs` - Food logs
- `userProgress` - Stats and streaks

## Gemini API Integration

### 3.1 API Key Setup

**Option A: Direct Configuration (Development)**

```dart
// lib/core/constants/app_constants.dart
static const String geminiApiKey = 'YOUR_ACTUAL_KEY_HERE';
```

**Option B: Environment Variable (Production)**

```bash
# .env file
GEMINI_API_KEY=your_key_here
```

Then update main.dart:

```dart
const String geminiApiKey = String.fromEnvironment('GEMINI_API_KEY');
var geminiService = GeminiServiceImpl(apiKey: geminiApiKey);
```

### 3.2 Gemini Service Usage

The `GeminiServiceImpl` class in `lib/data/datasources/remote/gemini_service.dart` provides:

#### Chat Messages

```dart
final response = await geminiService.sendChatMessage(
  'How can I improve my cardio?',
  'english'  // or 'sinhala'
);
```

#### Food Recognition

```dart
final analysis = await geminiService.analyzeFoodImage(base64Image);
```

#### Meal Plan Generation

```dart
final meals = await geminiService.generateMealPlan(
  dietaryPreferences: 'Vegetarian, no dairy',
  calorieTarget: 2000,
);
```

## State Management

### 4.1 Riverpod Setup

Riverpod is used for state management. Wrap your app with `ProviderScope`:

```dart
// Already done in main.dart
runApp(
  const ProviderScope(
    child: MyApp(),
  ),
);
```

### 4.2 Creating Providers

Example provider for tasks:

```dart
// lib/presentation/providers/tasks_provider.dart
final dailyTasksProvider = StreamProvider.autoDispose.family<
  List<DailyTask>,
  String  // userId
>((ref, userId) {
  final taskDataSource = ref.watch(taskRemoteDataSourceProvider);
  return taskDataSource.watchDailyTasks(userId, DateTime.now()).asyncMap(
    (tasks) => tasks.map((t) => t.toEntity()).toList(),
  );
});
```

### 4.3 Using Providers in Widgets

```dart
// In any widget
ref.watch(dailyTasksProvider(userId)).when(
  data: (tasks) => ListView(...),
  loading: () => CircularProgressIndicator(),
  error: (err, stack) => Text('Error: $err'),
);
```

## Feature Implementation

### 5.1 Notification Service

**Setup** (lib/data/datasources/local/notification_service.dart):

1. Initialize in main:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final notificationService = NotificationServiceImpl(
    FlutterLocalNotificationsPlugin(),
  );
  await notificationService.initialize();

  // Schedule daily 6 AM notification
  await notificationService.scheduleDailyMotivation(6, 0);
}
```

2. Use in your app:

```dart
// Show instant notification
await notificationService.showInstantNotification(
  'Great Job!',
  'You completed today\'s tasks!',
);

// Update schedule
await notificationService.scheduleDailyMotivation(7, 30);
```

### 5.2 Daily Tasks Feature

**Implementation Steps**:

1. Create TaskRepository (domain layer)
2. Inject TaskRemoteDataSource and TaskLocalDataSource
3. Create TasksProvider using Riverpod
4. Build TasksPage UI
5. Connect UI to provider with `ref.watch()`

**Example flow**:

```dart
// Get tasks
final tasks = ref.watch(dailyTasksProvider(userId));

// Mark task complete
ref.read(taskRepositoryProvider).completeTask(taskId);

// UI updates automatically
```

### 5.3 Meal Plans Feature

**Components**:

- `MealPlanRepository` - Data management
- `MealPlansProvider` - State management
- `MealPlansPage` - UI
- `GeminiService` - AI meal generation

**Implementation**:

```dart
// Generate new meal plan
final mealPlan = await geminiService.generateMealPlan(
  preferences: 'Protein-rich, vegetarian',
  calorieTarget: 2000,
);

// Save to Firestore
await mealPlanRepository.createMealPlan(mealPlan);

// Watch and display
final activePlan = ref.watch(activeMealPlanProvider(userId));
```

### 5.4 Food Recognition Feature

**Flow**:

1. Capture image via ImagePicker
2. Convert to base64
3. Send to Gemini Vision API
4. Parse response
5. Save as NutritionLog
6. Update daily calorie total

**Implementation**:

```dart
// In FoodRecognitionPage
final pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
final base64 = base64Encode(await pickedFile!.readAsBytes());

final analysis = await geminiService.analyzeFoodImage(base64);
final nutritionLog = parseAnalysisToNutritionLog(analysis);

await nutritionRepository.logNutrition(nutritionLog);
```

### 5.5 Chat Feature

**Components**:

- `ChatRemoteDataSource` - Firestore storage
- `ChatRepository` - Business logic
- `ChatProvider` - State management
- `ChatPage` - UI with message list

**Flow**:

1. User types message
2. Save user message to Firestore
3. Send to Gemini API
4. Get response
5. Save AI response to Firestore
6. Update UI with StreamProvider

**Implementation**:

```dart
// Watch chat history
final chatHistory = ref.watch(chatHistoryProvider(userId));

// Send message
ref.read(chatRepositoryProvider).sendMessage(
  text: userMessage,
  language: selectedLanguage,  // 'sinhala' or 'english'
);
```

### 5.6 Gamification System

**Components**:

- Streak tracking in User entity
- Badge system in UserRepository
- BadgeProvider for unlocking logic

**Badge Unlock Logic**:

```dart
// In UserRepository
void checkAndUnlockBadges(User user) {
  if (user.currentStreak == 1) unlockBadge('First Step');
  if (user.currentStreak == 7) unlockBadge('Streak Starter');
  if (user.currentStreak == 30) unlockBadge('Month Master');
  if (user.longestStreak == 100) unlockBadge('Century Climber');
  // etc.
}
```

## Complete Implementation Roadmap

### Phase 1: Foundation ✅

- [x] Project structure
- [x] Theme setup
- [x] Constants and logging
- [x] Domain entities
- [x] Data models
- [x] Remote data sources
- [x] Notification service

### Phase 2: Integration 🔄

- [ ] Firebase configuration
- [ ] Gemini API key setup
- [ ] State management (Providers)
- [ ] Repository implementations
- [ ] Update all pages with real data

### Phase 3: Features

- [ ] User authentication page
- [ ] Connect home page navigation
- [ ] Implement chat with real Gemini
- [ ] Implement food recognition with image processing
- [ ] Implement meal plan generation
- [ ] Implement daily tasks with completion tracking
- [ ] Implement profile with user stats

### Phase 4: Enhancement

- [ ] Gamification logic
- [ ] Streak calculations
- [ ] Badge system
- [ ] Advanced UI/UX
- [ ] Offline capability
- [ ] Analytics

### Phase 5: Polish & Release

- [ ] Comprehensive testing
- [ ] Performance optimization
- [ ] Security audit
- [ ] App store optimization
- [ ] Launch

## Testing

### 5.1 Unit Testing

Create tests in `test/` directory:

```dart
// test/gemini_service_test.dart
void main() {
  group('GeminiService', () {
    test('sendChatMessage returns non-empty string', () async {
      final service = GeminiServiceImpl(apiKey: 'test-key');
      final response = await service.sendChatMessage(
        'Hello',
        'english',
      );
      expect(response, isNotEmpty);
    });
  });
}
```

Run tests:

```bash
flutter test
```

### 5.2 Widget Testing

Test individual widgets:

```dart
void main() {
  testWidgets('HomePage displays buttons', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.byIcon(Icons.chat), findsOneWidget);
    expect(find.byIcon(Icons.assignment), findsOneWidget);
  });
}
```

### 5.3 Integration Testing

Test complete features:

```bash
cd integration_test
flutter test integration_test/app_test.dart
```

## Deployment

### Android Release

```bash
flutter build apk --release
# or for Play Store
flutter build appbundle --release
```

### iOS Release

```bash
flutter build ios --release
# Then open in Xcode for final setup
```

### Key Secrets Management

- Use Firebase Remote Config for API keys in production
- Use environment variables for CI/CD
- Never commit .env files with real keys
- Use code signing for releases

## Troubleshooting

### Common Issues

**Issue**: Firebase initialization fails

- Check google-services.json and GoogleService-Info.plist paths
- Run `flutter clean && flutter pub get`
- Verify Firebase Console project exists

**Issue**: Gemini API returns errors

- Verify API key is correct
- Check API is enabled in Google Cloud Console
- Ensure billing is set up
- Check API limits/quota

**Issue**: State not updating in UI

- Ensure you're using `ref.watch()` not `ref.read()`
- Check provider type (Stream vs. Future)
- Verify repository is returning correct data

**Issue**: Notifications not showing

- Check permissions in system settings
- Verify Android notification channel
- Ensure iOS has notification capability
- Check notification scheduling time

## Next Steps

1. Set up Firebase project
2. Get Gemini API key
3. Update configuration files
4. Implement repositories
5. Connect UI to providers
6. Test all features
7. Deploy!

---

For more detailed information on specific features, check the source code comments and the README.md file.

**Happy Implementation! 🚀**
