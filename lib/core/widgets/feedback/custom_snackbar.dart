import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../res/color_manager.dart';

class CustomSnackBar {
  static OverlayEntry? _currentOverlayEntry;

  static void hideCurrent([BuildContext? context]) {
    if (_currentOverlayEntry != null) {
      try {
        _currentOverlayEntry!.remove();
      } catch (_) {}
      _currentOverlayEntry = null;
    }
    if (context != null) {
      ScaffoldMessenger.maybeOf(context)?.hideCurrentSnackBar();
    }
  }

  static void showSuccess(
    BuildContext context,
    String message, {
    bool isTop = false,
    double? topOffset,
    Duration duration = const Duration(seconds: 3),
  }) {
    _show(
      context,
      message,
      ColorM.success,
      Icons.check_circle_outline,
      isTop: isTop,
      topOffset: topOffset,
      duration: duration,
    );
  }

  static void showError(
    BuildContext context,
    String message, {
    bool isTop = false,
    double? topOffset,
    Duration duration = const Duration(seconds: 3),
  }) {
    _show(
      context,
      message,
      ColorM.danger,
      Icons.error_outline,
      isTop: isTop,
      topOffset: topOffset,
      duration: duration,
    );
  }

  static void showWarning(
    BuildContext context,
    String message, {
    bool isTop = false,
    double? topOffset,
    Duration duration = const Duration(seconds: 3),
  }) {
    _show(
      context,
      message,
      ColorM.warning,
      Icons.warning_amber_rounded,
      isTop: isTop,
      topOffset: topOffset,
      duration: duration,
    );
  }

  static void _show(
    BuildContext context,
    String message,
    Color accentColor,
    IconData icon, {
    bool isTop = false,
    double? topOffset,
    Duration duration = const Duration(seconds: 3),
  }) {
    if (isTop) {
      _showTopOverlay(
        context,
        message,
        accentColor,
        icon,
        topOffset: topOffset,
        duration: duration,
      );
    } else {
      _showBottomSnackBar(
        context,
        message,
        accentColor,
        icon,
        duration: duration,
      );
    }
  }

  static void _showTopOverlay(
    BuildContext context,
    String message,
    Color accentColor,
    IconData icon, {
    double? topOffset,
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlayState = Overlay.maybeOf(context);
    if (overlayState == null) {
      // Fallback to bottom snackbar if overlay is unavailable
      _showBottomSnackBar(
        context,
        message,
        accentColor,
        icon,
        duration: duration,
      );
      return;
    }

    hideCurrent(context);

    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => _TopToastBanner(
        message: message,
        accentColor: accentColor,
        icon: icon,
        topOffset: topOffset,
        duration: duration,
        onDismissed: () {
          if (_currentOverlayEntry == entry) {
            _currentOverlayEntry = null;
            try {
              entry.remove();
            } catch (_) {}
          }
        },
      ),
    );

    _currentOverlayEntry = entry;
    overlayState.insert(entry);
  }

  static void _showBottomSnackBar(
    BuildContext context,
    String message,
    Color accentColor,
    IconData icon, {
    Duration duration = const Duration(seconds: 3),
  }) {
    hideCurrent(context);
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) return;

    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: ColorM.surfaceDarkElevated,
        elevation: 4,
        margin: EdgeInsets.all(16.r),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        dismissDirection: DismissDirection.down,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(color: accentColor.withValues(alpha: 0.5), width: 1),
        ),
        content: Row(
          children: [
            Icon(icon, color: accentColor, size: 20.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: ColorM.textPrimaryDark,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

class _TopToastBanner extends StatefulWidget {
  final String message;
  final Color accentColor;
  final IconData icon;
  final double? topOffset;
  final VoidCallback onDismissed;
  final Duration duration;

  const _TopToastBanner({
    required this.message,
    required this.accentColor,
    required this.icon,
    this.topOffset,
    required this.onDismissed,
    this.duration = const Duration(seconds: 3),
  });

  @override
  State<_TopToastBanner> createState() => _TopToastBannerState();
}

class _TopToastBannerState extends State<_TopToastBanner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;
  late final Animation<double> _fadeAnimation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    ));

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );

    _controller.forward();

    _timer = Timer(widget.duration, _dismiss);
  }

  void _dismiss() async {
    _timer?.cancel();
    if (!mounted) return;
    try {
      await _controller.reverse();
    } catch (_) {}
    if (mounted) {
      widget.onDismissed();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.topOffset ?? 0,
      left: 0,
      right: 0,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: SlideTransition(
            position: _offsetAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Dismissible(
                key: const ValueKey('top_toast_dismissible'),
                direction: DismissDirection.up,
                onDismissed: (_) => widget.onDismissed(),
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorM.surfaceDarkElevated,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: widget.accentColor.withValues(alpha: 0.5),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.28),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          widget.icon,
                          color: widget.accentColor,
                          size: 20.sp,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text(
                            widget.message,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: ColorM.textPrimaryDark,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}