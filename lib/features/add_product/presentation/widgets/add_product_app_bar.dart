import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/gen/assets.gen.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../core/widgets/buttons/app_icon_button.dart';

class AddProductAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBack;

  const AddProductAppBar({super.key, this.onBack});

  @override
  Size get preferredSize => Size.fromHeight(56.h);

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

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
            SizedBox(width: 14.w),
            // Title matching Figma 37:765 / 37:836
            Expanded(
              child: Text(
                'Add New Product',
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
