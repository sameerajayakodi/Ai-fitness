# AI Fitness - Developer Quick Reference

Quick reference for common development tasks.

## 🚀 Quick Commands

### Project Setup

```bash
flutter clean              # Clean build
flutter pub get            # Install dependencies
flutter pub upgrade        # Update packages
flutter doctor             # Check environment
flutter analyze            # Check code quality
flutter format lib/        # Format code
```

### Running App

```bash
flutter run                # Run on default device
flutter run -d android     # Android device/emulator
flutter run -d ios         # iOS simulator/device
flutter run --profile      # Profile mode (performance)
flutter run --release      # Release mode
```

### Code Generation

```bash
flutter pub run build_runner build      # Full build
flutter pub run build_runner watch      # Watch mode (auto-rebuild)
flutter pub run build_runner clean      # Clean generated files
```

### Testing

```bash
flutter test               # Run all tests
flutter test -v            # Verbose output
flutter test --coverage    # With coverage report
flutter test test/file.dart # Single test file
```

### Debugging

```bash
flutter logs               # View app logs
flutter logs --clear       # Clear logs
flutter attach            # Attach to running app
flutter devices            # List available devices
```

### Building

```bash
flutter build apk                # Android APK
flutter build appbundle          # Android App Bundle
flutter build ios                # iOS build
flutter build ios --release      # iOS release build
```

---

## 📁 Creating New Files

### New Page

```bash
mkdir -p lib/presentation/pages/new_page
touch lib/presentation/pages/new_page/new_page.dart
```

Template:

```dart
import 'package:flutter/material.dart';

class NewPage extends StatefulWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Page')),
      body: Center(child: Text('Content here')),
    );
  }
}
```

### New Provider

```bash
touch lib/presentation/providers/new_provider.dart
```

Template:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

final newProvider = Provider<String>((ref) {
  return 'Provider value';
});

// Or async
final asyncNewProvider = FutureProvider<String>((ref) async {
  return 'Async value';
});

// Or stream-based
final streamNewProvider = StreamProvider<String>((ref) {
  // return Stream
});
```

### New Service

```bash
touch lib/data/datasources/remote/new_service.dart
```

Template:

```dart
abstract class NewService {
  Future<String> getData();
}

class NewServiceImpl implements NewService {
  @override
  Future<String> getData() async {
    // Implementation
    return 'Data';
  }
}
```

---

## 🎯 Common Development Tasks

### Add New Permission

**Android**: `android/app/src/main/AndroidManifest.xml`

```xml
<uses-permission android:name="android.permission.PERMISSION_NAME" />
```

**iOS**: `ios/Runner/Info.plist`

```xml
<key>NSPermissionKey</key>
<string>Description for user</string>
```

### Add New Dependency

```bash
flutter pub add package_name
flutter pub get
```

### Update Dependencies

```bash
flutter pub outdated          # Check outdated packages
flutter pub upgrade           # Upgrade all packages
flutter pub upgrade package_name  # Upgrade specific
```

### Handle Firebase Error

**Error**: `MissingPluginException`

- Solution: `flutter clean && flutter pub get && flutter run`

**Error**: `PlatformException`

- Solution: Check Firebase rules and authentication

**Error**: `FirebaseException`

- Check internet connection
- Verify Firebase configuration files
- Check Firestore security rules

### Fix iOS Build Issues

```bash
cd ios
rm -rf Pods
rm Podfile.lock
pod install
cd ..
flutter run -d ios
```

### Clean Everything

```bash
flutter clean
rm -rf build/
rm -rf .dart_tool/
rm -rf pubspec.lock
flutter pub get
flutter run
```

---

## 🔨 State Management Patterns

### Provider (Simple Value)

```dart
final counterProvider = Provider<int>((ref) => 0);

// Use in widget
final count = ref.watch(counterProvider);
```

### StateNotifierProvider (Mutable State)

```dart
final counterProvider = StateNotifierProvider<
  CounterNotifier,
  int
