import 'dart:async';
import 'package:dokkan/core/di/dependency_injection.dart';
import 'package:dokkan/core/services/storage_services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/config/constants.dart';
import '../../../core/extensions/navigation_extension.dart';
import '../../../core/extensions/theme_extensions.dart';
import '../../../core/res/router/routes.dart';
import 'widgets/splash_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startNavigationTimer();
  }

  // void _startNavigationTimer() {
  //   _timer = Timer(
  //     const Duration(seconds: Constants.splashDelaySeconds),
  //     () async {
  //       if (sl<StorageService>().isSkippedOnBoarding) {
  //         if (await sl<StorageService>().isUserRegistered) {
  //           if (mounted) context.pushReplacementNamed(Routes.home);
  //         } else {
  //           if (mounted) context.pushReplacementNamed(Routes.login);
  //         }
  //       } else {
  //         if (mounted) context.pushReplacementNamed(Routes.onboarding);
  //       }
  //     },
  //   );
  // }
  void _startNavigationTimer() {
    _timer = Timer(const Duration(seconds: Constants.splashDelaySeconds), () {
      if (!mounted) return;

      if (sl<StorageService>().isSkippedOnBoarding) {
        context.pushReplacementNamed(Routes.login);
      } else {
        context.pushReplacementNamed(Routes.onboarding);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            // Centered Luxury Logo with FlutterAnimate
            Logo(isDark: isDark),
          ],
        ),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  final bool isDark;

  const Logo({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SplashLogo(isDark: isDark)
          .animate()
          .fadeIn(duration: 900.ms, curve: Curves.easeOut)
          .scale(
            begin: const Offset(0.92, 0.92),
            end: const Offset(1.0, 1.0),
            duration: 900.ms,
            curve: Curves.easeOutCubic,
          ),
    );
  }
}
