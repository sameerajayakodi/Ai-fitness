# AI Fitness - Firebase & Setup Guide

This guide covers everything needed to set up the AI Fitness Flutter app with Firebase and Gemini API integration.

## Prerequisites

- Flutter SDK (3.0+)
- Firebase CLI (`npm install -g firebase-tools`)
- Gemini API key from [Google AI Studio](https://makersuite.google.com/app/apikey)
- Android Studio (for Android development)
- Xcode (for iOS development)

## Step 1: Firebase Project Setup

### 1.1 Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project"
3. Name it "AI Fitness" (or your preferred name)
4. Enable Google Analytics (optional)
5. Click "Create project"

### 1.2 Register Android App

1. In Firebase Console, click "Android" icon
2. Package name: `com.example.ai_fitness`
3. App nickname: "AI Fitness Android"
4. Register app
5. Download `google-services.json`
6. Place it in `android/app/` directory

### 1.3 Register iOS App

1. In Firebase Console, click "iOS" icon
2. Bundle ID: `com.example.aiFitness`
3. App nickname: "AI Fitness iOS"
4. Register app
5. Download `GoogleService-Info.plist`
6. Place it in `ios/Runner/` directory
7. Add to Xcode project

## Step 2: Enable Firebase Services

### 2.1 Authentication

1. In Firebase Console, go to "Authentication"
2. Click "Get Started"
3. Enable "Email/Password" provider
4. Click "Save"

### 2.2 Firestore Database

1. Go to "Firestore Database"
2. Click "Create database"
3. Choose "Start in production mode" (we'll set rules next)
4. Select your region
5. Wait for creation to complete

### 2.3 Storage

1. Go to "Storage"
2. Click "Get Started"
3. Start in production mode
4. Select your region
5. Done

## Step 3: Set Firestore Security Rules

Replace the default rules with:

```firestore
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users collection
    match /users/{document=**} {
      allow read, write: if request.auth.uid == resource.data.uid || request.auth.uid == document;
    }

    // Daily Tasks
    match /dailyTasks/{document=**} {
      allow read, write: if request.auth.uid == resource.data.userId;
    }

    // Meal Plans
    match /mealPlans/{document=**} {
      allow read, write: if request.auth.uid == resource.data.userId;
    }

    // Chat History
    match /chatHistory/{document=**} {
      allow read, write: if request.auth.uid == resource.data.userId;
    }

    // Nutrition Logs
    match /nutritionLogs/{document=**} {
      allow read, write: if request.auth.uid == resource.data.userId;
    }

    // User Progress
    match /userProgress/{document=**} {
      allow read, write: if request.auth.uid == resource.data.userId;
    }
  }
}
```

## Step 4: Get Firebase Configuration

### 4.1 iOS Configuration

1. Download GoogleService-Info.plist from Firebase
2. Add to Xcode: Right-click Runner > Add Files
3. Update `ios/Podfile`:

```ruby
# Add this to your Podfile
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    target.build_configurations.each do |config|
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
        '$(inherited)',
        'FIREBASE_ANALYTICS_COLLECTION_ENABLED=YES',
      ]
    end
  end
end
```

4. Run `flutter pub get`
5. Run `cd ios && pod install && cd ..`

### 4.2 Android Configuration

1. Download google-services.json
2. Place in `android/app/`
3. Update `android/build.gradle`:

```gradle
buildscript {
  dependencies {
    classpath 'com.google.gms:google-services:4.3.15'
  }
}
```

4. Update `android/app/build.gradle`:

```gradle
apply plugin: 'com.google.gms.google-services'
```

## Step 5: Configure Gemini API

1. Go to [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Create a new API key
3. Copy the key
4. Add to `lib/core/constants/app_constants.dart`:

```dart
static const String geminiApiKey = 'YOUR_ACTUAL_KEY_HERE';
```

**IMPORTANT**: For production, use environment variables:

```bash
# Create .env file
GEMINI_API_KEY=your_key_here
```

Then update `main.dart`:

```dart
const String geminiApiKey = String.fromEnvironment('GEMINI_API_KEY');
```

## Step 6: Update firebase_options.dart

Get this info from Firebase Console:

1. Go to Project Settings (gear icon)
2. Scroll to "Your apps" section
3. Click on your Android app for Android details
4. Click on your iOS app for iOS details
5. Update `lib/firebase_options.dart`:

```dart
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'YOUR_ANDROID_API_KEY',
  appId: 'YOUR_ANDROID_APP_ID',
  messagingSenderId: 'YOUR_MESSAGING_ID',
  projectId: 'your-project-id',
  storageBucket: 'your-project-id.appspot.com',
  databaseURL: 'https://your-project-id.firebaseio.com',
);

static const FirebaseOptions ios = FirebaseOptions(
  apiKey: 'YOUR_IOS_API_KEY',
  appId: 'YOUR_IOS_APP_ID',
  messagingSenderId: 'YOUR_MESSAGING_ID',
  projectId: 'your-project-id',
  storageBucket: 'your-project-id.appspot.com',
  databaseURL: 'https://your-project-id.firebaseio.com',
  iosBundleId: 'com.example.aiFitness',
);
```

## Step 7: Update Package Names

### Android

1. Edit `android/app/build.gradle`:

```gradle
applicationId "com.example.ai_fitness"
```

2. Rename package in Android Studio:
   - Right-click on `android/app/src/main/kotlin/com/example/flutter_application_1`
   - Refactor > Rename
   - Change to `ai_fitness`

### iOS

1. Edit `ios/Runner.xcodeproj/project.pbxproj`:
   - Search for `PRODUCT_BUNDLE_IDENTIFIER`
   - Change to `com.example.aiFitness`

## Step 8: Dependencies Installation

Run in your Flutter project:

```bash
flutter pub get
```

To regenerate Hive adapters:

```bash
flutter pub run build_runner build
```

## Step 9: Android - Request Permissions

Update `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
```

## Step 10: iOS - Add Capabilities

In Xcode:

1. Select Runner > Runner > Signing & Capabilities
2. Click "+ Capability"
3. Add: "Push Notifications", "Background Modes"
4. Enable "Remote notifications" under Background Modes

## Step 11: Run the App

```bash
# Flutter clean (if needed)
flutter clean

# Get dependencies
flutter pub get

# Run on Android
flutter run -d android

# Run on iOS
flutter run -d ios

# Or just run
flutter run
```

## Step 12: Test Firebase Connection

Create a test user:

1. Go to Firebase Authentication Console
2. Click "Add user"
3. Email: `test@example.com`
4. Password: `Test@123456`

The app should be able to authenticate with this user.

## Firestore Database Structure

```
users/
  {uid}/
    - id: string
    - name: string
    - email: string
    - photoUrl: string (optional)
    - dailyCalorieGoal: number
    - currentStreak: number
    - longestStreak: number
    - unlockedBadges: string[]
    - createdAt: timestamp
    - lastNotificationTime: timestamp

mealPlans/
  {planId}/
    - id: string
    - userId: string
    - meals: Meal[]
    - totalCalories: number
    - createdAt: timestamp
    - validFrom: timestamp
    - validUntil: timestamp
    - isActive: boolean

dailyTasks/
  {taskId}/
    - id: string
    - userId: string
    - title: string
    - description: string
    - category: string
    - durationMinutes: number
    - isCompleted: boolean
    - createdAt: timestamp
    - completedAt: timestamp (optional)
    - dueDate: timestamp

chatHistory/
  {messageId}/
    - id: string
    - userId: string
    - text: string
    - language: string
    - isUserMessage: boolean
    - timestamp: timestamp
    - geminiText: string (optional)

nutritionLogs/
  {logId}/
    - id: string
    - userId: string
    - foodName: string
    - foodImageUrl: string (optional)
    - calories: number
    - protein: number
    - carbs: number
    - fat: number
    - analysisText: string (optional)
    - timestamp: timestamp
```

## Troubleshooting

### Firebase Initialization Error

- Check if google-services.json (Android) and GoogleService-Info.plist (iOS) are correctly placed
- Run `flutter clean && flutter pub get`

### Gemini API Error

- Verify API key is correct
- Check API is enabled in Google Cloud Console
- Ensure you have billing enabled (free tier has limits)

### Notification Not Showing

- Android: Check notification channel creation
- iOS: Ensure Post Notifications capability is added
- Both: Grant app permissions in system settings

### Firestore Connection Issues

- Check internet connection
- Verify security rules are correctly set
- Check if user is authenticated before Firestore calls

## Next Steps

1. Connect Google Sign-In (recommended for better UX)
2. Set up Cloud Functions for complex meal plan generation
3. Implement ML Kit for better food recognition
4. Add Firebase Analytics for app usage tracking
5. Set up Firebase Remote Config for feature flags
