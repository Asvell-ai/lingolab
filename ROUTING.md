# Go Router Navigation Setup

## Overview

This project uses **Go Router** for all navigation throughout the application. Go Router provides a declarative, type-safe routing solution for Flutter apps.

## Project Structure

```
lib/
├── core/
│   └── router/
│       ├── app_router.dart       # Main router configuration
│       └── navigation_helper.dart # Navigation utility helper
├── features/
│   ├── auth/
│   │   └── presentation/
│   │       └── pages/
│   │           ├── login_page.dart
│   │           └── register_page.dart
│   ├── home/
│   │   └── presentation/
│   │       └── pages/
│   │           └── home_page.dart
│   ├── onboarding/
│   │   └── presentation/
│   │       └── pages/
│   │           └── onboarding_page.dart
│   └── splash/
│       └── screens/
│           └── splash_screens.dart
```

## Route Definitions

All routes are defined in `AppRouter` class in `lib/core/router/app_router.dart`:

| Route | Path | Widget |
|-------|------|--------|
| Splash | `/splash` | SplashScreens |
| Onboarding | `/onboarding` | OnboardingPage |
| Login | `/login` | LoginPage |
| Register | `/register` | RegisterPage |
| Home | `/home` | HomePage |

## Navigation Usage

### Method 1: Using NavigationHelper (Recommended)

```dart
import 'package:lingolab_app/core/router/navigation_helper.dart';

// Navigate to home
NavigationHelper.toHome(context);

// Navigate to login
NavigationHelper.toLogin(context);

// Go back
NavigationHelper.back(context);
```

### Method 2: Using context.go() (Direct GoRouter API)

```dart
import 'package:go_router/go_router.dart';
import 'package:lingolab_app/core/router/app_router.dart';

// Navigate to home
context.go(AppRouter.home);

// Navigate to login
context.go(AppRouter.login);

// Go back
context.pop();
```

## Examples

### Login Page Navigation

```dart
// After successful login
context.go(AppRouter.home);

// Navigation to register
GestureDetector(
  onTap: () => context.go(AppRouter.register),
  child: const Text('Sign Up'),
),
```

### Register Page Navigation

```dart
// After successful registration
context.go(AppRouter.home);

// Navigation back to login
GestureDetector(
  onTap: () => context.go(AppRouter.login),
  child: const Text('Login'),
),
```

### Logout/Return to Login

```dart
// Logout and return to login screen
NavigationHelper.clearAndGoToLogin(context);
```

## Main App Setup

The `main.dart` file uses `MaterialApp.router` with the GoRouter:

```dart
MaterialApp.router(
  title: 'LingoLab',
  theme: ThemeData(...),
  routerConfig: AppRouter.router,
)
```

## Adding New Routes

To add a new route:

1. Add route constant to `AppRouter`:
   ```dart
   static const String courseDetail = '/course/:id';
   ```

2. Add route definition:
   ```dart
   GoRoute(
     path: courseDetail,
     name: 'courseDetail',
     builder: (context, state) {
       final id = state.pathParameters['id']!;
       return CourseDetailPage(id: id);
     },
   ),
   ```

3. Navigate to the route:
   ```dart
   context.go('/course/123');
   // or
   context.goNamed('courseDetail', pathParameters: {'id': '123'});
   ```

## Features

✅ Type-safe routing
✅ Deep linking support
✅ Named routes
✅ Parameter passing
✅ Error handling
✅ Back button handling
✅ Declarative routes

## Best Practices

1. **Use Named Routes**: Always use route names when possible for better maintainability
2. **Centralize Navigation**: Use `NavigationHelper` for consistency
3. **Handle Errors**: GoRouter includes built-in error handling for invalid routes
4. **State Management**: Combine with BLoC/Cubit for state-aware navigation
5. **Deep Linking**: Routes support URL patterns for deep linking

## Troubleshooting

### Route Not Found Error

If you see "Page not found: /path", check:
- Route path is defined in `app_router.dart`
- Correct spelling of route path
- All route paths start with `/`

### Navigation Not Working

- Ensure `MaterialApp.router` is used, not `MaterialApp`
- Import `go_router` package
- Use `context.go()` or NavigationHelper methods
- Check that BuildContext is from a widget below MaterialApp

### State Not Preserved

Use `GoRoute` with proper state management:
- Implement proper BLoC/Cubit initialization
- Use `BlocProvider` at appropriate levels
- State persists across routes by default

## Dependencies

Add to `pubspec.yaml`:

```yaml
dependencies:
  go_router: ^13.0.0
```

## Documentation

- [GoRouter Documentation](https://pub.dev/packages/go_router)
- [Flutter Navigation Guide](https://flutter.dev/docs/development/ui/navigation)
