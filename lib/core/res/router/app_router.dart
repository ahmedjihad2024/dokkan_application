import 'package:flutter/material.dart';

import '../../../features/authentication/presentation/create_new_password_screen.dart';
import '../../../features/authentication/presentation/enter_recovery_code_screen.dart';
import '../../../features/authentication/presentation/verify_email_address_screen.dart';
import '../../../features/authentication/presentation/forget_password_screen.dart';

import '../../../features/home/data/models/product_model.dart';
import '../../../features/home/presentation/home_screen.dart';
import '../../../features/onboarding/presentation/onboarding_screen.dart';
import '../../../features/product_details/presentation/product_details_screen.dart';
import '../../../features/reviews/presentation/reviews_screen.dart';
import '../../../features/splash/presentation/splash_screen.dart';

// 🟢 NEW: استيراد شاشة تسجيل الدخول
import '../../../features/authentication/presentation/login_screen.dart';

// 🟢 NEW: استيراد شاشة إنشاء الحساب
import '../../../features/authentication/presentation/signup_screen.dart';
import '../../../features/manage_products/presentation/manage_products_screen.dart';

import '../../../features/add_product/presentation/add_product_screen.dart';

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
      // 🟢 NEW: فتح شاشة تسجيل الدخول
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      //Register the Forgot Password screen
      case Routes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());

      // 🟢 NEW: فتح شاشة إنشاء الحساب
      case Routes.register:
        return MaterialPageRoute(builder: (_) => const SignupScreen());

      case Routes.manageProducts:
        return MaterialPageRoute(builder: (_) => const ManageProductsScreen());

      case Routes.addProduct:
        return MaterialPageRoute(builder: (_) => const AddProductScreen());

      case Routes.verifyEmailAddress:
        final email = settings.arguments as String? ?? '';

        return MaterialPageRoute(
          builder: (_) => VerifyEmailAddressScreen(email: email),
        );

      case Routes.recoveryCode:
        return MaterialPageRoute(
          builder: (_) => const EnterRecoveryCodeScreen(),
        );

      case Routes.createNewPassword:
        return MaterialPageRoute(
          builder: (_) => const CreateNewPasswordScreen(),
        );

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
