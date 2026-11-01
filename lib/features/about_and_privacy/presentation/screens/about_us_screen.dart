import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../widgets/about_atelier_brand_card.dart';
import '../widgets/about_heritage_card.dart';
import '../widgets/about_material_cards.dart';
import '../widgets/about_privacy_app_bar.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: const AboutPrivacyAppBar(title: 'About Us'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AboutAtelierBrandCard()
                .animate()
                .fadeIn(duration: 400.ms, delay: 60.ms)
                .slideY(
                  begin: 0.08,
                  end: 0,
                  duration: 400.ms,
                  curve: Curves.easeOutCubic,
                ),
            16.verticalSpace,
            const AboutHeritageCard()
                .animate()
                .fadeIn(duration: 400.ms, delay: 140.ms)
                .slideY(
                  begin: 0.08,
                  end: 0,
                  duration: 400.ms,
                  curve: Curves.easeOutCubic,
                ),
            16.verticalSpace,
            const AboutMaterialCards()
                .animate()
                .fadeIn(duration: 400.ms, delay: 220.ms)
                .slideY(
                  begin: 0.08,
                  end: 0,
                  duration: 400.ms,
                  curve: Curves.easeOutCubic,
                ),
          ],
        ),
      ),
    );
  }
}
