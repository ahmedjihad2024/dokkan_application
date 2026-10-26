import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/res/gen/assets.gen.dart';
import '../../../../core/widgets/buttons/app_icon_button.dart';

class ManageProductActions extends StatelessWidget {
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ManageProductActions({
    super.key,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Edit Icon Button matching Figma 37:648 / 37:713
        AppIconButton(
          size: 28.w,
          borderRadius: 8.r,
          backgroundColor: context.surfaceElevatedColor,
          borderColor: Colors.transparent,
          tooltip: 'Edit Product',
          icon: Assets.svg.iconEdit.svg(
            width: 14.w,
            height: 14.w,
            colorFilter: ColorFilter.mode(
              context.textSecondaryColor,
              BlendMode.srcIn,
            ),
          ),
          onPressed: onEdit,
        ),
        SizedBox(width: 8.w),
        // Delete Icon Button matching Figma 37:651 / 37:716
        AppIconButton(
          size: 28.w,
          borderRadius: 8.r,
          backgroundColor: context.dangerContainerColor,
          borderColor: Colors.transparent,
          tooltip: 'Delete Product',
          icon: Assets.svg.iconTrash.svg(
            width: 14.w,
            height: 14.w,
            colorFilter: const ColorFilter.mode(
              ColorM.danger,
              BlendMode.srcIn,
            ),
          ),
          onPressed: onDelete,
        ),
      ],
    );
  }
}
