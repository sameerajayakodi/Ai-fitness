# ⚡ Flutter Setup - QUICK REFERENCE (5 minutes)

## 3 Simple Steps

### Step 1️⃣ Download & Extract (2 min)

```
1. Visit: https://flutter.dev/docs/get-started/install/windows
2. Download: "Flutter Windows" (latest version)
3. Extract to: C:\src\flutter
   (Create C:\src folder if needed)
```

### Step 2️⃣ Add to PATH (1 min)

```
1. Press: Win + X
2. Click: "System"
3. Click: "Advanced system settings"
4. Click: "Environment Variables"
5. Click "Path" under "System variables"
6. Click "Edit"
7. Click "New"
8. Add: C:\src\flutter\bin
9. Click OK three times
```

### Step 3️⃣ Verify (2 min)

```
Close ALL command prompts
Open NEW command prompt
Type: flutter --version

✅ If you see version info, you're done!
```

---

## Next Commands

```bash
# Go to your project
cd C:\Users\samee\Documents\Ai-fitness

# Get Flutter dependencies
flutter pub get

# Run the app
flutter run
```

---

## ❌ If Still Getting Error

Try these in order:

### Option 1: Restart Computer

```
- Close everything
- Restart Windows
- Open new command prompt
- Try: flutter --version
```

### Option 2: Verify Folder

```
Open File Explorer and check:
- C:\src\flutter exists? ✓
- C:\src\flutter\bin exists? ✓
- C:\src\flutter\bin\flutter.bat exists? ✓
```

### Option 3: Manual PATH Setup

Run this as Administrator in Command Prompt:

```batch
setx PATH "%PATH%;C:\src\flutter\bin"
```

Then close and reopen Command Prompt.

### Option 4: Full Reset

```batch
REM Run as Administrator
setx FLUTTER_HOME C:\src\flutter
setx PATH "%PATH%;C:\src\flutter\bin"
REM Close CMD and restart computer
```

---

## 📍 Check PATH is Set

Open Command Prompt and run:

```batch
echo %PATH%
```

Output should contain: `C:\src\flutter\bin`

If not, PATH not set correctly - go back to Step 2.

---

## ✅ Verification Checklist

- [ ] Downloaded Flutter from official site
- [ ] Extracted to C:\src\flutter
- [ ] Added C:\src\flutter\bin to PATH
- [ ] Closed all command prompts
- [ ] Opened new command prompt
- [ ] Ran: `flutter --version` ✓
- [ ] Ran: `cd C:\Users\samee\Documents\Ai-fitness`
- [ ] Ran: `flutter pub get` ✓
- [ ] Ready to code!

---

## 🆘 Still Having Issues?

See full guide: `FLUTTER_INSTALLATION.md`

Or contact Flutter support: https://flutter.dev/docs/resources/faq

---

**Once working, run this:**

```bash
cd C:\Users\samee\Documents\Ai-fitness
flutter pub get
flutter run
```

**You'll see your AI Fitness app! 🎉**
