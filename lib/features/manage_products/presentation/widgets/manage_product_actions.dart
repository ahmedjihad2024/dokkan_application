import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/res/gen/assets.gen.dart';
import '../../../../core/widgets/buttons/app_icon_button.dart';

class ManageProductActions extends StatelessWidget {
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool isDeleting;

  const ManageProductActions({
    super.key,
    this.onEdit,
    this.onDelete,
    this.isDeleting = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Edit Icon Button
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
          onPressed: isDeleting ? null : onEdit,
        ),
        SizedBox(width: 8.w),
        // Delete Icon Button
        AppIconButton(
          size: 28.w,
          borderRadius: 8.r,
          backgroundColor: context.dangerContainerColor,
          borderColor: Colors.transparent,
          tooltip: 'Delete Product',
          icon: isDeleting
              ? SizedBox(
                  width: 14.w,
                  height: 14.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(ColorM.danger),
                  ),
                )
              : Assets.svg.iconTrash.svg(
                  width: 14.w,
                  height: 14.w,
                  colorFilter: const ColorFilter.mode(
                    ColorM.danger,
                    BlendMode.srcIn,
                  ),
                ),
          onPressed: isDeleting ? null : onDelete,
        ),
      ],
    );
  }
}
