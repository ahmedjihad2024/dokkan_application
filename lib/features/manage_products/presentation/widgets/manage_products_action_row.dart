import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';

class ManageProductsActionRow extends StatelessWidget {
  final int itemCount;
  final VoidCallback onAddProduct;

  const ManageProductsActionRow({
    super.key,
    required this.itemCount,
    required this.onAddProduct,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 14.h),
      child: Row(
        children: [
          // Published Items Count matching Figma 37:637 / 37:702
          Expanded(
            child: Text(
              '$itemCount Published Items',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: context.textPrimaryColor,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          // Add Product Button matching Figma 37:638 / 37:703
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onAddProduct,
              borderRadius: BorderRadius.circular(18.r),
              child: Container(
                height: 36.h,
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                decoration: BoxDecoration(
                  color: ColorM.primaryDark,
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add,
                      size: 16.sp,
                      color: ColorM.white,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Add Product',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorM.white,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
