# Flutter Installation Guide for Windows

Complete step-by-step guide to install Flutter and configure PATH.

## 🚀 Quick Installation (5 minutes)

### Step 1: Download Flutter SDK

1. Go to: https://flutter.dev/docs/get-started/install/windows
2. Click **"Flutter Windows 3.13.0 (or latest)"** to download
3. File will be named something like: `flutter_windows_3.13.0-stable.zip`
4. **Important**: Note where you download it (usually Downloads folder)

### Step 2: Extract Flutter

1. Navigate to your Downloads folder
2. Right-click the `flutter_windows_*.zip` file
3. Select **"Extract All..."**
4. Choose location: **C:\src** (create this folder if it doesn't exist)
   - This will create: `C:\src\flutter`
5. Wait for extraction (2-3 minutes)
6. Verify folder exists: `C:\src\flutter\bin\flutter.bat`

### Step 3: Add Flutter to PATH (Windows)

#### Option A: Using GUI (Easiest - Recommended)

1. **Open Environment Variables**:
   - Press `Win + X` → Click "System"
   - Or right-click "This PC" → "Properties"
   - Click "Advanced system settings" (left side)
   - Click "Environment Variables..." button

2. **Add to PATH**:
   - Under "User variables" or "System variables", find `Path`
   - Click "Edit..."
   - Click "New"
   - Add: `C:\src\flutter\bin`
   - Click "OK", "OK", "OK"

3. **Restart Terminal/CMD**:
   - Close all command prompt windows
   - Open a new one
   - Type: `flutter --version`
   - Should show version info ✅

#### Option B: Using Command Prompt (If Option A doesn't work)

Run this command as Administrator:

```batch
setx PATH "%PATH%;C:\src\flutter\bin"
```

Then restart your command prompt and verify:

```batch
flutter --version
```

### Step 4: Accept Flutter License

Run this command:

```batch
flutter doctor --android-licenses
```

Press `y` and Enter multiple times to accept all licenses.

### Step 5: Verify Installation

```batch
flutter doctor
```

You should see something like:

```
[✓] Flutter (Channel stable, 3.13.0, on Microsoft Windows [Version 10.0.xxxx])
[✓] Windows Version (Installed version of Windows is version 10 or higher)
[✗] Android toolchain - develop for Android devices (Android SDK 33.0.0)
[✓] Chrome - develop for web
[✓] Visual Studio - develop for windows apps
[✓] Android Studio (version 2022.x.x)
```

---

## 🔧 Detailed Windows Setup

### Install Java (Required for Android)

Android development requires Java:

1. Go to: https://www.oracle.com/java/technologies/downloads/#jdk17-windows
2. Download "Windows x64 Installer"
3. Run installer and follow steps
4. After install, verify:
   ```batch
   java -version
   ```

### Install Android Studio (Required for Android)

1. Go to: https://developer.android.com/studio
2. Download "Windows (10 GB)" version
3. Run installer with default settings
4. Launch Android Studio
5. Complete initial setup wizard
6. This installs Android SDK automatically

### Install Visual Studio Community (Optional - for Windows apps)

1. Go to: https://visualstudio.microsoft.com/downloads/
2. Download "Visual Studio Community"
3. Run and select **"Desktop development with C++"**
4. Complete installation

---

## 📍 Correct PATH Setup

### What Should be in PATH

Add these to your Windows PATH (in order):

```
C:\src\flutter\bin
C:\Program Files\Java\jdk-17\bin          (if Java installed)
C:\Users\YourUsername\AppData\Local\Android\sdk\platform-tools
C:\Users\YourUsername\AppData\Local\Android\sdk\tools\bin
```

### How to Verify PATH

1. Open Command Prompt
2. Run: `echo %PATH%`
3. Should contain: `C:\src\flutter\bin`
4. Run: `flutter --version` (should work)
5. Run: `dart --version` (should work)

---

## ✅ Complete Verification Checklist

After following above steps, verify everything works:

```batch
REM Test 1: Flutter version
flutter --version
REM Should output: Flutter X.X.X, Dart X.X.X, ...

REM Test 2: Dart version
dart --version
REM Should output: Dart SDK version X.X.X ...

REM Test 3: Check setup
flutter doctor
REM Should show checkmarks for most items

REM Test 4: Go to your project
cd C:\Users\samee\Documents\Ai-fitness

REM Test 5: Get dependencies
flutter pub get
REM Should work without errors (first run takes 1-2 min)

REM Test 6: Run app
flutter run
REM Should launch the app!
```

---

## 🆘 Troubleshooting

### Error: "flutter is not recognized"

**Problem**: PATH not set correctly

**Solution**:

1. Verify `C:\src\flutter\bin` is in PATH
2. Run command as fresh terminal (close and reopen)
3. Restart computer if above doesn't work
4. Check: `echo %PATH%` should contain flutter path

### Error: "No Android SDK found"

**Problem**: Android SDK not installed

**Solution**:

1. Install Android Studio (see above)
2. Run: `flutter config --android-studio-path "C:\Program Files\Android\Android Studio"`
3. Run: `flutter doctor --android-licenses`

### Error: "Java not found"

**Problem**: Java not in PATH

**Solution**:

1. Install Java JDK (see above)
2. Add to PATH: `C:\Program Files\Java\jdk-17\bin`
3. Restart terminal

### Commands working in some terminals but not others?

**Solution**:

1. Close ALL command prompt windows
2. Open new one
3. PATH changes require full restart

---

## 📝 Complete Windows PATH Setup (If Manual)

### Step-by-step to add to PATH:

1. **Find Your Flutter Location**:
   - Example: `C:\src\flutter\bin`
   - Verify this path exists and contains `flutter.bat`

2. **Edit PATH Environmental Variable**:
   - Press `Win + R`
   - Type: `sysdm.cpl`
   - Press Enter
   - Click "Advanced" tab
   - Click "Environment Variables" button
   - In "User variables" section:
     - Click "New"
     - Variable name: `FLUTTER_HOME`
     - Variable value: `C:\src\flutter`
     - Click OK
3. **Edit System PATH**:
   - In "System variables" section:
     - Find and click `Path`
     - Click "Edit"
     - Click "New"
     - Add: `C:\src\flutter\bin`
     - Click "OK"

4. **Close and Reopen**:
   - Close all command prompt windows completely
   - Open new Command Prompt
   - Type: `flutter --version`
   - Should work now!

---

## 🎯 Quick Setup Command (if comfortable with command line)

Copy and paste this (as Administrator in Command Prompt):

```batch
@echo off
REM Create directory for Flutter
if not exist C:\src mkdir C:\src

REM Add to PATH temporary for this session
set PATH=%PATH%;C:\src\flutter\bin

REM Permanent PATH (requires admin)
setx FLUTTER_HOME C:\src\flutter
setx PATH "%PATH%;C:\src\flutter\bin"

REM Verify
flutter --version
```

---

## ✨ After Installation Complete

You should be able to:

```bash
# Check versions
flutter --version
dart --version

# Navigate to your project
cd C:\Users\samee\Documents\Ai-fitness

# Get dependencies
flutter pub get

# Run on connected device/emulator
flutter run

# Run on specific platform
flutter run -d android
flutter run -d windows
flutter run -d chrome
```

---

## 🔗 Important Links

- **Flutter Downloads**: https://flutter.dev/docs/get-started/install
- **Java JDK**: https://www.oracle.com/java/technologies/downloads/
- **Android Studio**: https://developer.android.com/studio
- **Visual Studio**: https://visualstudio.microsoft.com/downloads/

---

## 📞 If Still Stuck

1. Verify `C:\src\flutter` folder exists
2. Verify `C:\src\flutter\bin\flutter.bat` file exists
3. Verify PATH contains `C:\src\flutter\bin`
4. Restart computer (not just terminal)
5. Try in new Command Prompt window as Administrator

**Common mistake**: Forgetting to restart terminal after PATH changes!

---

**Once complete, proceed with**: `flutter pub get` in your project folder

**Happy coding! 🚀**
