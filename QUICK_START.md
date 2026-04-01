# AI Fitness - Quick Start Guide

Get the AI Fitness app running in 15 minutes!

## ⚡ Super Quick Setup (5 minutes)

### 1. Install Dependencies

```bash
cd ai-fitness
flutter pub get
```

### 2. Get Gemini API Key

- Visit: https://makersuite.google.com/app/apikey
- Create an API key
- Update `lib/core/constants/app_constants.dart`:
  ```dart
  static const String geminiApiKey = 'YOUR_KEY_HERE';
  ```

### 3. Run the App

```bash
flutter run
```

That's it! You now have the UI and basic structure running.

## 🔥 Complete Firebase Setup (10 minutes)

### 1. Create Firebase Project

1. Go to: https://console.firebase.google.com/
2. Click "Add Project" → Name it "AI Fitness"
3. Complete setup

### 2. Download Configuration Files

**Android:**

- Download `google-services.json`
- Place in `android/app/`

**iOS:**

- Download `GoogleService-Info.plist`
- Open `ios/Runner.xcworkspace`
- Drag file to Xcode project

### 3. Update firebase_options.dart

Copy your project details into `lib/firebase_options.dart`

### 4. Enable Services

In Firebase Console:

- Authentication → Email/Password → Enable
- Firestore Database → Create Database
- Storage → Get Started

## 📱 Run on Device

### Android

```bash
flutter run -d android
```

### iOS

```bash
flutter devices  # Find device ID
flutter run -d <device_id>
```

## ✅ Verify Installation

You should see:

- ✓ Home page with 4 buttons
- ✓ Bottom navigation bar
- ✓ App theme applied

## 🎯 Next Steps

1. **Test Chat**: Click "Start Chatting" button
2. **Test Tasks**: Click "View Daily Tasks"
3. **Test Food Recognition**: Click "Scan Food"
4. **Test Meals**: Click "View Meal Plan"

## 🚀 Enable Features Progressively

### Feature 1: Daily Notifications (5 min)

Update `main.dart`:

```dart
final notificationService = NotificationServiceImpl(
  FlutterLocalNotificationsPlugin(),
);
await notificationService.initialize();
await notificationService.scheduleDailyMotivation(6, 0);
```

### Feature 2: Chat with Gemini (3 min)

In `chat_page.dart`, replace TODO:

```dart
final response = await GeminiServiceImpl(
  apiKey: 'YOUR_KEY',
).sendChatMessage(_messageController.text, 'english');

setState(() {
  _messages.add({
    'text': response,
    'isUser': 'false',
  });
});
```

### Feature 3: Food Recognition (5 min)

In `food_recognition_page.dart`, update analysis:

```dart
final base64 = base64Encode(
  await File(_selectedImage!.path).readAsBytes(),
);

final analysis = await GeminiServiceImpl(
  apiKey: 'YOUR_KEY',
).analyzeFoodImage(base64);

setState(() {
  _analysisResult = analysis;
});
```

## 📊 Firestore Setup (Quick Version)

### Create Collections

Click "Create collection" and name:

1. `users`
2. `dailyTasks`
3. `mealPlans`
4. `chatHistory`
5. `nutritionLogs`

### Set Security Rules

Go to Rules tab:

```firestore
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    allow read, write: if request.auth != null;
  }
}
```

⚠️ _Update with proper rules before production_

## 🐛 Troubleshooting

### App crashes on startup?

```bash
flutter clean
flutter pub get
flutter run
```

### Firebase not connecting?

- Check internet connection
- Verify google-services.json exists in `android/app/`
- Run: `flutter clean`

### Gemini API returns 401?

- Verify API key is correct
- Check API is enabled in Google Cloud Console

### Dark screen on iOS?

- Make sure GoogleService-Info.plist is in Runner group in Xcode
- Rebuild: `flutter clean && flutter run`

## 📚 Full Documentation

- **Detailed Firebase Setup**: [FIREBASE_SETUP.md](FIREBASE_SETUP.md)
- **Implementation Guide**: [IMPLEMENTATION_GUIDE.md](IMPLEMENTATION_GUIDE.md)
- **Project README**: [README.md](README.md)

## 🎓 Key Files to Know

```
lib/
├── main.dart              ← App entry point
├── core/
│   ├── theme/app_theme.dart        ← Colors & styling
│   └── constants/app_constants.dart ← API key & settings
├── presentation/pages/
│   ├── home/home_page.dart         ← Main screen
│   ├── chat/chat_page.dart         ← AI coach
│   └── food_recognition/food_recognition_page.dart  ← Food scanner
└── data/datasources/remote/
    ├── gemini_service.dart         ← AI integration
    └── *_remote_data_source.dart   ← Firebase calls
```

## 💡 Pro Tips

1. **Faster Development**: Use Hot Reload (R in terminal)
2. **Debug Firebase**: Open [Firebase Console](https://console.firebase.google.com/) in browser
3. **Test Chat**: Try: "How do I lose weight safely?"
4. **Check Logs**: `flutter logs` in terminal
5. **Profile App**: `flutter run --profile`

## 🚀 Deployment Checklist

Before launching:

- [ ] Firebase project created and configured
- [ ] Gemini API key obtained and verified
- [ ] All Firebase security rules set
- [ ] App tested on real device
- [ ] Icons and splash screen customized
- [ ] App name and bundle ID updated
- [ ] Privacy policy added
- [ ] Terms of service added

## 📞 Common Commands

```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run

# Run on specific device
flutter run -d android
flutter devices

# Build release
flutter build apk --release
flutter build ios --release

# View logs
flutter logs

# Analyze code
flutter analyze

# Run tests
flutter test

# Format code
flutter format lib/
```

## 🎉 You're All Set!

You now have:

- ✅ Flutter project structure
- ✅ UI pages and navigation
- ✅ Firebase integration ready
- ✅ Gemini API setup
- ✅ Notification system
- ✅ Database schema

**Next**: Configure Firebase, add your API key, and you're ready to launch! 🚀

---

**Need help?** Check the full docs: [README.md](README.md)

**Happy coding!** 💪
