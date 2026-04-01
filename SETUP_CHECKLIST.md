# AI Fitness - Setup Checklist

Use this checklist to ensure everything is configured correctly before development.

## Pre-Development Setup Checklist

### Phase 1: Environment & Tools ✅

- [ ] Flutter SDK installed (version 3.0+)
- [ ] Android Studio installed
- [ ] Xcode installed (macOS only)
- [ ] Firebase CLI installed (`npm install -g firebase-tools`)
- [ ] Git initialized and configured
- [ ] Editor/IDE configured with Flutter extensions

### Phase 2: Project Initialization

- [ ] Clone/create project in `ai-fitness` directory
- [ ] Run `flutter pub get`
- [ ] Run `flutter doctor` - all checks green
- [ ] Verify all files are in place (use file tree)

### Phase 3: Create Firebase Project

- [ ] Go to https://console.firebase.google.com
- [ ] Create new project named "AI Fitness"
- [ ] Wait for project creation (2-3 minutes)
- [ ] Select your region
- [ ] Verify project loads in console

### Phase 4: Android Configuration

- [ ] In Firebase, register Android app
  - [ ] Package name: `com.example.ai_fitness`
  - [ ] App nickname: "AI Fitness Android"
- [ ] Download `google-services.json`
- [ ] Place in `android/app/` directory
- [ ] Update `android/app/build.gradle`:
  ```gradle
  apply plugin: 'com.google.gms.google-services'
  ```
- [ ] Update `android/build.gradle`:
  ```gradle
  classpath 'com.google.gms:google-services:4.3.15'
  ```
- [ ] Update `android/app/src/main/AndroidManifest.xml`:
  ```xml
  <uses-permission android:name="android.permission.CAMERA" />
  <uses-permission android:name="android.permission.INTERNET" />
  <uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
  ```

### Phase 5: iOS Configuration

- [ ] In Firebase, register iOS app
  - [ ] Bundle ID: `com.example.aiFitness`
  - [ ] App nickname: "AI Fitness iOS"
- [ ] Download `GoogleService-Info.plist`
- [ ] Open `ios/Runner.xcworkspace` in Xcode
- [ ] Drag `GoogleService-Info.plist` into Xcode project
- [ ] Ensure "Copy items if needed" is checked
- [ ] Build Settings: Ensure correct pod configuration
- [ ] Run in Terminal:
  ```bash
  cd ios && pod install && cd ..
  ```

### Phase 6: Firebase Services Setup

- [ ] Enable Authentication
  - [ ] Go to Firebase Console → Authentication
  - [ ] Click "Get Started"
  - [ ] Enable "Email/Password" provider
  - [ ] Save

