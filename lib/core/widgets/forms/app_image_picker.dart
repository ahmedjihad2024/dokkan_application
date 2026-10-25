import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../extensions/theme_extensions.dart';
import '../../res/color_manager.dart';
import '../../res/gen/assets.gen.dart';

class AppImagePickerBox extends StatelessWidget {
  final String? imagePath;
  final bool isCover;
  final VoidCallback onTap;
  final VoidCallback? onRemove;
  final double? width;
  final double? height;

  const AppImagePickerBox({
    super.key,
    this.imagePath,
    this.isCover = false,
    required this.onTap,
    this.onRemove,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveWidth = width ?? (isCover ? 96.w : 64.w);
    final effectiveHeight = height ?? 88.h;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: effectiveWidth,
            height: effectiveHeight,
            decoration: BoxDecoration(
              color: context.surfaceElevatedColor,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isCover ? ColorM.primary : context.borderColor,
                width: isCover ? 1.5 : 1,
              ),
            ),
            alignment: Alignment.center,
            child: imagePath != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(11.r),
                    child: Image.asset(
                      imagePath!,
                      width: effectiveWidth,
                      height: effectiveHeight,
                      fit: BoxFit.cover,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isCover
                          ? Assets.svg.iconImage.svg(
                              width: 24.w,
                              height: 24.w,
                              colorFilter: ColorFilter.mode(
                                ColorM.primary,
                                BlendMode.srcIn,
                              ),
                            )
                          : Assets.svg.iconPlus.svg(
                              width: 20.w,
                              height: 20.w,
                              colorFilter: ColorFilter.mode(
                                context.isDark ? ColorM.textMutedDark : ColorM.textMutedLight,
                                BlendMode.srcIn,
                              ),
                            ),
                      SizedBox(height: 4.h),
                      Text(
                        isCover ? 'Cover' : 'Add',
                        style: GoogleFonts.inter(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: isCover
                              ? ColorM.primary
                              : (context.isDark ? ColorM.textMutedDark : ColorM.textMutedLight),
                        ),
                      ),
                    ],
                  ),
          ),
          if (isCover)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                decoration: const BoxDecoration(
                  color: ColorM.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    '✓ COVER',
                    style: GoogleFonts.inter(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w700,
                      color: ColorM.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),
          if (imagePath != null && onRemove != null)
            Positioned(
              top: -6,
              right: -6,
              child: GestureDetector(
                onTap: onRemove,
                child: Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: const BoxDecoration(
                    color: ColorM.danger,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Assets.svg.iconClose.svg(
                      width: 12.w,
                      height: 12.w,
                      colorFilter: const ColorFilter.mode(
                        ColorM.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}