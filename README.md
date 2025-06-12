# EventK - Flutter Mobile App

## Project Overview

Eventk is a cross-platform event management application built with Flutter that enables users to effortlessly discover, explore, and register for events. The app provides comprehensive event details such as dates, descriptions, categories, pricing, and ticket options, all fetched dynamically from a backend API,
A key feature of Eventk is the Organizations section, which allows users to follow and interact with event organizers,Designed for both Windows and macOS.

## System Requirements

### Minimum Requirements
- **RAM**: 8GB (16GB recommended)
- **Storage**: 10GB free space
- **Operating System**: 
  - Windows 10 (64-bit) or later
  - macOS 10.14 (Mojave) or later
- **Internet Connection**: Required for initial setup and dependencies

## Prerequisites

Before setting up EventK, ensure you have the following installed:

### Required Software
1. **Flutter SDK** (Latest stable version)
2. **Dart SDK** (Included with Flutter)
3. **Git** (Version control)
4. **Code Editor** (VS Code, Android Studio, or IntelliJ recommended)

### Platform-Specific Requirements

#### For Android Development
- **Android Studio** (Arctic Fox or later)
- **Android SDK** (API level 21 or higher)
- **Java Development Kit (JDK)** 11 or later

#### For iOS Development (macOS only)
- **Xcode** (13.0 or later)
- **iOS SDK** (iOS 11.0 or later)
- **CocoaPods** (Dependency manager)

## Setup Instructions

### Windows Setup

