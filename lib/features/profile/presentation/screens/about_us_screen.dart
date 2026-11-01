import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/gen/assets.gen.dart';
import '../../../../core/widgets/cards/surface_card.dart';
import '../widgets/info_card.dart';
import '../widgets/profile_settings_appbar.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: ProfileSettingsAppBar(
        onBack: () => Navigator.of(context).pop(),
        title: 'About Us',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SurfaceCard(
              width: double.infinity,
              backgroundColor: context.colorScheme.primary.withAlpha(30),
              borderColor: Colors.transparent,
              padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
              child: Column(
                children: [
                  Assets.svg.iconAbout.svg(width: 32, height: 32),

                  SizedBox(height: 3.h),

                  Text(
                    'DOKKAN ATELIER',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.primary,
                      letterSpacing: 1.1,
                    ),
                  ),

                  SizedBox(height: 6.h),

                  Text(
                    'Bespoke Accessories • Established 2018',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            SurfaceCard(
              padding: EdgeInsets.all(16.r),
              child: InfoCard(
                title: 'Our Heritage & Philosophy',
                description:
                    'Dokkan was founded with a devotion to artisanal authenticity. We unite heritage leatherwork, surgical precision timepieces, and fine precious metals to create accessories made to endure for generations.',
              ),
            ),

            SizedBox(height: 16.h),

            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SurfaceCard(
                    padding: EdgeInsets.all(16.r),
                    child: InfoCard(
                      icon: Icons.verified_user_outlined,
                      title: '316L Surgical Steel',
                      description: 'Corrosion-proof luxury',
                      titleFontSize: 14.sp,
                      descriptionFontSize: 11.sp,
                    ),
                  ),
                ),

                SizedBox(width: 12.w),

                Expanded(
                  child: SurfaceCard(
                    padding: EdgeInsets.all(16.r),
                    child: InfoCard(
                      icon: Icons.shopping_bag_outlined,
                      title: 'Italian Calfskin',
                      description: 'Handcrafted patina',
                      titleFontSize: 14.sp,
                      descriptionFontSize: 11.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