>((ref) => CounterNotifier());

// Use in widget
final count = ref.watch(counterProvider);
ref.read(counterProvider.notifier).increment();
```

### FutureProvider (Async One-time)

```dart
final userProvider = FutureProvider<User>((ref) async {
  return await repository.getUser();
});

// Use in widget
ref.watch(userProvider).when(
  data: (user) => Text(user.name),
  loading: () => CircularProgressIndicator(),
  error: (err, stack) => Text('Error: $err'),
);
```

### StreamProvider (Realtime Data)

```dart
final tasksProvider = StreamProvider<List<Task>>((ref) {
  return repository.watchTasks();
});

// Use in widget - same as FutureProvider
```

### Family (Parameterized Provider)

```dart
final userProvider = FutureProvider.family<
  User,
  String  // parameter type
>((ref, userId) async {
  return await repository.getUser(userId);
});

// Use in widget
ref.watch(userProvider(userId)).when(...);
```

---

## 🎨 Widget Patterns

### StatefulWidget

```dart
class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

### Consumer Widget (with Riverpod)

```dart
class MyWidget extends ConsumerWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(myProvider);
    return Container();
  }
}
```

### Consumer (StatefulWidget with Riverpod)

```dart
class MyWidget extends ConsumerStatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<MyWidget> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(myProvider);
    return Container();
  }
}
```

---

## 🔥 Firebase Patterns

### Add Data to Firestore

```dart
await _firestore.collection('users').doc(userId).set({
  'name': 'John',
  'email': 'john@example.com',
  'createdAt': DateTime.now().toIso8601String(),
});
```

### Update Firestore Data

```dart
await _firestore.collection('users').doc(userId).update({
  'name': 'Jane',
});
```

### Read from Firestore

```dart
final doc = await _firestore.collection('users').doc(userId).get();
final data = doc.data();  // Returns Map<String, dynamic>
```

### Query Firestore

```dart
final query = await _firestore
    .collection('tasks')
    .where('userId', isEqualTo: userId)
    .where('isCompleted', isEqualTo: false)
    .orderBy('createdAt', descending: true)
    .get();

List<Task> tasks = query.docs.map((doc) {
  return TaskModel.fromJson({...doc.data(), 'id': doc.id}).toEntity();
}).toList();
```

### Stream from Firestore

```dart
Stream<List<Task>> watchTasks(String userId) {
  return _firestore
      .collection('tasks')
      .where('userId', isEqualTo: userId)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => TaskModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList());
}
```

### Delete from Firestore

```dart
await _firestore.collection('tasks').doc(taskId).delete();
```

### Batch Operations

```dart
final batch = _firestore.batch();

batch.set(_firestore.collection('users').doc(userId), userData);
batch.update(_firestore.collection('tasks').doc(taskId), {'completed': true});
batch.delete(_firestore.collection('old').doc(oldId));

await batch.commit();
```

---

## 📱 Gemini API Patterns

### Initialize

```dart
final geminiService = GeminiServiceImpl(apiKey: 'YOUR_KEY');
```

### Chat Message

```dart
final response = await geminiService.sendChatMessage(
  'How do I improve cardio?',
  'english',  // or 'sinhala'
);
```

### Analyze Food Image

```dart
import 'dart:convert';
import 'dart:io';

final imageBytes = await File(imagePath).readAsBytes();
final base64Image = base64Encode(imageBytes);

final analysis = await geminiService.analyzeFoodImage(base64Image);
```

### Generate Meal Plan

```dart
final meals = await geminiService.generateMealPlan(
  dietaryPreferences: 'Vegetarian, low-carb',
  calorieTarget: 2000,
);
```

---

## 🔔 Notifications

### Initialize

```dart
final notificationService = NotificationServiceImpl(
  FlutterLocalNotificationsPlugin(),
);
await notificationService.initialize();
```

### Schedule Daily

```dart
await notificationService.scheduleDailyMotivation(6, 0);  // 6 AM
```

