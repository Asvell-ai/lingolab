import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lingolab_app/features/auth/presentation/pages/login_page.dart';
import 'package:lingolab_app/features/auth/presentation/pages/register_page.dart';
import 'package:lingolab_app/features/home/presentation/pages/home_page.dart';
import 'package:lingolab_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:lingolab_app/features/splash/screens/splash_screens.dart';

class AppRouter {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    errorBuilder: (context, state) {
      return Scaffold(
        body: Center(
          child: Text('Page not found: ${state.fullPath}'),
        ),
      );
    },
    routes: [
      GoRoute(
        path: splash,
        name: 'splash',
        builder: (context, state) => const SplashScreens(),
      ),
      GoRoute(
        path: onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: register,
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}

