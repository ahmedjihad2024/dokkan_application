import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/navigation_extension.dart';
import '../../../../core/extensions/theme_extensions.dart';

class ChangePasswordAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ChangePasswordAppBar({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  Size get preferredSize => Size.fromHeight(60.h);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        height: 60.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        alignment: Alignment.center,
        child: Row(
          children: [
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: context.surfaceElevatedColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.r)),
                ),
              ),
              onPressed: onBack ?? () => context.pop(),
              icon: Icon(Icons.arrow_back, size: 20.r),
            ),
            14.horizontalSpace,
            Expanded(
              child: Text(
                'Change Password',
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  color: context.textPrimaryColor,
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

