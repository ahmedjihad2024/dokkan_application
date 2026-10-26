import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/res/gen/assets.gen.dart';
import '../../data/models/manage_product_item.dart';

class DeleteProductDialog extends StatelessWidget {
  final ManageProductItem item;

  const DeleteProductDialog({super.key, required this.item});

  static Future<bool?> show(BuildContext context, ManageProductItem item) {
    return showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.55),
      builder: (context) => DeleteProductDialog(item: item),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.surfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 35.w),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Warning Trash Circle matching Figma 37:902 / 37:931
            Container(
              width: 48.w,
              height: 48.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.dangerContainerColor,
              ),
              child: Assets.svg.iconTrash.svg(
                width: 22.w,
                height: 22.w,
                colorFilter: const ColorFilter.mode(
                  ColorM.danger,
                  BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            // Title matching Figma 37:919 / 37:948
            Text(
              'Delete Product?',
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
                color: context.textPrimaryColor,
                letterSpacing: -0.2,
              ),
            ),
            SizedBox(height: 8.h),
            // Message Description
            Text(
              "Are you sure you want to delete '${item.name}'? This action cannot be undone.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: context.textSecondaryColor,
                height: 1.45,
              ),
            ),
            SizedBox(height: 22.h),
            // Dialog Action Buttons matching Figma 37:902 / 37:931
            Row(
              children: [
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(false),
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        height: 44.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: context.surfaceElevatedColor,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: context.textPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(true),
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        height: 44.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorM.danger,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          'Delete',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorM.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
