import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../extensions/theme_extensions.dart';

class AppIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final double? size;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final String? tooltip;

  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveSize = size ?? 44.w;
    final effectiveBg = backgroundColor ?? context.surfaceElevatedColor;
    final effectiveBorder = borderColor ?? context.borderColor;

    final button = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
        child: Container(
          width: effectiveSize,
          height: effectiveSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: effectiveBg,
            borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
            border: Border.all(color: effectiveBorder, width: 1),
          ),
          child: icon,
        ),
      ),
    );

    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: button);
    }
    return button;
  }
}
