import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/widgets/cards/surface_card.dart';

class AddProductImagePickersCard extends StatelessWidget {
  final String? coverImagePath;
  final List<String> galleryImages;
  final bool hasCoverError;
  final VoidCallback? onCoverTap;
  final VoidCallback? onAddGalleryImage;
  final ValueChanged<int>? onRemoveGalleryImage;
  final ValueChanged<int>? onReplaceGalleryImage;

  const AddProductImagePickersCard({
    super.key,
    this.coverImagePath,
    this.galleryImages = const [],
    this.hasCoverError = false,
    this.onCoverTap,
    this.onAddGalleryImage,
    this.onRemoveGalleryImage,
    this.onReplaceGalleryImage,
  });

  bool get _hasCover => coverImagePath != null && coverImagePath!.trim().isNotEmpty;

  Widget _buildImage(
    BuildContext context,
    String path, {
    required double width,
    required double height,
  }) {
    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            _fallbackPlaceholder(context, width),
      );
    }
    return Image.file(
      File(path),
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          _fallbackPlaceholder(context, width),
    );
  }

  Widget _fallbackPlaceholder(BuildContext context, double size) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      color: context.surfaceElevatedColor,
      child: Icon(
        Icons.image_outlined,
        size: size * 0.45,
        color: context.textSecondaryColor,
      ),
    );
  }

  Widget _buildCoverContent(BuildContext context) {
    if (_hasCover) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(9.r),
        child: _buildImage(
          context,
          coverImagePath!,
          width: 76.w,
          height: 76.w,
        ),
      );
    }

    // Empty state: clean camera icon, no hardcoded placeholder
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Icon(
        Icons.add_a_photo_outlined,
        size: 24.sp,
        color: hasCoverError ? ColorM.danger : context.textSecondaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final primaryAccent =
        isDark ? const Color(0xFFD47A4A) : const Color(0xFFB85C36);

    return SurfaceCard(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      borderRadius: 14.r,
      backgroundColor: context.surfaceColor,
      borderColor: context.borderColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Cover Image Slot (76x76)
              GestureDetector(
                onTap: onCoverTap,
                child: Container(
                  width: 76.w,
                  height: 76.w,
                  decoration: BoxDecoration(
                    color: context.surfaceElevatedColor,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: hasCoverError
                          ? ColorM.danger
                          : (_hasCover ? primaryAccent : context.borderColor),
                      width: _hasCover || hasCoverError ? 1.5 : 1.0,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Cover content (Picked Image or Empty Add-Photo Icon)
                      _buildCoverContent(context),

                      // Cover Badge (+ COVER when empty, ✓ COVER when selected)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 18.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: hasCoverError
                                ? ColorM.danger
                                : (_hasCover
                                    ? primaryAccent
                                    : primaryAccent.withValues(alpha: 0.15)),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8.r),
                              bottomRight: Radius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            _hasCover ? '✓ COVER' : '+ COVER',
                            style: TextStyle(
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w700,
                              color: hasCoverError || _hasCover
                                  ? ColorM.white
                                  : primaryAccent,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: 10.w),

              // Gallery Slots Row & Subtext
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: List.generate(3, (index) {
                        final hasImage = index < galleryImages.length;
                        return Padding(
                          padding: EdgeInsets.only(right: index < 2 ? 8.w : 0),
                          child: hasImage
                              ? _buildFilledSlot(
                                  context,
                                  index,
                                  galleryImages[index],
                                )
                              : _buildEmptySlot(context),
                        );
                      }),
                    ),
                    SizedBox(height: 8.h),

                    // Helper caption matching Figma 37:780 / 37:851
                    Text(
                      'High-res PNG/JPG • Up to 10MB per angle',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: context.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilledSlot(BuildContext context, int index, String imagePath) {
    return GestureDetector(
      onTap: () => onReplaceGalleryImage?.call(index),
      child: Container(
        width: 48.w,
        height: 48.w,
        decoration: BoxDecoration(
          color: context.surfaceElevatedColor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: context.borderColor, width: 1),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7.r),
              child: _buildImage(
                context,
                imagePath,
                width: 48.w,
                height: 48.w,
              ),
            ),
            // Remove 'x' badge on top right
            Positioned(
              top: 2.w,
              right: 2.w,
              child: GestureDetector(
                onTap: () => onRemoveGalleryImage?.call(index),
                child: Container(
                  width: 15.w,
                  height: 15.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    size: 10.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptySlot(BuildContext context) {
    return GestureDetector(
      onTap: onAddGalleryImage,
      child: Container(
        width: 48.w,
        height: 48.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: context.surfaceElevatedColor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: context.borderColor,
            width: 1,
            strokeAlign: BorderSide.strokeAlignCenter,
          ),
        ),
        child: Icon(
          Icons.add,
          size: 18.sp,
          color: context.textSecondaryColor,
        ),
      ),
    );
  }
}
