import 'package:dokkan/core/di/dependency_injection.dart';
import 'package:dokkan/core/services/storage_services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/extensions/navigation_extension.dart';
import '../../../core/extensions/theme_extensions.dart';
import '../../../core/res/color_manager.dart';
import '../../../core/res/fonts_manager.dart';
import '../../../core/res/gen/assets.gen.dart';
import '../../../core/res/router/routes.dart';
import '../../../core/res/sizes_manager.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentIndex = ValueNotifier(0);
  bool? _precachedForDark;

  static final List<_OnboardingItem> _onboardingContent = [
    _OnboardingItem(
      title: 'Curated Luxury',
      description:
          'Explore handcrafted timepieces, leather goods, and premium accessories tailored to your personal aesthetic.',
      imageLight: Assets.svg.onboardingWatchLight,
      imageDark: Assets.svg.onboardingWatchDark,
    ),
    _OnboardingItem(
      title: 'Artisanal Craftsmanship',
      description:
          'Every item is certified authentic, created by world-class craftsmen with genuine materials and lifetime care.',
      imageLight: Assets.svg.onboardingBagLight,
      imageDark: Assets.svg.onboardingBagDark,
    ),
    _OnboardingItem(
      title: 'Seamless Shopping',
      description:
          'Enjoy insured express shipping, real-time tracking, and effortless returns directly through the Dokkan app.',
      imageLight: Assets.svg.onboardingGiftLight,
      imageDark: Assets.svg.onboardingGiftDark,
    ),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final isDark = context.isDark;
    if (_precachedForDark != isDark) {
      _precachedForDark = isDark;
      for (final item in _onboardingContent) {
        final asset = isDark ? item.imageDark : item.imageLight;
        SvgAssetLoader(asset.path).loadBytes(context);
      }
    }
  }

  @override
  void dispose() {
    _currentIndex.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void onNavigation() {
    sl<StorageService>().setSkippedOnBoarding();
    context.pushReplacementNamed(Routes.login);
  }

  void _onNext() {
    if (_currentIndex.value < _onboardingContent.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      onNavigation();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar — Skip button (Figma Y:56, H:17, 14sp SemiBold)
            ValueListenableBuilder(
              valueListenable: _currentIndex,
              builder: (context, value, child) {
                final isLastPage = value == _onboardingContent.length - 1;

                return SizedBox(
                  height: 44.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (!isLastPage) ...[
                        TextButton(
                          onPressed: onNavigation,
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeightM.semiBold,
                              color: context.textSecondaryColor,
                            ),
                          ),
                        ).animate().fadeIn(duration: 350.ms),
                        24.horizontalSpace,
                      ],
                    ],
                  ),
                );
              },
            ),

            // Page Slider
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingContent.length,
                onPageChanged: (index) {
                  _currentIndex.value = index;
                },
                itemBuilder: (context, index) {
                  return _OnboardingPageView(
                    key: ValueKey('page_$index'),
                    item: _onboardingContent[index],
                    currentIndex: _currentIndex,
                    totalCount: _onboardingContent.length,
                  );
                },
              ),
            ),

            ValueListenableBuilder<int>(
                  valueListenable: _currentIndex,
                  builder: (context, value, child) {
                    final isLastPage = value == _onboardingContent.length - 1;
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      width: double.infinity,
                      height: SizeM.buttonHeight.h,
                      child: ElevatedButton(
                        onPressed: _onNext,
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: isLastPage
                              ? ColorM.primaryDark
                              : isDark
                              ? const Color(0xFFF8FAFC)
                              : const Color(0xFF0F172A),
                          foregroundColor: isLastPage
                              ? Colors.white
                              : isDark
                              ? const Color(0xFF0F172A)
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              SizeM.buttonBorderRadius.r,
                            ),
                          ),
                        ),
                        child: Text(
                          isLastPage ? 'Get Started' : 'Continue \u2192',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeightM.semiBold,
                          ),
                        ),
                      ),
                    );
                  },
                )
                .animate()
                .fadeIn(duration: 450.ms, delay: 200.ms)
                .slideY(
                  begin: 0.2,
                  end: 0,
                  duration: 450.ms,
                  curve: Curves.easeOutCubic,
                ),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPageView extends StatefulWidget {
  final _OnboardingItem item;
  final ValueNotifier<int> currentIndex;
  final int totalCount;

  const _OnboardingPageView({
    super.key,
    required this.item,
    required this.currentIndex,
    required this.totalCount,
  });

  @override
  State<_OnboardingPageView> createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<_OnboardingPageView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isDark = context.isDark;
    final image = isDark ? widget.item.imageDark : widget.item.imageLight;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      physics: const ClampingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 8.h),

          // Hero Illustration Frame (Figma: 342x320, Radius: 28, Gradient Fill)
          RepaintBoundary(
            child:
                Container(
                      height: 320.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28.r),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: isDark
                              ? const [Color(0xFF1E293B), Color(0xFF131926)]
                              : const [Color(0xFFF8FAFC), Color(0xFFF1F5F9)],
                        ),
                        border: Border.all(
                          color: isDark
                              ? const Color(0xFF283347)
                              : ColorM.borderLight,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: image.svg(height: 180.h, fit: BoxFit.contain),
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 450.ms, curve: Curves.easeOut)
                    .scale(
                      begin: const Offset(0.94, 0.94),
                      end: const Offset(1, 1),
                      duration: 450.ms,
                      curve: Curves.easeOutCubic,
                    ),
          ),

          // Figma Spacing to Dots: 28px
          SizedBox(height: 28.h),

          // Dots Indicator (Figma: Active 24x8 #C06C38, Inactive 8x8, Spacing 8)
          ValueListenableBuilder<int>(
            valueListenable: widget.currentIndex,
            builder: (context, value, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.totalCount, (dotIndex) {
                  final isActive = value == dotIndex;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    height: 8.h,
                    width: isActive ? 24.w : 8.w,
                    decoration: BoxDecoration(
                      color: isActive
                          ? ColorM.primaryDark
                          : isDark
                          ? const Color(0xFF334155)
                          : const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  );
                }),
              );
            },
          ).animate().fadeIn(duration: 350.ms, delay: 100.ms),

          // Figma Spacing to Title: 28px
          SizedBox(height: 28.h),

          // Title (Figma: 24sp Bold #F0F6FC Dark / #0F172A Light)
          Text(
                widget.item.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: context.textPrimaryColor,
                  letterSpacing: -0.3,
                ),
              )
              .animate()
              .fadeIn(duration: 400.ms, delay: 150.ms)
              .slideY(
                begin: 0.15,
                end: 0,
                duration: 400.ms,
                curve: Curves.easeOutCubic,
              ),

          // Figma Spacing to Description: 12px
          SizedBox(height: 12.h),

          // Description (Figma: 14sp Regular, LineHeight 22px, #94A3B8 Dark / #64748B Light)
          Container(
                constraints: BoxConstraints(maxWidth: 320.w),
                child: Text(
                  widget.item.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeightM.regular,
                    color: context.textSecondaryColor,
                    height: 22 / 14,
                  ),
                ),
              )
              .animate()
              .fadeIn(duration: 400.ms, delay: 250.ms)
              .slideY(
                begin: 0.15,
                end: 0,
                duration: 400.ms,
                curve: Curves.easeOutCubic,
              ),
        ],
      ),
    );
  }
}

class _OnboardingItem {
  final String title;
  final String description;
  final SvgGenImage imageLight;
  final SvgGenImage imageDark;

  const _OnboardingItem({
    required this.title,
    required this.description,
    required this.imageLight,
    required this.imageDark,
  });
}
