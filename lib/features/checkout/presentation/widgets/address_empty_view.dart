import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';

class AddressEmptyView extends StatelessWidget {
  final VoidCallback onAddAddress;

  const AddressEmptyView({
    super.key,
    required this.onAddAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorM.primaryDark.withValues(alpha: 0.12),
              ),
              child: Icon(
                Icons.location_on_outlined,
                size: 38.sp,
                color: ColorM.primaryDark,
              ),
            ),
            18.verticalSpace,
            Text(
              'No Saved Addresses Yet',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: context.textPrimaryColor,
              ),
            ),
            8.verticalSpace,
            Text(
              'Add a delivery address to complete your checkout and receive your handcrafted order.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                color: context.textSecondaryColor,
                height: 1.4,
              ),
            ),
            24.verticalSpace,
            SizedBox(
              height: 46.h,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorM.primaryDark,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                ),
                onPressed: onAddAddress,
                icon: const Icon(Icons.add),
                label: Text(
                  'Add Address Now',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        )
            .animate()
            .fadeIn(duration: 450.ms)
            .scale(begin: const Offset(0.96, 0.96), end: const Offset(1, 1)),
      ),
    );
  }
}

