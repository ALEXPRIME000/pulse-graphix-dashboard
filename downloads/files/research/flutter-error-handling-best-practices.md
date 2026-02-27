# Flutter Error Handling Best Practices
*Comprehensive Guide for Catching ALL Errors in Flutter Apps*

**Author:** Research for Kabundji  
**Date:** February 16, 2026  
**Purpose:** Reference for building a Claude Code / OpenClaw skill for complete Flutter error handling

---

## Table of Contents

1. [Flutter Error Handling Architecture](#1-flutter-error-handling-architecture)
2. [Crash Reporting Services Comparison](#2-crash-reporting-services-comparison)
3. [ANR Detection (App Not Responding)](#3-anr-detection-app-not-responding)
4. [Logging Best Practices](#4-logging-best-practices)
5. [Production Error Handling Patterns](#5-production-error-handling-patterns)
6. [Recommended Stack](#6-recommended-stack)

---

## 1. Flutter Error Handling Architecture

### Overview: The Multi-Layer Defense Strategy

Flutter apps have **multiple execution contexts** where errors can occur:
- **Framework errors** (build, layout, paint phases)
- **Async errors** (outside Flutter's callbacks)
- **Zone errors** (unhandled exceptions in isolates)
- **Platform errors** (native code failures)

To catch **ALL** errors, you need **4 mechanisms working together**:

### 1.1 `FlutterError.onError` - Framework Errors

**Purpose:** Catches errors that occur within the Flutter framework (widget lifecycle, rendering, layout).

**When it triggers:**
- RenderFlex overflow errors
- Widget build() exceptions
- Layout/paint phase errors
- Assertion failures during development

**Implementation:**

```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  // Setup Flutter framework error handler
  FlutterError.onError = (FlutterErrorDetails details) {
    // Log to console in debug mode (preserves stack trace visibility)
    FlutterError.dumpErrorToConsole(details);
    
    // In release mode, send to crash reporting
    if (kReleaseMode) {
      // Send to Crashlytics, Sentry, etc.
      _reportError(details.exception, details.stack, details.context);
    }
    
    // Optionally show custom error widget
    // ErrorWidget.builder is set separately
  };
  
  runApp(const MyApp());
}

void _reportError(dynamic exception, StackTrace? stackTrace, DiagnosticsNode? context) {
  // Your crash reporting logic here
  print('FLUTTER ERROR: $exception');
}
```

**Key Points:**
- Handles **synchronous** errors in the Flutter framework
- Does NOT catch async errors (Future/Stream failures)
- Does NOT catch errors outside Flutter callbacks

---

### 1.2 `PlatformDispatcher.instance.onError` - Async Platform Errors

**Purpose:** Catches errors that occur outside of Flutter's callbacks, particularly async errors from platform channels.

**When it triggers:**
- `MethodChannel.invokeMethod()` failures
- Platform plugin errors
- Async errors not caught by `FlutterError.onError`

**Implementation:**

```dart
import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  // Setup platform-level error handler
  PlatformDispatcher.instance.onError = (error, stack) {
    print('PLATFORM ERROR: $error');
    
    // Send to crash reporting
    _reportError(error, stack, null);
    
    // Return true to indicate error was handled
    return true;
  };
  
  runApp(const MyApp());
}
```

**Key Points:**
- Catches errors that `FlutterError.onError` misses
- Essential for apps using platform channels
- Return `true` to mark error as handled

---

### 1.3 `runZonedGuarded` - Ultimate Safety Net

**Purpose:** Catches **ALL** unhandled errors and exceptions, both sync and async, that occur within the zone.

**When it triggers:**
- Any unhandled exception in async code
- Errors that slip through `FlutterError.onError` and `PlatformDispatcher.onError`
- Isolate errors (when configured)

**Why it's critical:** This is your **ultimate catch-all**. Without it, some async errors can crash your app silently.

**Implementation:**

```dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // Initialize any required services first
  WidgetsFlutterBinding.ensureInitialized();
  
  // Setup the ultimate error catching zone
  runZonedGuarded<Future<void>>(
    () async {
      // 1. Setup Flutter framework error handler
      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.dumpErrorToConsole(details);
        if (kReleaseMode) {
          _reportFlutterError(details);
        }
      };
      
      // 2. Setup platform error handler (optional, as runZonedGuarded catches these too)
      PlatformDispatcher.instance.onError = (error, stack) {
        _reportError(error, stack);
        return true;
      };
      
      // 3. Run the app
      runApp(const MyApp());
    },
    (error, stackTrace) {
      // This catches EVERYTHING that wasn't caught above
      print('UNCAUGHT ERROR: $error');
      if (kReleaseMode) {
        _reportError(error, stackTrace);
      }
    },
  );
}

void _reportFlutterError(FlutterErrorDetails details) {
  // Your crash reporting for Flutter errors
}

void _reportError(dynamic error, StackTrace stackTrace) {
  // Your crash reporting for general errors
}
```

**Key Points:**
- **This is the gold standard** for production apps
- Catches errors from ANY execution context
- Should be the outermost wrapper in `main()`

---

### 1.4 `Isolate.current.addErrorListener` - Isolate Errors

**Purpose:** Catches errors from background isolates (e.g., compute() functions, Isolate.spawn()).

**When it triggers:**
- Errors in background isolates
- Compute function failures

**Implementation:**

```dart
import 'dart:async';
import 'dart:isolate';

void setupIsolateErrorHandling() {
  Isolate.current.addErrorListener(
    RawReceivePort((dynamic pair) {
      final List<dynamic> errorAndStacktrace = pair;
      final error = errorAndStacktrace.first;
      final stackTrace = StackTrace.fromString(errorAndStacktrace.last.toString());
      
      print('ISOLATE ERROR: $error');
      _reportError(error, stackTrace);
    }).sendPort,
  );
}

// Call this in main() after WidgetsFlutterBinding.ensureInitialized()
```

**Key Points:**
- Required if you use isolates for background work
- Most apps don't need this unless using `Isolate.spawn()` directly
- `compute()` errors are usually caught by `runZonedGuarded`

---

### 1.5 Complete Error Handling Setup (All 4 Mechanisms)

**Production-Ready `main.dart`:**

```dart
import 'dart:async';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // 1. Initialize Flutter binding first
  WidgetsFlutterBinding.ensureInitialized();
  
  // 2. Setup isolate error handling (if you use isolates)
  Isolate.current.addErrorListener(
    RawReceivePort((dynamic pair) {
      final error = pair.first;
      final stackTrace = StackTrace.fromString(pair.last.toString());
      _reportError(error, stackTrace, 'isolate');
    }).sendPort,
  );
  
  // 3. Run everything inside runZonedGuarded
  runZonedGuarded<Future<void>>(
    () async {
      // 4. Setup Flutter framework error handler
      FlutterError.onError = (FlutterErrorDetails details) {
        // Always show in console during development
        FlutterError.dumpErrorToConsole(details);
        
        // Report in release mode
        if (kReleaseMode) {
          _reportFlutterError(details);
        }
      };
      
      // 5. Setup platform dispatcher error handler
      PlatformDispatcher.instance.onError = (error, stack) {
        _reportError(error, stack, 'platform');
        return true;
      };
      
      // 6. Optional: Customize error widget
      ErrorWidget.builder = (FlutterErrorDetails details) {
        return kReleaseMode
            ? const ErrorScreen() // Your custom error widget
            : ErrorWidget(details.exception); // Default in debug
      };
      
      // 7. Run the app
      runApp(const MyApp());
    },
    (error, stackTrace) {
      // Ultimate catch-all for any unhandled errors
      _reportError(error, stackTrace, 'zone');
    },
  );
}

void _reportFlutterError(FlutterErrorDetails details) {
  // Send to crash reporting service
  // Example: FirebaseCrashlytics.instance.recordFlutterError(details);
  // Example: Sentry.captureException(details.exception, stackTrace: details.stack);
  print('Flutter error reported: ${details.exception}');
}

void _reportError(dynamic error, StackTrace? stackTrace, String source) {
  // Send to crash reporting service
  // Example: FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
  // Example: Sentry.captureException(error, stackTrace: stackTrace);
  print('Error from $source: $error');
}

// Custom error widget for release mode
class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red),
            SizedBox(height: 16),
            Text(
              'Something went wrong',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Please restart the app'),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Error Handling Demo',
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error Handling')),
      body: Center(child: Text('App is running')),
    );
  }
}
```

---

## 2. Crash Reporting Services Comparison

### Overview

Crash reporting is **essential** for production apps. Users won't tell you about crashes — you need automated reporting.

### 2.1 Service Comparison Table

| Service | Pricing | Flutter Support | Platform Coverage | Key Features | Best For |
|---------|---------|-----------------|-------------------|--------------|----------|
| **Firebase Crashlytics** | Free | ★★★★★ Excellent | iOS, Android, Web (limited) | - Free forever<br>- Google ecosystem integration<br>- Easy setup<br>- Good Flutter SDK | Apps already using Firebase, indie devs, free tier needs |
| **Sentry** | Free tier (5K events/mo), then $26+/mo | ★★★★★ Excellent | iOS, Android, Web, Desktop | - Open source core<br>- Session replay<br>- Performance monitoring<br>- Rich error context<br>- Breadcrumbs | Cross-platform apps, teams needing web support, privacy-conscious |
| **BugSnag** | $59+/mo (no free tier) | ★★★★ Good | iOS, Android, Web | - Stability score<br>- Release tracking<br>- User segmentation<br>- Excellent error grouping | Enterprise apps, teams with budget, stability-focused |
| **Datadog** | $15+/user/mo | ★★★ Fair | iOS, Android, Web | - Full observability suite<br>- APM + Logs + RUM<br>- Great for backend too | Apps needing full-stack monitoring, backend + frontend |
| **Instabug** | $83+/mo | ★★★★ Good | iOS, Android | - In-app bug reporting<br>- User feedback<br>- Screenshots<br>- Session replay | Apps needing user feedback tools, beta testing |

### 2.2 Detailed Service Analysis

#### **Firebase Crashlytics** (Google)

**Pros:**
- ✅ **100% free** (no event limits, no user limits)
- ✅ Excellent Flutter plugin: `firebase_crashlytics`
- ✅ Easy setup (10 minutes)
- ✅ Integrates with Firebase ecosystem (Analytics, Performance)
- ✅ Good crash grouping and deduplication
- ✅ Real-time alerts

**Cons:**
- ❌ Web support is limited (better in 2024 but not feature-complete)
- ❌ Desktop (Windows/macOS/Linux) not officially supported
- ❌ Less powerful than Sentry for advanced debugging
- ❌ Requires Google account and Firebase project

**Setup:**
```yaml
# pubspec.yaml
dependencies:
  firebase_core: ^3.8.1
  firebase_crashlytics: ^4.2.0
```

```dart
// main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  // Enable crash reporting
  FlutterError.onError = (details) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(details);
  };
  
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  
  runApp(MyApp());
}
```

**Best for:** Indie developers, startups, apps already using Firebase

---

#### **Sentry** (Open Source)

**Pros:**
- ✅ **Best-in-class Flutter support** (official SDK)
- ✅ **Full cross-platform**: iOS, Android, Web, Desktop
- ✅ Free tier: 5,000 events/month (good for small apps)
- ✅ Session replay (see what user did before crash)
- ✅ Performance monitoring
- ✅ Breadcrumbs (log trail before error)
- ✅ Source maps for web
- ✅ Self-hostable (privacy/compliance)

**Cons:**
- ❌ Can get expensive ($26/mo for 50K events)
- ❌ Free tier is limited
- ❌ Slightly more complex setup than Crashlytics

**Setup:**
```yaml
# pubspec.yaml
dependencies:
  sentry_flutter: ^8.11.0
```

```dart
// main.dart
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn = 'YOUR_SENTRY_DSN';
      options.tracesSampleRate = 1.0; // Performance monitoring
      options.enableAutoSessionTracking = true;
    },
    appRunner: () => runApp(MyApp()),
  );
}
```

**Best for:** Cross-platform apps (especially web), teams needing advanced debugging, privacy-conscious teams (self-hosting option)

---

#### **BugSnag**

**Pros:**
- ✅ Best stability scoring (shows app health trends)
- ✅ Excellent error grouping
- ✅ Release health tracking
- ✅ User segmentation

**Cons:**
- ❌ **No free tier** ($59/mo minimum)
- ❌ Pricey for indie devs
- ❌ Flutter support not as mature as Sentry/Crashlytics

**Best for:** Enterprise apps with budget, teams focused on release quality

---

#### **Datadog**

**Pros:**
- ✅ Full observability (logs, APM, RUM, traces)
- ✅ Great for full-stack monitoring (backend + frontend)
- ✅ Powerful querying and dashboards

**Cons:**
- ❌ Expensive ($15/user/mo minimum)
- ❌ Overkill if you only need crash reporting
- ❌ Flutter support is decent but not best-in-class

**Best for:** Large teams needing full observability across backend and frontend

---

#### **Instabug**

**Pros:**
- ✅ In-app bug reporting (users can submit bugs with screenshots)
- ✅ User feedback collection
- ✅ Session replay

**Cons:**
- ❌ No free tier ($83/mo minimum)
- ❌ More focused on beta testing than production monitoring

**Best for:** Apps in beta, apps needing user feedback tools

---

### 2.3 Pricing Summary (2024)

| Service | Free Tier | Paid Tier |
|---------|-----------|-----------|
| **Firebase Crashlytics** | Unlimited (FREE) | N/A |
| **Sentry** | 5K events/mo | $26/mo (50K events) |
| **BugSnag** | None | $59/mo (starter) |
| **Datadog** | 14-day trial | $15/user/mo |
| **Instabug** | None | $83/mo |

---

### 2.4 Feature Comparison

| Feature | Crashlytics | Sentry | BugSnag | Datadog | Instabug |
|---------|-------------|--------|---------|---------|----------|
| Real-time alerts | ✅ | ✅ | ✅ | ✅ | ✅ |
| Session replay | ❌ | ✅ | ✅ | ✅ | ✅ |
| Breadcrumbs | ✅ | ✅ | ✅ | ✅ | ✅ |
| Performance monitoring | ✅ (Firebase) | ✅ | ❌ | ✅ | ❌ |
| Web support | ⚠️ Limited | ✅ | ✅ | ✅ | ❌ |
| Desktop support | ❌ | ✅ | ✅ | ✅ | ❌ |
| Source maps | ⚠️ | ✅ | ✅ | ✅ | ❌ |
| Self-hosting | ❌ | ✅ | ❌ | ❌ | ❌ |

---

## 3. ANR Detection (App Not Responding)

### 3.1 What is ANR?

**ANR (Application Not Responding)** occurs when the UI thread is blocked for too long, causing:
- Frozen UI (no response to taps)
- Janky animations (dropped frames)
- Poor user experience
- On Android, the OS may kill your app

**Flutter's 60fps target:** Each frame should render in **<16ms**. If it takes longer, you drop frames.

---

### 3.2 Detecting UI Freezes with `SchedulerBinding`

**Mechanism:** Monitor frame rendering times to detect when frames are dropped.

**Implementation:**

```dart
import 'package:flutter/scheduler.dart';

class FrameMonitor {
  static const int _targetFrameDuration = 16; // 16ms = 60fps
  static const int _freezeThreshold = 100; // 100ms = noticeable freeze
  
  static void start() {
    SchedulerBinding.instance.addTimingsCallback((List<FrameTiming> timings) {
      for (final timing in timings) {
        final frameDuration = timing.totalSpan.inMilliseconds;
        
        if (frameDuration > _freezeThreshold) {
          _reportFreeze(frameDuration);
        }
      }
    });
  }
  
  static void _reportFreeze(int durationMs) {
    print('⚠️ UI FREEZE DETECTED: ${durationMs}ms');
    // Send to analytics/crash reporting
    // Example: Sentry.captureMessage('UI freeze: ${durationMs}ms');
  }
}

// In main.dart:
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FrameMonitor.start();
  runApp(MyApp());
}
```

---

### 3.3 Watchdog Timer Pattern

**Purpose:** Detect if the UI thread is blocked for an extended period.

**Implementation:**

```dart
import 'dart:async';

class WatchdogTimer {
  Timer? _timer;
  static const Duration _checkInterval = Duration(seconds: 2);
  static const Duration _threshold = Duration(seconds: 5);
  
  DateTime _lastCheck = DateTime.now();
  
  void start() {
    _timer = Timer.periodic(_checkInterval, (timer) {
      final now = DateTime.now();
      final elapsed = now.difference(_lastCheck);
      
      if (elapsed > _threshold) {
        _reportANR(elapsed);
      }
      
      _lastCheck = now;
    });
  }
  
  void stop() {
    _timer?.cancel();
  }
  
  void _reportANR(Duration elapsed) {
    print('🚨 ANR DETECTED: UI thread blocked for ${elapsed.inSeconds}s');
    // Send to crash reporting
    // Example: Sentry.captureMessage('ANR: ${elapsed.inSeconds}s');
  }
}

// Usage:
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final watchdog = WatchdogTimer();
  watchdog.start();
  runApp(MyApp());
}
```

---

### 3.4 `WidgetsBindingObserver` for Lifecycle Monitoring

**Purpose:** Monitor app lifecycle to detect when app becomes unresponsive during state transitions.

**Implementation:**

```dart
import 'package:flutter/material.dart';

class AppLifecycleObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print('App resumed');
        _checkPerformance();
        break;
      case AppLifecycleState.paused:
        print('App paused');
        break;
      case AppLifecycleState.inactive:
        print('App inactive');
        break;
      case AppLifecycleState.detached:
        print('App detached');
        break;
      case AppLifecycleState.hidden:
        print('App hidden');
        break;
    }
  }
  
  void _checkPerformance() {
    // Check if app is responsive after resume
    final start = DateTime.now();
    Future.delayed(Duration.zero, () {
      final elapsed = DateTime.now().difference(start);
      if (elapsed.inMilliseconds > 100) {
        print('⚠️ Slow resume: ${elapsed.inMilliseconds}ms');
      }
    });
  }
}

// Register in main():
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding.instance.addObserver(AppLifecycleObserver());
  runApp(MyApp());
}
```

---

### 3.5 Detecting Jank with Performance Overlay

**Debug Tool:** Flutter provides a built-in performance overlay.

```dart
MaterialApp(
  debugShowCheckedModeBanner: false,
  showPerformanceOverlay: true, // Shows FPS bars
  home: MyHomePage(),
);
```

**Green bar:** GPU rendering time  
**Red bar:** UI (Dart) rendering time  
**Threshold:** Each bar should stay under the 16ms line (60fps)

---

### 3.6 Production ANR Monitoring Package

**Recommendation:** Use `flutter_native_performance` or `sentry_flutter` with performance monitoring.

```yaml
# pubspec.yaml
dependencies:
  sentry_flutter: ^8.11.0
```

```dart
await SentryFlutter.init(
  (options) {
    options.dsn = 'YOUR_DSN';
    options.tracesSampleRate = 1.0; // Monitor ALL transactions
    options.enableAutoPerformanceTracing = true;
  },
  appRunner: () => runApp(MyApp()),
);
```

Sentry will automatically detect:
- Slow frames
- Frozen frames
- App hangs

---

## 4. Logging Best Practices

### 4.1 Package Comparison: `logger` vs `logging` vs `talker`

| Feature | `logger` | `logging` (Dart core) | `talker` |
|---------|----------|----------------------|----------|
| **Ease of Use** | ★★★★★ Very easy | ★★★ Moderate | ★★★★ Easy |
| **Colored Output** | ✅ Beautiful | ❌ Plain | ✅ Beautiful + Emojis |
| **Log Levels** | 6 levels | Custom levels | 8+ levels |
| **Flutter UI** | ❌ No | ❌ No | ✅ **TalkerScreen** (in-app log viewer) |
| **Crash Reporting Integration** | Manual | Manual | ✅ **Built-in TalkerObserver** |
| **HTTP Logging** | Manual | Manual | ✅ **Built-in (Dio, HTTP, Chopper)** |
| **BLoC/Riverpod Logging** | Manual | Manual | ✅ **Built-in packages** |
| **File Output** | ✅ | ✅ | ✅ |
| **Structured Logging** | ⚠️ Limited | ✅ Good | ✅ Excellent |
| **Remote Logging** | Manual | Manual | ✅ Via TalkerObserver |
| **Best For** | Simple apps, quick setup | Backend/CLI apps | **Flutter production apps** |

---

### 4.2 `logger` Package

**Best for:** Simple, beautiful console logs. Quick setup.

**Installation:**
```yaml
dependencies:
  logger: ^2.5.0
```

**Usage:**
```dart
import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2, // Stack trace depth
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: true,
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
  ),
);

// Log levels
logger.t('Trace log');      // Verbose
logger.d('Debug log');      // Debug
logger.i('Info log');       // Info
logger.w('Warning log');    // Warning
logger.e('Error log', error: error); // Error
logger.f('Fatal log', error: error, stackTrace: stackTrace); // Fatal
```

**Pros:**
- ✅ Beautiful colored output
- ✅ Minimal setup
- ✅ Customizable printers

**Cons:**
- ❌ No UI for Flutter
- ❌ No built-in crash reporting integration
- ❌ Manual setup for remote logging

---

### 4.3 `logging` Package (Dart Core)

**Best for:** Backend apps, CLI tools, hierarchical logging.

**Installation:**
```yaml
dependencies:
  logging: ^1.3.0
```

**Usage:**
```dart
import 'package:logging/logging.dart';

void setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
}

final log = Logger('MyApp');

log.finest('Trace');
log.finer('Verbose');
log.fine('Debug');
log.info('Info');
log.warning('Warning');
log.severe('Error');
log.shout('Fatal');
```

**Pros:**
- ✅ Standard Dart package
- ✅ Hierarchical loggers
- ✅ Good for structured logging

**Cons:**
- ❌ No colored output
- ❌ More boilerplate
- ❌ Not Flutter-optimized

---

### 4.4 `talker` Package (RECOMMENDED for Flutter)

**Best for:** Flutter production apps needing comprehensive logging + error handling.

**Why it's the best:**
- ✅ **TalkerScreen:** In-app log viewer (see logs on device without console)
- ✅ **TalkerObserver:** Automatic integration with crash reporting (Sentry, Crashlytics)
- ✅ **Built-in HTTP logging:** Dio, HTTP, Chopper
- ✅ **State management logging:** BLoC, Riverpod
- ✅ Beautiful colored logs with emojis
- ✅ Log filtering, sharing, saving
- ✅ Error alerts on UI

**Installation:**
```yaml
dependencies:
  talker_flutter: ^5.1.13
  talker_dio_logger: ^5.1.13  # If using Dio
  talker_bloc_logger: ^5.1.13 # If using BLoC
```

**Basic Setup:**
```dart
import 'package:talker_flutter/talker_flutter.dart';

final talker = TalkerFlutter.init();

// Simple logging
talker.debug('Debug message');
talker.info('Info message');
talker.warning('Warning message');
talker.error('Error message');
talker.critical('Critical message');
talker.good('Success message 🎉');

// Handle exceptions
try {
  throw Exception('Something went wrong');
} catch (e, st) {
  talker.handle(e, st, 'Failed to load data');
}

// Navigate to logs screen (show to user on device)
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => TalkerScreen(talker: talker),
  ),
);
```

**Advanced Setup with Crash Reporting:**
```dart
import 'package:talker_flutter/talker_flutter.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CrashlyticsTalkerObserver extends TalkerObserver {
  @override
  void onError(TalkerError err) {
    FirebaseCrashlytics.instance.recordError(
      err.error,
      err.stackTrace,
      reason: err.message,
    );
    super.onError(err);
  }

  @override
  void onException(TalkerException exception) {
    FirebaseCrashlytics.instance.recordError(
      exception.exception,
      exception.stackTrace,
      reason: exception.message,
    );
    super.onException(exception);
  }
}

void main() {
  final talker = TalkerFlutter.init(
    settings: TalkerSettings(
      useHistory: true,
      maxHistoryItems: 1000,
      useConsoleLogs: true,
    ),
    observer: CrashlyticsTalkerObserver(),
  );
  
  runApp(MyApp(talker: talker));
}
```

**HTTP Logging with Dio:**
```dart
import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

final dio = Dio();
dio.interceptors.add(
  TalkerDioLogger(
    talker: talker,
    settings: const TalkerDioLoggerSettings(
      printRequestHeaders: true,
      printResponseHeaders: true,
      printResponseMessage: true,
    ),
  ),
);
```

**BLoC Logging:**
```dart
import 'package:talker_bloc_logger/talker_bloc_logger.dart';

Bloc.observer = TalkerBlocObserver(
  talker: talker,
  settings: TalkerBlocLoggerSettings(
    printEvents: true,
    printTransitions: true,
    printChanges: true,
  ),
);
```

---

### 4.5 Log Levels (Standard Hierarchy)

| Level | Purpose | Example |
|-------|---------|---------|
| **TRACE** / **VERBOSE** | Extremely detailed debugging | "Entered function X with params Y" |
| **DEBUG** | Development debugging | "Database query: SELECT * FROM users" |
| **INFO** | General information | "App started", "User logged in" |
| **WARNING** | Potential issues | "API response slow (3s)", "Cache miss" |
| **ERROR** | Recoverable errors | "Failed to load image", "Network timeout" |
| **FATAL** / **CRITICAL** | Unrecoverable errors | "Database connection failed", "Out of memory" |

**Recommendation:** Use **DEBUG** and **VERBOSE** only in debug builds. Use **INFO+** in production.

---

### 4.6 Structured Logging

**Bad (unstructured):**
```dart
logger.info('User John logged in from 192.168.1.1');
```

**Good (structured):**
```dart
logger.info('User logged in', {
  'userId': 'user_123',
  'username': 'John',
  'ip': '192.168.1.1',
  'timestamp': DateTime.now().toIso8601String(),
});
```

With structured logs, you can:
- Query logs by specific fields
- Aggregate data (e.g., "how many logins per hour?")
- Build dashboards

---

### 4.7 Remote Logging

**Purpose:** Send logs to a server for analysis (e.g., Grafana, Datadog, custom backend).

**Implementation with Talker:**
```dart
class RemoteLoggingObserver extends TalkerObserver {
  final HttpClient client;
  
  RemoteLoggingObserver(this.client);
  
  @override
  void onLog(TalkerDataInterface log) {
    // Send log to server
    client.post('/api/logs', body: {
      'level': log.title,
      'message': log.message,
      'timestamp': log.time.toIso8601String(),
    });
    super.onLog(log);
  }
}
```

---

## 5. Production Error Handling Patterns

### 5.1 Global Error Boundary Widgets

**Concept:** Like React's Error Boundaries, catch errors in widget subtrees and show fallback UI.

**Implementation:**

```dart
class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final Widget Function(Object error, StackTrace? stackTrace)? errorBuilder;
  
  const ErrorBoundary({
    Key? key,
    required this.child,
    this.errorBuilder,
  }) : super(key: key);

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  Object? _error;
  StackTrace? _stackTrace;

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return widget.errorBuilder?.call(_error!, _stackTrace) ??
          ErrorWidget(_error!);
    }
    
    return ErrorBoundaryWrapper(
      onError: (error, stackTrace) {
        setState(() {
          _error = error;
          _stackTrace = stackTrace;
        });
      },
      child: widget.child,
    );
  }
}

class ErrorBoundaryWrapper extends StatelessWidget {
  final Widget child;
  final Function(Object error, StackTrace? stackTrace) onError;

  const ErrorBoundaryWrapper({
    Key? key,
    required this.child,
    required this.onError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

// Usage:
ErrorBoundary(
  errorBuilder: (error, stackTrace) => Center(
    child: Text('Failed to load this section'),
  ),
  child: ComplexWidget(),
)
```

**Alternative:** Use the `boundary` package by Remi Rousselet:
```yaml
dependencies:
  boundary: ^1.0.0
```

---

### 5.2 Graceful Degradation

**Principle:** When a feature fails, don't crash the whole app. Show a fallback.

**Example:**

```dart
class UserProfile extends StatelessWidget {
  final String userId;
  
  const UserProfile({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: fetchUser(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        
        if (snapshot.hasError) {
          // Graceful degradation: Show fallback UI instead of crashing
          return Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Icon(Icons.person_outline, size: 48, color: Colors.grey),
                  SizedBox(height: 8),
                  Text('Unable to load profile'),
                  TextButton(
                    onPressed: () {
                      // Retry logic
                      setState(() {});
                    },
                    child: Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }
        
        final user = snapshot.data!;
        return UserProfileCard(user: user);
      },
    );
  }
}
```

---

### 5.3 Custom Error Screens vs Red Screen of Death

**Debug Mode:** Keep red screen of death (helpful for development).  
**Release Mode:** Show user-friendly error screen.

**Implementation:**

```dart
void main() {
  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();
    
    // Custom error widget for release mode
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return kReleaseMode
          ? Material(
              child: Container(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: Colors.red),
                    SizedBox(height: 16),
                    Text(
                      'Oops! Something went wrong',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'We\'re working to fix this issue.',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        // Restart app or navigate home
                      },
                      child: Text('Go to Home'),
                    ),
                  ],
                ),
              ),
            )
          : ErrorWidget(details.exception); // Keep red screen in debug
    };
    
    runApp(MyApp());
  }, (error, stack) {
    // Handle uncaught errors
  });
}
```

---

### 5.4 Network Error Handling

**Best Practice:** Wrap all HTTP calls with retry logic and timeout.

```dart
class ApiClient {
  final Dio dio;
  
  ApiClient(this.dio) {
    dio.options.connectTimeout = Duration(seconds: 10);
    dio.options.receiveTimeout = Duration(seconds: 10);
  }
  
  Future<T> get<T>(
    String path, {
    int maxRetries = 3,
    Duration retryDelay = const Duration(seconds: 2),
  }) async {
    int retries = 0;
    
    while (retries < maxRetries) {
      try {
        final response = await dio.get(path);
        return response.data as T;
      } on DioException catch (e) {
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          retries++;
          if (retries >= maxRetries) {
            throw NetworkException('Request timed out after $maxRetries attempts');
          }
          await Future.delayed(retryDelay);
        } else if (e.response?.statusCode == 404) {
          throw NotFoundException('Resource not found');
        } else if (e.response?.statusCode == 401) {
          throw UnauthorizedException('Unauthorized');
        } else {
          throw NetworkException('Network error: ${e.message}');
        }
      }
    }
    
    throw NetworkException('Max retries exceeded');
  }
}

// Custom exceptions
class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}

class NotFoundException implements Exception {
  final String message;
  NotFoundException(this.message);
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException(this.message);
}
```

---

### 5.5 State Management Error Handling

#### **BLoC Pattern:**

```dart
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;
  
  UserBloc(this.repository) : super(UserInitial()) {
    on<LoadUser>((event, emit) async {
      emit(UserLoading());
      
      try {
        final user = await repository.getUser(event.userId);
        emit(UserLoaded(user));
      } on NotFoundException {
        emit(UserError('User not found'));
      } on NetworkException catch (e) {
        emit(UserError('Network error: ${e.message}'));
      } catch (e) {
        emit(UserError('Unknown error occurred'));
        // Re-throw to global handler
        rethrow;
      }
    });
  }
}

// States
abstract class UserState {}
class UserInitial extends UserState {}
class UserLoading extends UserState {}
class UserLoaded extends UserState {
  final User user;
  UserLoaded(this.user);
}
class UserError extends UserState {
  final String message;
  UserError(this.message);
}
```

#### **Riverpod Pattern:**

```dart
final userProvider = FutureProvider.autoDispose.family<User, String>((ref, userId) async {
  try {
    return await ref.read(userRepositoryProvider).getUser(userId);
  } on NotFoundException {
    throw Exception('User not found');
  } on NetworkException catch (e) {
    throw Exception('Network error: ${e.message}');
  }
});

// In UI:
class UserProfile extends ConsumerWidget {
  final String userId;
  
  const UserProfile(this.userId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider(userId));
    
    return userAsync.when(
      data: (user) => UserCard(user: user),
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => ErrorCard(message: error.toString()),
    );
  }
}
```

---

### 5.6 Memory Leak Detection

**Tools:**
1. **DevTools Memory Profiler** (Flutter's built-in tool)
2. **flutter_memory_leak_tracker** package

**Best Practices:**
- ✅ Always dispose controllers (TextEditingController, AnimationController)
- ✅ Cancel StreamSubscription and Timer
- ✅ Remove listeners in `dispose()`

```dart
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late TextEditingController _controller;
  StreamSubscription? _subscription;
  Timer? _timer;
  
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _subscription = someStream.listen((data) {
      // Handle data
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Do something
    });
  }
  
  @override
  void dispose() {
    _controller.dispose();
    _subscription?.cancel();
    _timer?.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return TextField(controller: _controller);
  }
}
```

---

## 6. Recommended Stack

### 🏆 The Ultimate Flutter Error Handling Stack

Based on all research, here's the **recommended setup** for catching ALL errors in production Flutter apps:

#### **Core Components:**

1. **Error Handling:** `runZonedGuarded` + `FlutterError.onError` + `PlatformDispatcher.onError`
2. **Crash Reporting:** **Sentry** (cross-platform) or **Firebase Crashlytics** (mobile-only, free)
3. **Logging:** **Talker** (best for Flutter with in-app log viewer)
4. **Monitoring:** **Sentry Performance Monitoring** or **Firebase Performance**

---

### 📦 Recommended Packages

```yaml
dependencies:
  # Logging
  talker_flutter: ^5.1.13
  
  # HTTP logging (if using Dio)
  talker_dio_logger: ^5.1.13
  
  # State management logging (if using BLoC)
  talker_bloc_logger: ^5.1.13
  
  # Crash reporting (choose ONE)
  sentry_flutter: ^8.11.0          # Recommended for cross-platform
  # OR
  firebase_crashlytics: ^4.2.0     # If mobile-only and already using Firebase
  firebase_core: ^3.8.1
```

---

### 🎯 Complete Production Setup

**`pubspec.yaml`:**
```yaml
name: my_flutter_app
description: Production-ready Flutter app with complete error handling

dependencies:
  flutter:
    sdk: flutter
  
  # Error handling & logging
  talker_flutter: ^5.1.13
  sentry_flutter: ^8.11.0
  
  # HTTP client
  dio: ^5.7.0
  talker_dio_logger: ^5.1.13
  
  # State management (example: BLoC)
  flutter_bloc: ^8.1.6
  talker_bloc_logger: ^5.1.13
```

**`main.dart` (Complete Production Setup):**

```dart
import 'dart:async';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Global talker instance
late Talker talker;

Future<void> main() async {
  // 1. Initialize Flutter binding
  WidgetsFlutterBinding.ensureInitialized();
  
  // 2. Initialize Talker with Sentry integration
  talker = TalkerFlutter.init(
    settings: TalkerSettings(
      enabled: true,
      useHistory: true,
      maxHistoryItems: 1000,
      useConsoleLogs: !kReleaseMode, // Only log to console in debug
    ),
    observer: SentryTalkerObserver(), // Custom observer (see below)
  );
  
  // 3. Setup BLoC logging
  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: TalkerBlocLoggerSettings(
      printEvents: true,
      printTransitions: true,
      printChanges: true,
    ),
  );
  
  // 4. Initialize Sentry with Talker integration
  await SentryFlutter.init(
    (options) {
      options.dsn = 'YOUR_SENTRY_DSN'; // Replace with your DSN
      options.tracesSampleRate = 1.0; // Performance monitoring
      options.enableAutoSessionTracking = true;
      options.attachScreenshot = true;
      options.environment = kReleaseMode ? 'production' : 'development';
      
      // Add breadcrumbs from Talker logs
      options.beforeSend = (event, {hint}) {
        // Add Talker history to Sentry event
        event = event.copyWith(
          contexts: event.contexts.copyWith(
            'talker_logs': talker.history.map((log) => log.toString()).toList(),
          ),
        );
        return event;
      };
    },
    appRunner: () => _runApp(),
  );
}

void _runApp() {
  // 5. Setup isolate error handling
  Isolate.current.addErrorListener(
    RawReceivePort((dynamic pair) {
      final error = pair.first;
      final stackTrace = StackTrace.fromString(pair.last.toString());
      talker.error('Isolate error', error, stackTrace);
      Sentry.captureException(error, stackTrace: stackTrace);
    }).sendPort,
  );
  
  // 6. Run app inside runZonedGuarded
  runZonedGuarded<Future<void>>(
    () async {
      // 7. Setup Flutter framework error handler
      FlutterError.onError = (FlutterErrorDetails details) {
        talker.error(
          'Flutter error',
          details.exception,
          details.stack,
        );
        
        // Send to Sentry
        Sentry.captureException(
          details.exception,
          stackTrace: details.stack,
        );
        
        // Show in console during development
        if (!kReleaseMode) {
          FlutterError.dumpErrorToConsole(details);
        }
      };
      
      // 8. Setup platform dispatcher error handler
      PlatformDispatcher.instance.onError = (error, stack) {
        talker.error('Platform error', error, stack);
        Sentry.captureException(error, stackTrace: stack);
        return true;
      };
      
      // 9. Custom error widget for release mode
      ErrorWidget.builder = (FlutterErrorDetails details) {
        return kReleaseMode
            ? const ErrorScreen()
            : ErrorWidget(details.exception);
      };
      
      // 10. Run the app
      runApp(MyApp(talker: talker));
    },
    (error, stackTrace) {
      // Ultimate catch-all
      talker.error('Uncaught zone error', error, stackTrace);
      Sentry.captureException(error, stackTrace: stackTrace);
    },
  );
}

// Custom Talker observer for Sentry integration
class SentryTalkerObserver extends TalkerObserver {
  @override
  void onError(TalkerError err) {
    Sentry.captureException(
      err.error,
      stackTrace: err.stackTrace,
    );
    super.onError(err);
  }

  @override
  void onException(TalkerException exception) {
    Sentry.captureException(
      exception.exception,
      stackTrace: exception.stackTrace,
    );
    super.onException(exception);
  }
  
  @override
  void onLog(TalkerDataInterface log) {
    // Add breadcrumbs for important logs
    if (log.logLevel.priority >= LogLevel.warning.priority) {
      Sentry.addBreadcrumb(Breadcrumb(
        message: log.message,
        level: _mapLogLevel(log.logLevel),
        timestamp: log.time,
      ));
    }
    super.onLog(log);
  }
  
  SentryLevel _mapLogLevel(LogLevel level) {
    switch (level) {
      case LogLevel.error:
      case LogLevel.critical:
        return SentryLevel.error;
      case LogLevel.warning:
        return SentryLevel.warning;
      case LogLevel.info:
        return SentryLevel.info;
      default:
        return SentryLevel.debug;
    }
  }
}

// Custom error screen for release mode
class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              'Oops! Something went wrong',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'We\'re sorry for the inconvenience. Our team has been notified.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Restart app or navigate home
              },
              child: const Text('Restart App'),
            ),
          ],
        ),
      ),
    );
  }
}

// Main app
class MyApp extends StatelessWidget {
  final Talker talker;
  
  const MyApp({Key? key, required this.talker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Production App',
      debugShowCheckedModeBanner: false,
      
      // Navigation observers
      navigatorObservers: [
        TalkerRouteObserver(talker), // Log navigation
        SentryNavigatorObserver(),   // Sentry navigation tracking
      ],
      
      home: const HomeScreen(),
      
      // Global error handling for navigation
      builder: (context, widget) {
        ErrorWidget.builder = (errorDetails) {
          return kReleaseMode
              ? const ErrorScreen()
              : ErrorWidget(errorDetails.exception);
        };
        return widget ?? const SizedBox.shrink();
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Production Error Handling'),
        actions: [
          // Button to view logs (dev/debug only)
          if (!kReleaseMode)
            IconButton(
              icon: const Icon(Icons.bug_report),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TalkerScreen(talker: talker),
                  ),
                );
              },
            ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('App is running with complete error handling!'),
            const SizedBox(height: 24),
            
            // Test buttons (remove in production)
            ElevatedButton(
              onPressed: () {
                talker.info('Test info log');
              },
              child: const Text('Test Info Log'),
            ),
            ElevatedButton(
              onPressed: () {
                talker.error('Test error', Exception('Test exception'));
              },
              child: const Text('Test Error'),
            ),
            ElevatedButton(
              onPressed: () {
                throw Exception('Test uncaught exception');
              },
              child: const Text('Test Uncaught Exception'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

### 🔧 HTTP Client Setup with Error Handling

**`api_client.dart`:**

```dart
import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class ApiClient {
  late final Dio dio;
  
  ApiClient(Talker talker) {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.example.com',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
    
    // Add Talker logging interceptor
    dio.interceptors.add(
      TalkerDioLogger(
        talker: talker,
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
          printResponseMessage: true,
        ),
      ),
    );
    
    // Add error handling interceptor
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, handler) {
          // Custom error handling
          if (e.type == DioExceptionType.connectionTimeout) {
            talker.warning('Connection timeout');
          } else if (e.type == DioExceptionType.receiveTimeout) {
            talker.warning('Receive timeout');
          } else if (e.response?.statusCode == 401) {
            talker.error('Unauthorized - token expired?');
          }
          
          handler.next(e);
        },
      ),
    );
  }
}
```

---

### 📊 Summary: Why This Stack?

| Component | Choice | Reason |
|-----------|--------|--------|
| **Error Catching** | `runZonedGuarded` + `FlutterError.onError` + `PlatformDispatcher.onError` | Catches ALL errors (framework, platform, async) |
| **Crash Reporting** | **Sentry** | Cross-platform, free tier, session replay, performance monitoring |
| **Logging** | **Talker** | In-app log viewer, automatic crash reporting integration, HTTP/BLoC logging |
| **Monitoring** | **Sentry Performance** | Detect ANR, slow frames, network issues |

**Alternative (Mobile-only, free):**
- Replace Sentry with **Firebase Crashlytics** if you only target iOS/Android and want 100% free solution.

---

### 🚀 Next Steps: Building the OpenClaw Skill

To turn this into a Claude Code / OpenClaw skill:

1. **Create a CLI command:** `openclaw flutter-error-setup`
2. **Automate package installation:** Add dependencies to `pubspec.yaml`
3. **Generate `main.dart`:** Replace user's main.dart with the production template
4. **Configure Sentry DSN:** Prompt user for DSN or auto-detect from `.env`
5. **Add error testing commands:** `flutter-error-test` to trigger test errors
6. **Generate documentation:** Create `ERROR_HANDLING.md` in user's project

**Skill structure:**
```
skills/flutter-error-handling/
├── SKILL.md
├── install.sh
├── templates/
│   ├── main.dart
│   ├── error_screen.dart
│   └── sentry_observer.dart
└── README.md
```

---

## Conclusion

This guide provides **everything** needed to catch ALL errors in Flutter apps:

✅ **4-layer error handling** (FlutterError, PlatformDispatcher, runZonedGuarded, Isolate)  
✅ **Crash reporting** comparison (Sentry recommended)  
✅ **ANR detection** (SchedulerBinding, watchdog timers)  
✅ **Logging** (Talker recommended for Flutter)  
✅ **Production patterns** (error boundaries, graceful degradation, custom error screens)  
✅ **Complete production setup** (ready-to-use `main.dart`)

**Next:** Use this as a reference to build the OpenClaw skill for one-command Flutter error handling setup! 🚀
