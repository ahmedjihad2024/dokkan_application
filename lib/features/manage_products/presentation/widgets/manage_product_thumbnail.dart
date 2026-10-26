import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../data/models/manage_product_item.dart';

class ManageProductThumbnail extends StatelessWidget {
  final ManageProductItem item;

  const ManageProductThumbnail({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64.w,
      height: 64.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.surfaceElevatedColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: item.imageAsset != null
          ? Image.asset(
              item.imageAsset!,
              width: 44.w,
              height: 44.w,
              fit: BoxFit.contain,
            )
          : Text(
              item.emoji,
              style: TextStyle(fontSize: 28.sp),
            ),
    );
  }
}
