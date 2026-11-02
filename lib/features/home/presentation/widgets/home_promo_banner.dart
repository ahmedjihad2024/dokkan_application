import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/widgets/images/custom_cached_image.dart';
import '../../domain/model/offer_entity.dart';

class HomePromoBanner extends StatefulWidget {
  final List<OfferEntity> offers;

  const HomePromoBanner({
    super.key,
    required this.offers,
  });

  @override
  State<HomePromoBanner> createState() => _HomePromoBannerState();
}

class _HomePromoBannerState extends State<HomePromoBanner> {
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.offers.isEmpty) return const SizedBox.shrink();

    final isDark = context.isDark;

    return CarouselSlider.builder(
      itemCount: widget.offers.length,
      options: CarouselOptions(
        height: 140.h,
        viewportFraction: 1.0,
        initialPage: 0,
        enableInfiniteScroll: widget.offers.length > 1,
        autoPlay: widget.offers.length > 1,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayAnimationDuration: const Duration(milliseconds: 700),
        autoPlayCurve: Curves.easeInOutCubic,
        enlargeCenterPage: false,
        onPageChanged: (index, _) {
          setState(() => _activeIndex = index);
        },
      ),
      itemBuilder: (context, index, realIndex) {
        final offer = widget.offers[index];
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
                        // Special Offer Badge
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
                            'SPECIAL OFFER',
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                              color: ColorM.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        // Offer Name / Title
                        Text(
                          offer.name,
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
                        // Offer Description / Subtitle
                        Text(
                          offer.description ??
                              'Curated Dokkan atelier special offer',
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
                    // Page Indicator Dots
                    if (widget.offers.length > 1)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children:
                            List.generate(widget.offers.length, (dotIndex) {
                          final isCurrent = dotIndex == _activeIndex;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOutCubic,
                            margin: EdgeInsets.only(
                              right:
                                  dotIndex < widget.offers.length - 1 ? 6.w : 0,
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
              // Offer Cover Image
              SizedBox(
                width: 80.w,
                height: 80.w,
                child: Center(
                  child: offer.coverUrl.isNotEmpty
                      ? CustomCachedImage(
                          imageUrl: offer.coverUrl,
                          width: 76.w,
                          height: 76.w,
                          fit: BoxFit.contain,
                          errorWidget: Text(
                            '✨',
                            style: TextStyle(fontSize: 48.sp),
                          ),
                        )
                      : Text(
                          '✨',
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
