import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../extensions/theme_extensions.dart';
import '../../res/color_manager.dart';
import '../../res/gen/assets.gen.dart';

class CustomCachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? errorBackgroundColor;
  final Widget? errorWidget;
  final Widget? placeholder;
  final BorderRadius? borderRadius;
  final bool isCircle;
  final BorderSide side;

  const CustomCachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.errorBackgroundColor,
    this.errorWidget,
    this.placeholder,
    this.borderRadius,
    this.isCircle = false,
    this.side = BorderSide.none,
  });

  @override
  Widget build(BuildContext context) {
    final double? finalWidth = width;
    final double? finalHeight = height;

    Widget imageWidget = Image.network(
      imageUrl,
      width: finalWidth,
      height: finalHeight,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        if (placeholder != null) return placeholder!;
        return Container(
          width: finalWidth,
          height: finalHeight,
          alignment: Alignment.center,
          color: context.surfaceElevatedColor,
          child: SizedBox(
            width: 24.w,
            height: 24.w,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(ColorM.primary),
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        if (errorWidget != null) return errorWidget!;
        return Container(
          width: finalWidth,
          height: finalHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: errorBackgroundColor ?? context.surfaceElevatedColor,
          ),
          child: Assets.images.appLogo.image(
            width: (finalWidth != null) ? finalWidth * 0.5 : 40.w,
            height: (finalHeight != null) ? finalHeight * 0.5 : 40.w,
            fit: BoxFit.contain,
          ),
        );
      },
    );

    final effectiveRadius = isCircle
        ? BorderRadius.circular(999999)
        : (borderRadius ?? BorderRadius.circular(5.r));

    Widget clipped = ClipRRect(
      borderRadius: effectiveRadius,
      child: imageWidget,
    );

    if (side != BorderSide.none) {
      clipped = Container(
        decoration: BoxDecoration(
          borderRadius: effectiveRadius,
          border: Border.fromBorderSide(side),
        ),
        child: clipped,
      );
    }

    return clipped;
  }
}

// Specialized circular image widget
class CircularCachedImage extends StatelessWidget {
  final String imageUrl;
  final double size;
  final Color? errorBackgroundColor;
  final Widget? errorWidget;
  final Widget? placeholder;
  final bool isCircle;

  const CircularCachedImage({
    super.key,
    required this.imageUrl,
    this.size = 40,
    this.errorBackgroundColor,
    this.errorWidget,
    this.placeholder,
    this.isCircle = true,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCachedImage(
      imageUrl: imageUrl,
      width: size,
      height: size,
      isCircle: true,
      errorBackgroundColor: errorBackgroundColor,
      errorWidget: errorWidget,
      placeholder: placeholder,
    );
  }
}
