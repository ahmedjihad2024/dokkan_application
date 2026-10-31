import 'package:flutter/material.dart';

import '../../../features/add_product/presentation/add_product_screen.dart';
import '../../../features/authentication/presentation/create_new_password_screen.dart';
import '../../../features/authentication/presentation/enter_recovery_code_screen.dart';
import '../../../features/authentication/presentation/forget_password_screen.dart';
import '../../../features/authentication/presentation/login_screen.dart';
import '../../../features/authentication/presentation/signup_screen.dart';
import '../../../features/authentication/presentation/verify_email_address_screen.dart';
import '../../../features/home/data/models/product_model.dart';
import '../../../features/home/presentation/home_screen.dart';
import '../../../features/manage_products/presentation/manage_products_screen.dart';
import '../../../features/onboarding/presentation/onboarding_screen.dart';
import '../../../features/product_details/presentation/product_details_screen.dart';
import '../../../features/reviews/presentation/reviews_screen.dart';
import '../../../features/splash/presentation/splash_screen.dart';
import 'routes.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case Routes.productDetails:
        final product = settings.arguments as ProductModel?;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(product: product),
        );

      case Routes.productReviews:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => ReviewsScreen(
            productName:
                args?['productName'] as String? ??
                'Heritage Chronograph Steel Watch',
            averageRating: (args?['rating'] as num?)?.toDouble() ?? 4.9,
            totalReviews: args?['reviewsCount'] as int? ?? 128,
          ),
        );

      // ─── Authentication Flow ───────────────────────────────────
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case Routes.register:
        return MaterialPageRoute(builder: (_) => const SignupScreen());

      case Routes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());

      case Routes.verifyEmailAddress:
      case Routes.otpVerification:
        final email = _extractEmail(settings.arguments);
        final isPasswordRecovery = _extractBool(
          settings.arguments,
          key: 'isPasswordRecovery',
        );
        return MaterialPageRoute(
          builder: (_) => VerifyEmailAddressScreen(
            email: email,
            isPasswordRecovery: isPasswordRecovery,
          ),
        );

      case Routes.recoveryCode:
        final email = _extractEmail(settings.arguments);
        return MaterialPageRoute(
          builder: (_) => EnterRecoveryCodeScreen(email: email),
        );

      case Routes.createNewPassword:
      case Routes.resetPassword:
        final email = _extractEmail(settings.arguments);
        return MaterialPageRoute(
          builder: (_) => CreateNewPasswordScreen(
            email: email.isEmpty ? null : email,
          ),
        );

      case Routes.manageProducts:
        return MaterialPageRoute(builder: (_) => const ManageProductsScreen());

      case Routes.addProduct:
        return MaterialPageRoute(builder: (_) => const AddProductScreen());

      default:
        return _unDefinedRoute(settings.name);
    }
  }

  static String _extractEmail(Object? args) {
    if (args is String) return args;
    if (args is Map<String, dynamic>) {
      return args['email'] as String? ?? '';
    }
    return '';
  }

  static bool _extractBool(Object? args, {required String key}) {
    if (args is Map<String, dynamic>) {
      return args[key] as bool? ?? false;
    }
    return false;
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