- [ ] Create Firestore Database
  - [ ] Go to Firestore Database
  - [ ] Click "Create database"
  - [ ] Start in "Production mode" (we'll set rules)
  - [ ] Select region closest to you
  - [ ] Wait for creation

- [ ] Enable Cloud Storage
  - [ ] Go to Storage
  - [ ] Click "Get Started"
  - [ ] Start in "Production mode"
  - [ ] Select same region as Firestore

### Phase 7: Firestore Security Rules

- [ ] In Firestore, go to "Rules" tab
- [ ] Replace default rules with:
  ```firestore
  rules_version = '2';
  service cloud.firestore {
    match /databases/{database}/documents {
      match /users/{document=**} {
        allow read, write: if request.auth.uid == document;
      }
      match /dailyTasks/{document=**} {
        allow read, write: if request.auth.uid == resource.data.userId;
      }
      match /mealPlans/{document=**} {
        allow read, write: if request.auth.uid == resource.data.userId;
      }
      match /chatHistory/{document=**} {
        allow read, write: if request.auth.uid == resource.data.userId;
      }
      match /nutritionLogs/{document=**} {
        allow read, write: if request.auth.uid == resource.data.userId;
      }
    }
  }
  ```
- [ ] Click "Publish"

### Phase 8: Get Firebase Configuration

- [ ] In Firebase Console, go to "Project Settings" (⚙️ icon)
- [ ] Scroll to "Your apps" section
- [ ] For Android app, find:
  - [ ] API Key
  - [ ] App ID
  - [ ] Messaging Sender ID
  - [ ] Project ID
  - [ ] Storage Bucket
  - [ ] Database URL
- [ ] For iOS app, find same values
- [ ] Copy all values

### Phase 9: Update firebase_options.dart

- [ ] Open `lib/firebase_options.dart`
- [ ] Update Android values:
  ```dart
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'YOUR_ANDROID_API_KEY',
    appId: 'YOUR_ANDROID_APP_ID',
    messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
    projectId: 'your-project-id',
    storageBucket: 'your-project-id.appspot.com',
    databaseURL: 'https://your-project-id.firebaseio.com',
  );
  ```
- [ ] Update iOS values (same, add iosBundleId):
  ```dart
  static const FireativeOptions ios = FirebaseOptions(
    apiKey: 'YOUR_IOS_API_KEY',
    appId: 'YOUR_IOS_APP_ID',
    messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
    projectId: 'your-project-id',
    storageBucket: 'your-project-id.appspot.com',
    databaseURL: 'https://your-project-id.firebaseio.com',
    iosBundleId: 'com.example.aiFitness',
  );
  ```
- [ ] Verify all fields are filled

### Phase 10: Get Gemini API Key

- [ ] Visit https://makersuite.google.com/app/apikey
- [ ] Sign in with your Google account
- [ ] Click "Create API key"
- [ ] Copy the API key
- [ ] **IMPORTANT**: Don't share this key!

### Phase 11: Configure Gemini API Key

**Option A: Development (Quick)**

- [ ] Open `lib/core/constants/app_constants.dart`
- [ ] Find: `static const String geminiApiKey = 'YOUR_GEMINI_API_KEY';`
- [ ] Replace with your actual key (temporary for dev)

**Option B: Production (Recommended)**

- [ ] Create `.env` file in project root
- [ ] Add: `GEMINI_API_KEY=your_key_here`
- [ ] Add `.env` to `.gitignore`
- [ ] Update `main.dart` to read from environment

### Phase 12: Update Package Names

**Android Package Name**

- [ ] Open `android/app/build.gradle`
- [ ] Find `applicationId "com.example.flutter_application_1"`
- [ ] Change to `applicationId "com.example.ai_fitness"`
- [ ] Save file

**iOS Bundle ID**

- [ ] Open `ios/Runner.xcodeproj` in Xcode
- [ ] Select Runner project
- [ ] Select Runner target
- [ ] Go to Build Settings
- [ ] Search for "Bundle Identifier"
- [ ] Change to `com.example.aiFitness`

### Phase 13: Create Firebase Test User

- [ ] In Firebase Console, go to Authentication
- [ ] Click "Add user"
- [ ] Email: `test@example.com`
- [ ] Password: `Test@123456`
- [ ] Click "Create user"
- [ ] Note these credentials for testing

### Phase 14: Install Flutter Dependencies

- [ ] Run:
  ```bash
  flutter clean
  flutter pub get
  flutter pub run build_runner build
  ```
- [ ] Wait for completion (may take 2-3 minutes)
- [ ] Verify no errors

### Phase 15: Verify Setup

- [ ] Check all files exist:
  - [ ] `android/app/google-services.json`
  - [ ] `ios/Runner/GoogleService-Info.plist`
  - [ ] `lib/firebase_options.dart` (updated)
  - [ ] `lib/core/constants/app_constants.dart` (Gemini key set)

- [ ] Run checks:
  ```bash
  flutter doctor
  flutter analyze
  ```
- [ ] No critical errors should appear

### Phase 16: Test Firebase Connection

**Create test file: `test/firebase_test.dart`**

```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  print('Testing Firebase initialization...');

  try {
    await Firebase.initializeApp();
    print('✅ Firebase initialized');

    // Test Firestore
    final db = FirebaseFirestore.instance;
    print('✅ Firestore accessible');

    // Test Authentication
    final auth = FirebaseAuth.instance;
    print('✅ Authentication accessible');

    print('\nAll tests passed! Firebase is properly configured.');
  } catch (e) {
    print('❌ Error: $e');
  }
}
```

Run: `dart test/firebase_test.dart`

### Phase 17: First Run - Debug Mode

- [ ] Run:
  ```bash
  flutter run
  ```
- [ ] App should launch without crashes
- [ ] You should see:
  - [ ] App name in app bar
  - [ ] 4 buttons on home page
  - [ ] Bottom navigation bar with 5 items
  - [ ] No Firebase errors in logs

### Phase 18: Test on Real Device

**Android:**

- [ ] Connect Android device or start emulator
- [ ] Ensure USB debugging enabled (if physical device)
- [ ] Run:
  ```bash
  flutter devices          # Verify device is listed
  flutter run -d android   # Run on Android
  ```

**iOS:**

- [ ] Connect iPhone or start simulator
- [ ] Run:
  ```bash
  flutter devices          # Verify device is listed
  flutter run -d ios       # Run on iOS
  ```

### Phase 19: Environment Variables Setup

- [ ] Create `.env` file in project root
- [ ] Add all variables from `.env.example`
- [ ] Fill in your actual values
- [ ] Add `.env` to `.gitignore`:
  ```
  .env
  .env.*.local
  ```
- [ ] If using pubspec, add `dotenv: ^4.1.0` to dependencies

### Phase 20: Documentation Review

- [ ] Read `README.md` - Project overview
- [ ] Read `QUICK_START.md` - Quick reference
- [ ] Read `FIREBASE_SETUP.md` - Firebase details
- [ ] Read `IMPLEMENTATION_GUIDE.md` - Feature guide
- [ ] Bookmark these for reference

---

## Verification Test

Run this to verify everything works:

```bash
# 1. Clean
flutter clean

# 2. Get dependencies
flutter pub get

# 3. Analyze
flutter analyze

# 4. Run on device
flutter run

# 5. Check logs (in another terminal)
flutter logs
```

**Expected Output:**

```
✅ No errors in flutter analyze
✅ App launches successfully
✅ Firebase initialization message in logs
✅ App shows 5 pages with navigation
```

---

## Troubleshooting During Setup

### Firebase Issues

**Problem**: Google services JSON not found

- **Solution**: Make sure `google-services.json` is in `android/app/`

**Problem**: Pod install fails on iOS

- **Solution**: Run `cd ios && rm podfile.lock && pod install && cd ..`

**Problem**: Firebase initialization error

- **Solution**: Verify `GoogleService-Info.plist` in Xcode project

### Gemini API Issues

**Problem**: API key returns 401 error

- **Solution**: Verify key is correct, check it's enabled in Google Cloud

**Problem**: Can't find Gemini API

- **Solution**: Must go to makersuite.google.com (not cloud.google.com)

### Flutter Issues

**Problem**: Flutter device not found

- **Solution**: Run `flutter devices` to verify, check USB cables

**Problem**: Hot reload doesn't work

- **Solution**: Try `flutter run` fresh, may need `flutter clean`

---

## After Setup Completion ✅

Once all items checked:

1. **Ready for Development**
   - All Firebase services running
   - Gemini API available
   - App compiles and runs

2. **Next Step**: Follow [IMPLEMENTATION_GUIDE.md](IMPLEMENTATION_GUIDE.md)
   - Create repositories
   - Create state management (Riverpod providers)
   - Connect UI pages to data

3. **Development Timeline**
   - Repositories: 1-2 hours
   - Providers: 1-2 hours
   - UI Integration: 2-3 hours
   - Features & Polish: 1-2 hours
   - **Total**: 6-8 hours to MVP

---

## Final Verification Checklist

Before starting development:

```
✅ Flutter environment ready (flutter doctor clean)
✅ Android configuration complete
✅ iOS configuration complete
✅ Firebase project created and running
✅ Firestore database accessible
✅ Authentication working
✅ Cloud Storage enabled
✅ Security rules published
✅ firebase_options.dart updated
✅ Gemini API key obtained
✅ Package names updated (Android & iOS)
✅ Test user created
✅ App runs without Firebase errors
✅ Documentation reviewed
```

---

## Support & Help

**If stuck at any point:**

1. Check FIREBASE_SETUP.md troubleshooting section
2. Check QUICK_START.md for common issues
3. Review Flutter documentation
4. Check Firebase documentation
5. Verify all steps were completed

---

**You're all set! Time to build! 🚀**
