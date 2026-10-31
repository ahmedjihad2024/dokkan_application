import 'package:dokkan/features/categories/presentation/categories_screen.dart';
import 'package:flutter/material.dart';

import '../../../features/onboarding/presentation/onboarding_screen.dart';
import '../../../features/splash/presentation/splash_screen.dart';
import 'routes.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case Routes.categories:
        return MaterialPageRoute(builder: (_) => const CategoriesScreen());

      default:
        return _unDefinedRoute(settings.name);
    }
  }

  static Route<dynamic> _unDefinedRoute(String? routeName) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Route Not Found')),
        body: Center(
          child: Text(
            'No route defined for $routeName',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
