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

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 145.h,
          child: PageView.builder(
            itemCount: banners.length,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) {
              final banner = banners[index];
              return Container(
                margin:
                    EdgeInsets.symmetric(horizontal: 2.w) +
                    EdgeInsets.symmetric(horizontal: 20.w),
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isDark ? ColorM.borderDark : Colors.transparent,
                    width: 1,
                  ),
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
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Text details
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Season Atelier Badge matching Figma 37:342
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              color: ColorM.primary,
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
                          SizedBox(height: 8.h),
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
                          SizedBox(height: 4.h),
                          // Description matching Figma 37:345
                          Text(
                            banner.subtitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: ColorM.textMutedLight,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    // Visual Emoji / Accessory representation matching Figma 37:346
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Container(
                          width: 72.w,
                          height: 72.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.08),
                          ),
                          child: Text(
                            banner.visualEmoji,
                            style: TextStyle(fontSize: 44.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10.h),
        // Indicator Dots matching Figma 37:347
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(banners.length, (index) {
            final isActive = index == activeIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              width: isActive ? 18.w : 6.w,
              height: 6.h,
              decoration: BoxDecoration(
                color: isActive
                    ? ColorM.primary
                    : (isDark
                          ? ColorM.textMutedDark
                          : ColorM.textSecondaryLight),
                borderRadius: BorderRadius.circular(3.r),
              ),
            );
          }),
        ),
      ],
    );
  }
}
