import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../extensions/theme_extensions.dart';
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
  final int? memCacheWidth;
  final int? memCacheHeight;

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
    this.memCacheWidth,
    this.memCacheHeight,
  });

  static int? _toCachePx(double? size, double dpr) {
    if (size == null || !size.isFinite || size <= 0) return null;
    return (size * dpr).round().clamp(1, 4096);
  }

  @override
  Widget build(BuildContext context) {
    final hasCustomMemCache = memCacheWidth != null || memCacheHeight != null;
    final dpr = MediaQuery.devicePixelRatioOf(context);
    final hasFiniteSize =
        width != null && width!.isFinite && height != null && height!.isFinite;

    final Widget imageWidget;
    if (hasCustomMemCache) {
      imageWidget = _CachedImageView(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        memCacheWidth: memCacheWidth,
        memCacheHeight: memCacheHeight,
        maxWidthDiskCache: memCacheWidth,
        maxHeightDiskCache: memCacheHeight,
        placeholder: placeholder,
        errorWidget: errorWidget,
        errorBackgroundColor: errorBackgroundColor,
      );
    } else if (hasFiniteSize) {
      final cacheW = _toCachePx(width, dpr);
      final cacheH = _toCachePx(height, dpr);
      imageWidget = _CachedImageView(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        memCacheWidth: cacheW,
        memCacheHeight: cacheW == null ? cacheH : null,
        maxWidthDiskCache: cacheW,
        maxHeightDiskCache: cacheH,
        placeholder: placeholder,
        errorWidget: errorWidget,
        errorBackgroundColor: errorBackgroundColor,
      );
    } else {
      imageWidget = LayoutBuilder(
        builder: (context, constraints) {
          final resolvedW = (width != null && width!.isFinite)
              ? width
              : (constraints.hasBoundedWidth ? constraints.maxWidth : null);
          final resolvedH = (height != null && height!.isFinite)
              ? height
              : (constraints.hasBoundedHeight ? constraints.maxHeight : null);
          final cacheW = _toCachePx(resolvedW, dpr);
          final cacheH = _toCachePx(resolvedH, dpr);

          return _CachedImageView(
            imageUrl: imageUrl,
            width: width,
            height: height,
            fit: fit,
            memCacheWidth: cacheW,
            memCacheHeight: cacheW == null ? cacheH : null,
            maxWidthDiskCache: cacheW,
            maxHeightDiskCache: cacheH,
            placeholder: placeholder,
            errorWidget: errorWidget,
            errorBackgroundColor: errorBackgroundColor,
          );
        },
      );
    }

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

class _CachedImageView extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final int? maxWidthDiskCache;
  final int? maxHeightDiskCache;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Color? errorBackgroundColor;

  const _CachedImageView({
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.fit,
    required this.memCacheWidth,
    required this.memCacheHeight,
    required this.maxWidthDiskCache,
    required this.maxHeightDiskCache,
    required this.placeholder,
    required this.errorWidget,
    required this.errorBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      memCacheWidth: memCacheWidth,
      memCacheHeight: memCacheHeight,
      maxWidthDiskCache: maxWidthDiskCache,
      maxHeightDiskCache: maxHeightDiskCache,
      placeholder: placeholder != null ? (context, url) => placeholder! : null,
      errorWidget: (context, url, error) =>
          errorWidget ??
          _DefaultErrorFallback(
            width: width,
            height: height,
            errorBackgroundColor: errorBackgroundColor,
          ),
    );
  }
}

class _DefaultErrorFallback extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? errorBackgroundColor;

  const _DefaultErrorFallback({
    required this.width,
    required this.height,
    required this.errorBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final double logoWidth = (width != null && width!.isFinite)
        ? width! * 0.5
        : 40.w;
    final double logoHeight = (height != null && height!.isFinite)
        ? height! * 0.5
        : 40.w;

    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: errorBackgroundColor ?? context.surfaceElevatedColor,
      ),
      child: Assets.images.appLogo.image(
        width: logoWidth,
        height: logoHeight,
        fit: BoxFit.contain,
      ),
    );
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
  final int? memCacheWidth;
  final int? memCacheHeight;

  const CircularCachedImage({
    super.key,
    required this.imageUrl,
    this.size = 40,
    this.errorBackgroundColor,
    this.errorWidget,
    this.placeholder,
    this.isCircle = true,
    this.memCacheWidth,
    this.memCacheHeight,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCachedImage(
      imageUrl: imageUrl,
      width: size,
      height: size,
      isCircle: isCircle,
      errorBackgroundColor: errorBackgroundColor,
      errorWidget: errorWidget,
      placeholder: placeholder,
      memCacheWidth: memCacheWidth,
      memCacheHeight: memCacheHeight,
    );
  }
}