### Show Instant

```dart
await notificationService.showInstantNotification(
  'Title',
  'Body message',
);
```

### Cancel

```dart
await notificationService.cancelScheduledNotification();
```

---

## 🧪 Testing Patterns

### Unit Test

```dart
void main() {
  group('TaskRepository', () {
    test('should return task list', () async {
      final repo = TaskRepository();
      final tasks = await repo.getTasks(userId);
      expect(tasks, isNotEmpty);
    });
  });
}
```

### Widget Test

```dart
void main() {
  testWidgets('HomePage displays title', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('AI Fitness'), findsOneWidget);
  });
}
```

---

## 🐛 Debugging Tips

### Print Statements

```dart
debugPrint('Value: $value');  // Better than print()
```

### Log Objects

```dart
AppLogger.debug('Data: ${jsonEncode(data)}');
```

### Breakpoints

- Click line number in editor
- Run `flutter run` (debug mode)
- Interact with app to hit breakpoint

### Hot Reload

- Save file in editor
- Press `r` in terminal
- App updates instantly

### Hot Restart

- Press `R` in terminal
- Full app restart

---

## 📊 Performance Optimization

### Use const Constructors

```dart
// Good
const MyWidget()

// Avoid
MyWidget()
```

### Use ListView.builder

```dart
// Good - only renders visible items
ListView.builder(
  itemBuilder: (context, index) => MyTile(items[index]),
)

// Avoid - renders all items
Column(children: items.map((item) => MyTile(item)).toList())
```

### Lazy Load Images

```dart
Image.network(
  url,
  loadingBuilder: (context, child, progress) {
    return progress == null ? child : CircularProgressIndicator();
  },
)
```

---

## 🔑 Git Commands

```bash
git add .                    # Stage all changes
git commit -m "message"      # Commit
git push origin branch       # Push to branch
git pull origin branch       # Pull changes
git log --oneline           # View commit history
git status                   # Check status
```

---

## ⚙️ Configuration Files

### pubspec.yaml

- Add/update dependencies here
- Run `flutter pub get` after changes

### firebase_options.dart

- Firebase project configuration
- Platform-specific settings

### app_constants.dart

- API keys
- Default values
- String constants

### app_theme.dart

- Colors
- Text styles
- Component themes

---

## 🚨 Common Errors & Solutions

| Error                      | Solution                                                  |
| -------------------------- | --------------------------------------------------------- |
| `MissingPluginException`   | `flutter clean && flutter pub get`                        |
| `Pod install failed`       | `cd ios && pod install && cd ..`                          |
| `Firebase not initialized` | Check `firebase_options.dart`                             |
| `Gemini API 401`           | Verify API key is correct                                 |
| `Hot reload failed`        | Try `R` (hot restart)                                     |
| `Device not found`         | Run `flutter devices`                                     |
| `Port already in use`      | Change port: `flutter run -d<device> --device-port=12345` |

---

## 💡 Pro Tips

1. **Use `ref.listen()` for side effects**

   ```dart
   ref.listen(myProvider, (prev, next) {
     // Do something when provider changes
   });
   ```

2. **Invalidate providers manually**

   ```dart
   ref.refresh(myProvider);
   ref.invalidate(myProvider);
   ```

3. **Use `const` everywhere possible** - Improves performance

4. **Extract complex widgets** - Easier to test and reuse

5. **Use `StreamProvider` for real-time data** - Auto-updates UI

6. **Log important state changes** - Helps debugging

7. **Test edge cases** - Empty lists, null values, errors

8. **Use named parameters** - Makes code readable

---

## 📚 Useful Resources

- [Flutter Docs](https://flutter.dev/docs)
- [Riverpod Docs](https://riverpod.dev)
- [Firebase Flutter](https://firebase.flutter.dev)
- [Google Generative AI](https://ai.google.dev)
- [Dart Docs](https://dart.dev/guides)

---

**Keep this reference handy during development!**
