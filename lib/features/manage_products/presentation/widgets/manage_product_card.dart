import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/shared/domain/model/product_entity.dart';
import '../../../../core/widgets/cards/surface_card.dart';
import 'manage_product_actions.dart';
import 'manage_product_info.dart';
import 'manage_product_thumbnail.dart';

class ManageProductCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool isDeleting;

  const ManageProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.isDeleting = false,
  });

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      onTap: onTap,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      margin: EdgeInsets.only(bottom: 10.h),
      borderRadius: 14.r,
      backgroundColor: context.surfaceColor,
      borderColor: context.borderColor,
      child: Row(
        children: [
          ManageProductThumbnail(product: product),
          10.horizontalSpace,
          Expanded(child: ManageProductInfo(product: product)),
          8.horizontalSpace,
          ManageProductActions(
            onEdit: onEdit,
            onDelete: onDelete,
            isDeleting: isDeleting,
          ),
        ],
      ),
    );
  }
}
