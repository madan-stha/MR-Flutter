Username: adarshghimire122@gmail.com
Password: Microsoft@143@MS

// new
"email":"madhu.shrestha@ippcs.com.au",
"password":"Microsoft@143@MS"

# Metal Recycle: Mobile App Documentation

## Getting Started

### Project Overview

Metal Recycling App repository! This application aims to revolutionize the metal recycling industry by providing a comprehensive digital solution for managing recycling operations efficiently. Built with Laravel for the backend logic handling REST API endpoints.

## Architecture Overview

The project follows the Clean Architecture principles, separating the app into different layers:

- **Presentation Layer**: Contains the Flutter widgets, Blocs, and UI-related logic.
- **Domain Layer**: Contains business logic and use cases.
- **Data Layer**: Manages data sources such as APIs and local databases.

## State Management

The app uses the Provider pattern for state management. Provider are responsible for managing the application's state and business logic.

### Prerequisites

- **Software:**

  - Flutter SDK (version >=3.3.0 <4.0.0)
  - Dart SDK
  - Android Studio / Xcode (for Android / iOS development)

- **Hardware:**
  - Suitable development machine (Windows/Mac/Linux)
  - Android / iOS device or emulator/simulator

### Installation Instructions

1. Clone the repository from [GitHub Repository](https://github.com/madhu-shrestha/sms_flutter).
2. Ensure you have Flutter and Dart SDK installed on your machine. Follow the official [Flutter Installation Guide](https://flutter.dev/docs/get-started/install) if not already installed.
3. Open the project in your preferred IDE (Android Studio, IntelliJ, VS Code).
4. Run `flutter pub get` to install dependencies.
5. Connect a device/emulator and run `flutter run` to launch the application.

## System Requirements

- **Minimum Hardware:**

  - Processor: Dual-core 2.0 GHz or equivalent
  - RAM: 8 GB

- **Minimum Software:**
  - Operating System: Windows 7 or later, macOS, or Linux
  - Flutter SDK (version >=3.3.0 <4.0.0)
  - Dart SDK

## Project Structure

```
Metal Recycle
│
├── Extension
│   │ 
│   └── entension.dart      
│
├── Src
│   ├── api           
│   ├── config         
│   ├── constant          
│   ├── model           
│   ├── provider          
│   ├── screen             
│   ├── services            
│   ├── utils           
│   ├── widgets         
│   └── src.dart       
│
└── main.dart              # Entry point of the application
```

## Additional Documentation

### Deployment Process

- **Android:**
  - Generate an APK or bundle using `flutter build apk` or `flutter build appbundle`.
  - Follow Google's guidelines for deploying Android apps.
- **iOS:**
  - Generate an iOS build using Xcode or command line.
  - Follow Apple's guidelines for deploying iOS apps.

### Troubleshooting Guide

- **Issue:** App crashes on startup.
  - **Solution:** Ensure all dependencies are correctly installed and up-to-date. Run `flutter doctor` for any potential issues.

### Coding Style Guide

- Follow the Dart style guide provided by [Dart Style Guide](https://dart.dev/effective-dart/style).

### Version Control

- The project uses Git for version control. Ensure you have Git installed on your machine.
- Clone the repository using `git clone https://github.com/madhu-shrestha/smc-flutter.git`.

### Resources

- Official Flutter Documentation: [Flutter Docs](https://flutter.dev/docs)
- Dart Style Guide: [Dart Style Guide](https://dart.dev/effective-dart/style)

This documentation aims to provide comprehensive guidance for setting up, developing, and deploying the Metal Recycle Driver mobile app. For any further assistance or queries, refer to the official Flutter documentation or reach out to the project maintainers.
