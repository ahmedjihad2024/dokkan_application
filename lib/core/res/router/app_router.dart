import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/dependency_injection.dart';
import '../../../features/add_product/presentation/add_product_screen.dart';
import '../../../features/add_product/presentation/cubit/add_product_cubit.dart';
import '../../../features/authentication/presentation/cubit/auth_cubit.dart';
import '../../../features/authentication/presentation/screens/create_new_password_screen.dart';
import '../../../features/authentication/presentation/screens/enter_recovery_code_screen.dart';
import '../../../features/authentication/presentation/screens/forget_password_screen.dart';
import '../../../features/authentication/presentation/screens/login_screen.dart';
import '../../../features/authentication/presentation/screens/signup_screen.dart';
import '../../../features/authentication/presentation/screens/verify_email_address_screen.dart';

import '../../../features/checkout/domain/model/address_entity.dart';
import '../../../features/checkout/presentation/checkout_screen.dart';
import '../../../features/checkout/presentation/cubit/checkout_cubit.dart';
import '../../../features/edit_address/presentation/screens/edit_address_screen.dart';
import '../../../features/edit_address/presentation/cubit/edit_address_cubit.dart';
import '../../../features/checkout/presentation/screens/payment_redirect_screen.dart';
import '../../../features/contact_us/presentation/contact_us_screen.dart';
import '../../shared/domain/model/product_entity.dart';
import '../../../features/main_layout/presentation/main_layout_screen.dart';
import '../../../features/manage_products/presentation/cubit/manage_products_cubit.dart';
import '../../../features/manage_products/presentation/manage_products_screen.dart';
import '../../../features/onboarding/presentation/onboarding_screen.dart';
import '../../../features/order_status/presentation/payment_failed_screen.dart';
import '../../../features/order_status/presentation/payment_success_screen.dart';
import '../../../features/product_details/presentation/cubit/product_details_cubit.dart';
import '../../../features/product_details/presentation/product_details_screen.dart';
import '../../../features/search/presentation/cubit/search_cubit.dart';
import '../../../features/search/presentation/search_screen.dart';
import '../../../features/favorites/presentation/favorites_screen.dart';
import '../../../features/about_and_privacy/presentation/screens/about_us_screen.dart';
import '../../../features/change_password/presentation/screens/change_password_screen.dart';
import '../../../features/about_and_privacy/presentation/screens/privacy_policy_screen.dart';
import '../../../features/profile/presentation/screens/profile_screen.dart';
import '../../../features/reviews/presentation/cubit/reviews_cubit.dart';
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
        return MaterialPageRoute(builder: (_) => const MainLayoutScreen());

      case Routes.productDetails:
        final productId = settings.arguments as String? ??
            (settings.arguments is ProductEntity
                ? (settings.arguments as ProductEntity).id
                : '');
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) =>
                sl<ProductDetailsCubit>()..getProductDetails(productId),
            child: ProductDetailsScreen(
              productId: productId,
            ),
          ),
        );

      case Routes.productReviews:
        final args = settings.arguments as Map<String, dynamic>?;
        final productId = args?['productId'] as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<ReviewsCubit>()..getReviews(productId),
            child: ReviewsScreen(
              productId: productId,
              productName:
                  args?['productName'] as String? ?? 'Product Reviews',
              averageRating: (args?['rating'] as num?)?.toDouble() ?? 5.0,
              totalReviews: (args?['reviewsCount'] as num?)?.toInt() ?? 0,
            ),
          ),
        );

      // ─── Authentication Flow ───────────────────────────────────
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<AuthCubit>(),
            child: const LoginScreen(),
          ),
        );

      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<AuthCubit>(),
            child: const SignupScreen(),
          ),
        );

      case Routes.forgotPassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<AuthCubit>(),
            child: const ForgotPasswordScreen(),
          ),
        );

      case Routes.verifyEmailAddress:
      case Routes.otpVerification:
        final email = _extractEmail(settings.arguments);
        final isPasswordRecovery = _extractBool(
          settings.arguments,
          key: 'isPasswordRecovery',
        );

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<AuthCubit>(),
            child: VerifyEmailAddressScreen(
              email: email,
              isPasswordRecovery: isPasswordRecovery,
            ),
          ),
        );

      case Routes.recoveryCode:
        final email = _extractEmail(settings.arguments);
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<AuthCubit>(),
            child: EnterRecoveryCodeScreen(email: email),
          ),
        );

      case Routes.createNewPassword:
      case Routes.resetPassword:
        final args = settings.arguments;
        final email = _extractEmail(args);
        final otp = args is Map<String, dynamic>
            ? args['otp'] as String? ?? ''
            : '';
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<AuthCubit>(),
            child: CreateNewPasswordScreen(
              email: email.isEmpty ? null : email,
              otp: otp,
            ),
          ),
        );

      case Routes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case Routes.aboutUs:
        return MaterialPageRoute(builder: (_) => const AboutUsScreen());

      case Routes.privacyPolicy:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen());

      case Routes.changePassword:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());

      case Routes.manageProducts:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<ManageProductsCubit>()..fetchProducts(),
            child: const ManageProductsScreen(),
          ),
        );

      case Routes.addProduct:
        final product = settings.arguments as ProductEntity?;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<AddProductCubit>()..init(product),
            child: AddProductScreen(product: product),
          ),
        );

      // ─── Search & Discover ─────────────────────────────────────
      case Routes.search:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<SearchCubit>()..fetchProducts(),
            child: const SearchScreen(),
          ),
        );

      // ─── Favorites / Wishlist ──────────────────────────────────
      case Routes.favorites:
        return MaterialPageRoute(
          builder: (_) => const FavoritesScreen(),
        );

      // ─── Unified Checkout Flow (Carousel: Address -> Payment -> Review)
      case Routes.checkout:
      case Routes.checkoutSelectAddress:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<CheckoutCubit>()
              ..getAddresses()
              ..getCart(),
            child: const CheckoutScreen(initialStep: 0),
          ),
        );

      case Routes.checkoutPaymentMethod:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<CheckoutCubit>()
              ..getAddresses()
              ..getCart(),
            child: const CheckoutScreen(initialStep: 1),
          ),
        );

      case Routes.checkoutOrderSummary:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<CheckoutCubit>()
              ..getAddresses()
              ..getCart(),
            child: const CheckoutScreen(initialStep: 2),
          ),
        );

      case Routes.checkoutAddEditAddress:
        final initialAddress = settings.arguments as AddressModel?;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<EditAddressCubit>(),
            child: EditAddressScreen(initialAddress: initialAddress),
          ),
        );

      case Routes.checkoutPaymentRedirect:
        final orderData = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => PaymentRedirectScreen(orderData: orderData),
        );

      case Routes.checkoutPaymentSuccess:
        final orderData = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => PaymentSuccessScreen(orderData: orderData),
        );

      case Routes.checkoutPaymentFailed:
        final reason = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => PaymentFailedScreen(failureReason: reason),
        );

      // ─── Contact Us ────────────────────────────────────────────
      case Routes.contactUs:
        return MaterialPageRoute(builder: (_) => const ContactUsScreen());

      default:
        return _unDefinedRoute(settings.name);
    }
  }

  static String _extractEmail(Object? args) {
    if (args is String) return args;
    if (args is Map<String, dynamic>) {
      final value = args['email'];
      if (value is String) return value;
    }
    return '';
  }

  static bool _extractBool(Object? args, {required String key}) {
    if (args is Map<String, dynamic>) {
      final value = args[key];
      if (value is bool) return value;
    }
    return false;
  }

  static Route<dynamic> _unDefinedRoute(String? routeName) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Not Found')),
        body: Center(
          child: Text(
            'Route not defined${routeName != null ? ': $routeName' : ''}',
          ),
        ),
      ),
    );
  }
}
