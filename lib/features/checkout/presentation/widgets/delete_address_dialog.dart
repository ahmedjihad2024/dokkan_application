import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/navigation_extension.dart';
import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';

class DeleteAddressDialog extends StatelessWidget {
  final String street;
  final String city;
  final VoidCallback? onConfirm;

  const DeleteAddressDialog({
    super.key,
    required this.street,
    required this.city,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.all(22.r),
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: context.borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorM.danger.withValues(alpha: 0.12),
              ),
              child: Icon(
                Icons.delete_outline_rounded,
                size: 28.sp,
                color: ColorM.danger,
              ),
            ),
            16.verticalSpace,

            Text(
              'Delete Address?',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: context.textPrimaryColor,
              ),
            ),
            8.verticalSpace,

            Text(
              'Are you sure you want to remove \'$street, $city\'? You will need to add it again for future orders.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                color: context.textSecondaryColor,
                height: 1.4,
              ),
            ),
            22.verticalSpace,

            // Confirm Delete
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorM.danger,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  onConfirm?.call();
                  context.pop(true);
                },
                child: Text(
                  'Yes, Delete Address',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            10.verticalSpace,

            // Cancel
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: context.textPrimaryColor,
                  side: BorderSide(color: context.borderColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                onPressed: () => context.pop(false),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

