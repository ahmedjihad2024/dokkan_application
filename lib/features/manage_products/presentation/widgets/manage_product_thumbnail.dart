import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/shared/domain/model/product_entity.dart';
import '../../../../core/widgets/images/custom_cached_image.dart';

class ManageProductThumbnail extends StatelessWidget {
  final ProductEntity product;

  const ManageProductThumbnail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final imageUrl = product.coverPictureUrl;

    return Container(
      width: 64.w,
      height: 64.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.surfaceElevatedColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: (imageUrl != null && imageUrl.isNotEmpty)
          ? CustomCachedImage(
              imageUrl: imageUrl,
              width: 64.w,
              height: 64.w,
              fit: BoxFit.cover,
              memCacheWidth: 160,
              memCacheHeight: 160,
              borderRadius: BorderRadius.circular(10.r),
              errorWidget: const _ThumbnailFallback(),
            )
          : const _ThumbnailFallback(),
    );
  }
}

class _ThumbnailFallback extends StatelessWidget {
  const _ThumbnailFallback();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.image_outlined,
        size: 26.sp,
        color: context.textMutedColor,
      ),
    );
  }
}
