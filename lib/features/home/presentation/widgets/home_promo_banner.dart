import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../data/models/promo_banner_model.dart';

class HomePromoBanner extends StatelessWidget {
  final List<PromoBannerModel> banners;
  final int activeIndex;
  final ValueChanged<int> onPageChanged;

  const HomePromoBanner({
    super.key,
    required this.banners,
    required this.activeIndex,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (banners.isEmpty) return const SizedBox.shrink();

    final isDark = context.isDark;

    return CarouselSlider.builder(
      itemCount: banners.length,
      options: CarouselOptions(
        height: 140.h,
        viewportFraction: 1.0,
        initialPage: activeIndex,
        enableInfiniteScroll: banners.length > 1,
        autoPlay: banners.length > 1,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayAnimationDuration: const Duration(milliseconds: 700),
        autoPlayCurve: Curves.easeInOutCubic,
        enlargeCenterPage: false,
        onPageChanged: (index, reason) {
          onPageChanged(index);
        },
      ),
      itemBuilder: (context, index, realIndex) {
        final banner = banners[index];
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          padding: EdgeInsets.fromLTRB(18.w, 16.h, 16.w, 14.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? const [
                      ColorM.bannerGradientDarkStart,
                      ColorM.bannerGradientDarkEnd,
                    ]
                  : const [
                      ColorM.bannerGradientLightStart,
                      ColorM.bannerGradientLightEnd,
                    ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.16),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              // Left details: Badge, Headline, Subtitle, and Page Indicator Dots
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Season Atelier Badge matching Figma 37:342
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: ColorM.primaryDark,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            banner.badgeText,
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                              color: ColorM.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        // Headline matching Figma 37:344
                        Text(
                          banner.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w700,
                            color: ColorM.surfaceLightSubtle,
                            letterSpacing: -0.2,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        // Description matching Figma 37:345
                        Text(
                          banner.subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: ColorM.textMutedLight,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                    // Page Indicator Dots inside the banner matching Figma 37:347
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(banners.length, (dotIndex) {
                        final isCurrent = dotIndex == activeIndex;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOutCubic,
                          margin: EdgeInsets.only(
                            right: dotIndex < banners.length - 1 ? 6.w : 0,
                          ),
                          width: isCurrent ? 18.w : 6.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                            color: isCurrent
                                ? ColorM.primaryDark
                                : ColorM.bannerDotInactive,
                            borderRadius: BorderRadius.circular(3.r),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              // 3D Visual Accessory representation matching Figma 37:346
              SizedBox(
                width: 80.w,
                height: 80.w,
                child: Center(
                  child: banner.imageAsset != null
                      ? Image.asset(
                          banner.imageAsset!,
                          width: 76.w,
                          height: 76.w,
                          fit: BoxFit.contain,
                        )
                      : Text(
                          banner.visualEmoji,
                          style: TextStyle(fontSize: 48.sp),
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
