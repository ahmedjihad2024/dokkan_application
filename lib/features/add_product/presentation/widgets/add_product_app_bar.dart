import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/gen/assets.gen.dart';
import '../../../../core/widgets/buttons/app_icon_button.dart';

class AddProductAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isEditMode;
  final VoidCallback? onBack;

  const AddProductAppBar({
    super.key,
    this.isEditMode = false,
    this.onBack,
  });

  @override
  Size get preferredSize => Size.fromHeight(56.h);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        height: 52.h,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        alignment: Alignment.center,
        child: Row(
          children: [
            // Back Button matching Figma 37:763 / 37:834
            AppIconButton(
              size: 38.w,
              borderRadius: 12.r,
              backgroundColor: context.surfaceElevatedColor,
              borderColor: Colors.transparent,
              icon: Assets.svg.iconBack.svg(
                width: 16.w,
                height: 16.w,
                colorFilter: ColorFilter.mode(
                  context.textPrimaryColor,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: onBack ?? () => Navigator.maybePop(context),
            ),
            14.horizontalSpace,
            Expanded(
              child: Text(
                isEditMode ? 'Edit Product' : 'Add New Product',
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
