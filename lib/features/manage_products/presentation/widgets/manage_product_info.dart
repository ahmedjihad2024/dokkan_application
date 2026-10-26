import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../data/models/manage_product_item.dart';

class ManageProductInfo extends StatelessWidget {
  final ManageProductItem item;

  const ManageProductInfo({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Product Name (English) matching Figma 37:645 / 37:710
        Text(
          item.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: context.textPrimaryColor,
          ),
        ),
        SizedBox(height: 2.h),
        // Product Name (Arabic) matching Figma 37:646 / 37:711
        Text(
          item.arabicName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
            color: context.textSecondaryColor,
          ),
        ),
        SizedBox(height: 6.h),
        // Price & Stock Tag matching Figma 37:647 / 37:712
        Text(
          '\$${item.price.toStringAsFixed(2)}  •  Stock: ${item.stock}',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: ColorM.primaryDark,
          ),
        ),
      ],
    );
  }
}
