import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lingolab_app/core/router/app_router.dart';

class NavigationHelper {
  /// Navigate to splash screen
  static void toSplash(BuildContext context) {
    context.go(AppRouter.splash);
  }

  /// Navigate to onboarding screen
  static void toOnboarding(BuildContext context) {
    context.go(AppRouter.onboarding);
  }

  /// Navigate to login screen
  static void toLogin(BuildContext context) {
    context.go(AppRouter.login);
  }

  /// Navigate to register screen
  static void toRegister(BuildContext context) {
    context.go(AppRouter.register);
  }

  /// Navigate to home screen
  static void toHome(BuildContext context) {
    context.go(AppRouter.home);
  }

  /// Pop current screen
  static void back(BuildContext context) {
    context.pop();
  }

  /// Clear navigation stack and go to login
  static void clearAndGoToLogin(BuildContext context) {
    context.go(AppRouter.login);
  }

  /// Clear navigation stack and go to home
  static void clearAndGoToHome(BuildContext context) {
    context.go(AppRouter.home);
  }
}
