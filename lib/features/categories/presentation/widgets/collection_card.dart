import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/res/fonts_manager.dart';
import '../../../../core/res/sizes_manager.dart';
import '../../../../core/widgets/images/custom_cached_image.dart';
import '../../domain/model/category_entity.dart';

class CollectionCard extends StatelessWidget {
  final CategoryEntity category;
  final VoidCallback? onTap;

  const CollectionCard({
    super.key,
    required this.category,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = category.coverPictureUrl != null &&
        category.coverPictureUrl!.trim().isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(SizeM.cardBorderRadius.r),
        border: Border.all(color: context.borderColor),
        boxShadow: [
          BoxShadow(
            color: context.borderColor.withValues(alpha: 0.05),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(SizeM.cardBorderRadius.r),
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (hasImage)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: CustomCachedImage(
                    imageUrl: category.coverPictureUrl!,
                    width: 72.r,
                    height: 72.r,
                    fit: BoxFit.cover,
                    errorWidget: _buildFallbackIcon(context),
                  ),
                )
              else
                _buildFallbackIcon(context),
              Gap(14.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  category.name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: FontsM.inter.name,
                    color: context.textPrimaryColor,
                  ),
                ),
              ),
              if (category.description != null &&
                  category.description!.trim().isNotEmpty) ...[
                Gap(4.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    category.description!,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: context.textSecondaryColor,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackIcon(BuildContext context) {
    return Container(
      width: 56.r,
      height: 56.r,
      padding: EdgeInsets.all(14.r),
      decoration: const BoxDecoration(
        color: ColorM.primary,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.category_outlined,
        color: ColorM.backgroundDark,
        size: 26.r,
      ),
    );
  }
}
