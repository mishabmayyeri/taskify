# Taskify Task Manager App

A clean and modern task management application built with Flutter following Clean Architecture principles and BLoC state management pattern.

Download APK
📱 [Download APK from Google Drive](https://drive.google.com/drive/folders/1M1dXocGdBq69RDQvBgWFzOz8xaxq5ygU?usp=drive_link)

## Architecture

This project strictly follows **Clean Architecture** with clear separation of concerns across three layers:

- **Presentation Layer**: UI components and BLoC state management
- **Domain Layer**: Business logic and use cases
- **Data Layer**: Data persistence and repository implementations

### Key Technologies
- **State Management**: BLoC pattern for predictable state management
- **Dependency Injection**: GetIt for efficient dependency management
- **Local Storage**: Hive for task data persistence
- **Theme Management**: SharedPreferences for theme settings storage

## Project Structure

```
lib/
├── core/                    # Shared utilities and base classes
│   ├── constants/           # App constants
│   ├── error/               # Error handling
│   ├── theme/               # Theme management
│   └── usecases/           # Base use case
│
├── features/                # Feature-based modules
│   └── tasks/
│       ├── data/            # Data models and data sources
│       │   ├── datasources/ # Local data source implementation
│       │   ├── models/      # Task model
│       │   └── repositories/# Repository implementation
│       ├── domain/          # Business logic
│       │   ├── entities/    # Task entity
│       │   ├── repositories/# Repository interface
│       │   └── usecases/    # Task use cases
│       └── presentation/    # UI and state management
│           ├── bloc/        # BLoC state management
│           ├── pages/       # App screens
│           └── widgets/     # UI components
│
├── init_dependencies.dart # Dependency injection setup
└── main.dart               # App entry point
```

## Features

- ✅ Create, read, update, and delete tasks
- 🎯 Task prioritization (Low, Medium, High)
- 📅 Due date management
- ✓ Task status tracking (Pending/Completed)
- 🔍 Filter tasks by status
- 🌓 Dark/Light mode support
- 💾 Persistent local storage

## Installation

1. Clone the repository:
```bash
git clone https://github.com/mishabmayyeri/taskify-flutter.git
cd taskify-flutter
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Dependencies

```yaml
dependencies:
  flutter_bloc: ^8.1.3
  get_it: ^7.6.4
  hive: ^4.0.0-dev.2
  isar_flutter_libs: ^4.0.0-dev.13
  path_provider: ^2.1.0
  shared_preferences: ^2.2.2
  fpdart: ^1.1.0
  uuid: ^4.1.0
  intl: ^0.18.1
```