#### Step 1: Install Flutter SDK
1. Download Flutter SDK from [https://flutter.dev/docs/get-started/install/windows](https://flutter.dev/docs/get-started/install/windows)
2. Extract the zip file to `C:\src\flutter` (avoid paths with spaces or special characters)
3. Add Flutter to your PATH:
   - Open "Edit environment variables for your account"
   - Under "User variables", find and select "Path", then click "Edit"
   - Click "New" and add `C:\src\flutter\bin`
   - Click "OK" to close all dialogs

#### Step 2: Install VS Code and Android SDK
1. Download and install VS Code from [https://code.visualstudio.com/](https://code.visualstudio.com/)
2. Install the Flutter extension:
   - Open VS Code
   - Go to Extensions (Ctrl+Shift+X)
   - Search for "Flutter" and install the official Flutter extension
   - This will also install the Dart extension automatically
3. Install Android SDK via Android Studio or standalone:
   - **Option A**: Download Android Studio from [https://developer.android.com/studio](https://developer.android.com/studio) (recommended for easier SDK management)
   - **Option B**: Download command line tools only from [https://developer.android.com/studio#command-tools](https://developer.android.com/studio#command-tools)
4. If using Android Studio, launch it and complete the setup wizard to install Android SDK, SDK tools, and create a virtual device (AVD)

#### Step 3: Configure Flutter
1. Open Command Prompt or PowerShell
2. Run `flutter doctor` to check for any missing dependencies
3. Accept Android licenses: `flutter doctor --android-licenses`

#### Step 4: Clone and Setup EventK
1. Clone the repository:
   ```bash
   git clone [https://github.com/3112002/Eventk.git]
   cd eventk
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Verify everything is working:
   ```bash
   flutter doctor -v
   ```

#### Step 5: Run the Application
1. Connect an Android device or start an emulator
2. Run the app:
   ```bash
   flutter run
   ```

### macOS Setup

#### Step 1: Install Flutter SDK
1. Download Flutter SDK from [https://flutter.dev/docs/get-started/install/macos](https://flutter.dev/docs/get-started/install/macos)
2. Extract the file:
   ```bash
   cd ~/development
   unzip ~/Downloads/flutter_macos_[version].zip
   ```

3. Add Flutter to your PATH by adding this line to your shell profile (`.bashrc`, `.zshrc`, etc.):
   ```bash
   export PATH="$PATH:`pwd`/flutter/bin"
   ```

4. Reload your shell or run:
   ```bash
   source ~/.zshrc  # or ~/.bashrc
   ```

#### Step 2: Install Xcode (for iOS)
1. Install Xcode from the Mac App Store
2. Configure Xcode command-line tools:
   ```bash
   sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
   sudo xcodebuild -runFirstLaunch
   ```

3. Install CocoaPods:
   ```bash
   sudo gem install cocoapods
   ```

#### Step 3: Install VS Code and Android SDK (for Android)
1. Download and install VS Code from [https://code.visualstudio.com/](https://code.visualstudio.com/)
2. Install the Flutter extension:
   - Open VS Code
   - Go to Extensions (⌘+Shift+X)
   - Search for "Flutter" and install the official Flutter extension
   - This will also install the Dart extension automatically
3. Install Android SDK via Android Studio or standalone:
   - **Option A**: Download Android Studio from [https://developer.android.com/studio](https://developer.android.com/studio) (recommended for easier SDK management)
   - **Option B**: Download command line tools only from [https://developer.android.com/studio#command-tools](https://developer.android.com/studio#command-tools)
4. If using Android Studio, launch it and complete the setup wizard to install Android SDK, SDK tools, and create an AVD

#### Step 4: Configure Flutter
1. Run Flutter doctor:
   ```bash
   flutter doctor
   ```

2. Accept Android licenses:
   ```bash
   flutter doctor --android-licenses
   ```

#### Step 5: Clone and Setup EventK
1. Clone the repository:
   ```bash
   git clone [https://github.com/3112002/Eventk.git]
   cd eventk
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. For iOS, install iOS dependencies:
   ```bash
   cd ios
   pod install
   cd ..
   ```

#### Step 6: Run the Application

**For Android:**
```bash
flutter run
```

**For iOS:**
```bash
flutter run -d ios
```

## Configuration Steps

### Environment Variables
If your app requires API keys or configuration:

1. Create a `.env` file in the project root (if not present)
2. Add your configuration variables:
   ```
   API_KEY=your_api_key_here
   BASE_URL=https://your-api-url.com
   ```

### Firebase Setup (if applicable)
1. Create a Firebase project at [https://console.firebase.google.com](https://console.firebase.google.com)
2. Add your Android/iOS app to the project
3. Download and place configuration files:
   - Android: `google-services.json` in `android/app/`
   - iOS: `GoogleService-Info.plist` in `ios/Runner/`

## Build for Production

### Android APK
```bash
flutter build apk --release
```

### Android App Bundle
```bash
flutter build appbundle --release
```

### iOS (macOS only)
```bash
flutter build ios --release
```

## Troubleshooting

### Common Issues and Solutions

#### Flutter Doctor Issues
**Problem**: `flutter doctor` shows missing dependencies
**Solution**: Follow the specific instructions provided by `flutter doctor` output

#### Android License Issues
**Problem**: Android licenses not accepted
**Solution**: Run `flutter doctor --android-licenses` and accept all licenses

#### iOS Build Failures
**Problem**: iOS build fails with CocoaPods errors
**Solution**: 
```bash
cd ios
pod deintegrate
pod install
cd ..
flutter clean
flutter pub get
```

#### Path Issues (Windows)
**Problem**: 'flutter' is not recognized as a command
**Solution**: Verify Flutter is properly added to your PATH environment variable

#### Gradle Issues (Android)
**Problem**: Gradle build failures
**Solution**: 
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

#### Device Not Detected
**Problem**: Device not showing up for debugging
**Solution**: 
- Enable Developer Options and USB Debugging on Android
- Trust the computer on iOS devices
- Check USB cable and connection

#### Memory Issues
**Problem**: Build process runs out of memory
**Solution**: 
- Close unnecessary applications
- Increase available RAM
- Use `flutter build` with `--verbose` to identify memory-heavy operations

### Getting Help

If you encounter issues not covered here:

1. Check the [Flutter documentation](https://flutter.dev/docs)
2. Search [Flutter GitHub issues](https://github.com/flutter/flutter/issues)
3. Visit [Flutter Community](https://flutter.dev/community)
4. Create an issue in this repository with:
   - Your operating system and version
   - Flutter version (`flutter --version`)
   - Complete error message
   - Steps to reproduce the issue

## Development

### Code Style
This project follows the official [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style).

### Testing
Run tests with:
```bash
flutter test
```




