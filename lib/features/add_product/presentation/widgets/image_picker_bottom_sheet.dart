import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  final String title;
  final bool showRemoveOption;
  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;
  final VoidCallback? onRemoveTap;

  const ImagePickerBottomSheet({
    super.key,
    required this.title,
    this.showRemoveOption = false,
    required this.onCameraTap,
    required this.onGalleryTap,
    this.onRemoveTap,
  });

  static Future<void> show(
    BuildContext context, {
    required String title,
    bool showRemoveOption = false,
    required VoidCallback onCameraTap,
    required VoidCallback onGalleryTap,
    VoidCallback? onRemoveTap,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: context.surfaceColor,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetContext) => ImagePickerBottomSheet(
        title: title,
        showRemoveOption: showRemoveOption,
        onCameraTap: () {
          Navigator.of(sheetContext).pop();
          onCameraTap();
        },
        onGalleryTap: () {
          Navigator.of(sheetContext).pop();
          onGalleryTap();
        },
        onRemoveTap: onRemoveTap != null
            ? () {
                Navigator.of(sheetContext).pop();
                onRemoveTap();
              }
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final primaryAccent =
        isDark ? const Color(0xFFD47A4A) : const Color(0xFFB85C36);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Center drag handle
            Center(
              child: Container(
                width: 38.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: context.borderColor,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Header title
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: context.textPrimaryColor,
                letterSpacing: -0.2,
              ),
            ),
            SizedBox(height: 14.h),

            // Camera Option
            _PickerOptionTile(
              icon: Icons.camera_alt_rounded,
              iconColor: primaryAccent,
              title: 'Take Photo',
              subtitle: 'Capture new image using camera',
              onTap: onCameraTap,
            ),
            SizedBox(height: 8.h),

            // Gallery Option
            _PickerOptionTile(
              icon: Icons.photo_library_rounded,
              iconColor: primaryAccent,
              title: 'Choose from Gallery',
              subtitle: 'Select from photos on your device',
              onTap: onGalleryTap,
            ),

            // Optional Remove Option
            if (showRemoveOption && onRemoveTap != null) ...[
              SizedBox(height: 8.h),
              _PickerOptionTile(
                icon: Icons.delete_outline_rounded,
                iconColor: ColorM.danger,
                title: 'Remove Image',
                subtitle: 'Remove the currently selected photo',
                onTap: onRemoveTap!,
                isDestructive: true,
              ),
            ],
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}

class _PickerOptionTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDestructive;

  const _PickerOptionTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: context.surfaceElevatedColor,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: context.borderColor, width: 0.8),
          ),
          child: Row(
            children: [
              Container(
                width: 38.w,
                height: 38.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isDestructive
                      ? context.dangerContainerColor
                      : iconColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(icon, size: 20.sp, color: iconColor),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: isDestructive
                            ? ColorM.danger
                            : context.textPrimaryColor,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: context.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                size: 20.sp,
                color: context.textSecondaryColor.withValues(alpha: 0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
