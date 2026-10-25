import 'package:flutter/material.dart';

import '../../../core/extensions/theme_extensions.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: const SafeArea(
        child: SizedBox.expand(),
      ),
    );
  }
}