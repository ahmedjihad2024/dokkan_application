import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/res/gen/assets.gen.dart';
import '../../../../core/widgets/images/custom_cached_image.dart';

class ProductImageGallery extends StatefulWidget {
  final String? imageUrl;
  final List<String> pictures;
  final String? discountTag;
  final String emoji;

  const ProductImageGallery({
    super.key,
    this.imageUrl,
    this.pictures = const [],
    this.discountTag = '-25%',
    this.emoji = '⌚',
  });

  @override
  State<ProductImageGallery> createState() => _ProductImageGalleryState();
}

class _ProductImageGalleryState extends State<ProductImageGallery> {
  int _selectedIndex = 0;

  List<String> get _allImages {
    final list = <String>[];
    if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty) {
      list.add(widget.imageUrl!);
    }
    for (final p in widget.pictures) {
      if (p.isNotEmpty && !list.contains(p)) {
        list.add(p);
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final gradientColors = context.productHeroGradient;
    final borderColor = context.borderColor;
    final thumbBg = context.surfaceSubtleColor;
    final images = _allImages;
    final currentImage = images.isNotEmpty && _selectedIndex < images.length
        ? images[_selectedIndex]
        : widget.imageUrl;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hero Image Container (342x172, radius 20) matching Figma
        Container(
          width: 342.w,
          height: 172.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors,
            ),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: borderColor, width: 1),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Centered Product Visual matching Figma
              Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
                  child: currentImage != null && currentImage.isNotEmpty
                      ? CustomCachedImage(
                          key: ValueKey('img_${currentImage}_$_selectedIndex'),
                          imageUrl: currentImage,
                          width: double.infinity,
                          height: 172.h,
                          fit: BoxFit.contain,
                          errorWidget: _buildWatchAsset(),
                        )
                      : _buildWatchAsset(),
                ),
              ),

              // Discount Tag (Top-Left) matching Figma 37:516 / 37:576
              if (widget.discountTag != null && widget.discountTag!.isNotEmpty)
                Positioned(
                  top: 12.h,
                  left: 12.w,
                  child: Container(
                    width: 50.w,
                    height: 22.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ColorM.danger,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      widget.discountTag!,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: ColorM.white,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),

        SizedBox(height: 12.h),

        // Thumbnail Selector Row matching Figma 37:519 / 37:579
        SizedBox(
          height: 44.w,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: images.length,
            separatorBuilder: (_, _) => SizedBox(width: 10.w),
            itemBuilder: (context, index) {
              final isSelected = _selectedIndex == index;
              final thumbUrl = images[index];

              return GestureDetector(
                onTap: () => setState(() => _selectedIndex = index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 44.w,
                  height: 44.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: thumbBg,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isSelected ? ColorM.primaryDark : borderColor,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Opacity(
                    opacity: isSelected ? 1.0 : 0.65,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: CustomCachedImage(
                        imageUrl: thumbUrl,
                        width: 44.w,
                        height: 44.w,
                        fit: BoxFit.cover,
                        errorWidget: _buildThumbnailVisual(),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWatchAsset() {
    return Assets.images.productWatch.image(
      height: 110.h,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Text(widget.emoji, style: TextStyle(fontSize: 70.sp));
      },
    );
  }

  Widget _buildThumbnailVisual() {
    return Assets.images.productWatch.image(
      height: 26.w,
      width: 26.w,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Text(widget.emoji, style: TextStyle(fontSize: 18.sp));
      },
    );
  }
}
