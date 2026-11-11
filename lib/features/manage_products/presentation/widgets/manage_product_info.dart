import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/shared/domain/model/product_entity.dart';

class ManageProductInfo extends StatelessWidget {
  final ProductEntity product;

  const ManageProductInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final arabicName = product.arabicName?.trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Product Name (English)
        Text(
          product.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: context.textPrimaryColor,
          ),
        ),
        if (arabicName != null && arabicName.isNotEmpty) ...[
          SizedBox(height: 2.h),
          Text(
            arabicName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
              color: context.textSecondaryColor,
            ),
          ),
        ],
        SizedBox(height: 6.h),
        // Price & Stock Tag
        Text(
          '\$${product.finalPrice.toStringAsFixed(2)}  •  Stock: ${product.stock}',
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
