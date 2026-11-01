import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/widgets/cards/surface_card.dart';
import '../../data/models/manage_product_item.dart';
import 'manage_product_actions.dart';
import 'manage_product_info.dart';
import 'manage_product_thumbnail.dart';

class ManageProductCard extends StatelessWidget {
  final ManageProductItem item;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ManageProductCard({
    super.key,
    required this.item,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      margin: EdgeInsets.only(bottom: 10.h),
      borderRadius: 14.r,
      backgroundColor: context.surfaceColor,
      borderColor: context.borderColor,
      child: Row(
        children: [
          ManageProductThumbnail(item: item),
          10.horizontalSpace,
          Expanded(child: ManageProductInfo(item: item)),
          8.horizontalSpace,
          ManageProductActions(
            onEdit: onEdit,
            onDelete: onDelete,
          ),
        ],
      ),
    );
  }
}
