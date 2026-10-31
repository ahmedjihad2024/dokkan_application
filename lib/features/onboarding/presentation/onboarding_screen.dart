import 'package:dokkan/core/res/color_manager.dart';
import 'package:dokkan/core/res/fonts_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/extensions/navigation_extension.dart';
import '../../../core/extensions/theme_extensions.dart';
import '../../../core/res/router/routes.dart';
import '../../../core/widgets/buttons/primary_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    final List onboardingData = [
      {
        'title': 'Curated Luxury',
        'description': 'Explore handcrafted timepieces, leather goods, and premium accessories tailored to your personal aesthetic.',
        'image': isDark
            ? 'assets/svg/onboarding_watch_dark.svg'
            : 'assets/svg/onboarding_watch_light.svg',
      },
      {
        'title': 'Artisanal Craftsmanship',
        'description': 'Every item is certified authentic, created by world-class craftsmen with genuine materials and lifetime care.',
        'image': isDark
            ? 'assets/svg/onboarding_bag_dark.svg'
            : 'assets/svg/onboarding_bag_light.svg',
      },
      {
        'title': 'Seamless Shopping',
        'description': 'Enjoy insured express shipping, real-time tracking, and effortless returns directly through the Dokkan app.',
        'image': isDark
            ? 'assets/svg/onboarding_gift_dark.svg'
            : 'assets/svg/onboarding_gift_light.svg',
      },
    ];

    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            children: [
              _currentIndex < onboardingData.length - 1
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          context.pushReplacementNamed(Routes.login);
                        },
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeightM.semiBold,
                            color: context.textSecondaryColor,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(height: 48.h),
              SizedBox(height: 20.h),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: onboardingData.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 300.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: context.surfaceColor,
                            borderRadius: BorderRadius.circular(24.r),
                            border: Border.all(
                              color: context.borderColor,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              onboardingData[index]['image']!,
                              height: 180.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(height: 40.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            onboardingData.length,
                            (dotIndex) => AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: EdgeInsets.symmetric(horizontal: 4.w),
                              height: 8.h,
                              width: _currentIndex == dotIndex ? 24.w : 8.w,
                              decoration: BoxDecoration(
                                color: _currentIndex == dotIndex
                                    ? ColorM.primary600
                                    : context.textSecondaryColor.withValues(
                                        alpha: 0.3,
                                      ),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 32.h),
                        Text(
                          onboardingData[index]['title']!,
                          style: TextStyle(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w700,
                            color: context.textPrimaryColor,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          onboardingData[index]['description']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: context.textSecondaryColor,
                            height: 1.5,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              PrimaryButton(
                title: _currentIndex == onboardingData.length - 1
                    ? 'Get Started'
                    : 'Continue',
                onPressed: () {
                  if (_currentIndex < onboardingData.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    context.pushReplacementNamed(Routes.login);
                  }
                },
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
