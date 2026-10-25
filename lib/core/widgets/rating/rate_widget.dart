import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class RateWidget extends StatefulWidget {
  final ValueChanged<double>? onRateChange;
  final double? initialRate;
  final Color? activeColor;
  final Color? inactiveColor;
  final double size;
  final double spacing;
  final bool allowHalfRating;
  final IconData filledIcon;
  final IconData halfFilledIcon;
  final IconData unfilledIcon;

  /// Optional SVG asset used to render each star instead of [filledIcon] /
  /// [unfilledIcon]. The asset is tinted with [activeColor] when selected and
  /// [inactiveColor] otherwise. Half ratings are not supported with an asset.
  final String? starAsset;
  final bool readonly;
  final MainAxisAlignment alignment;
  final EdgeInsets padding;

  const RateWidget({
    super.key,
    this.onRateChange,
    this.initialRate,
    this.activeColor,
    this.inactiveColor,
    this.size = 24.0,
    this.spacing = 0.0,
    this.allowHalfRating = false,
    this.filledIcon = Icons.star_rounded,
    this.halfFilledIcon = Icons.star_half_rounded,
    this.unfilledIcon = Icons.star_outline_rounded,
    this.starAsset,
    this.readonly = false,
    this.alignment = MainAxisAlignment.center,
    this.padding = EdgeInsets.zero,
  });

  @override
  State<RateWidget> createState() => _RateWidgetState();
}

class _RateWidgetState extends State<RateWidget> {
  late double rate;

  @override
  void initState() {
    super.initState();
    rate = widget.initialRate ?? 0;
  }

  @override
  void didUpdateWidget(covariant RateWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialRate != oldWidget.initialRate) {
      rate = widget.initialRate ?? 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeColor =
        widget.activeColor ?? const Color(0xFFF59E0B);
    final inactiveColor =
        widget.inactiveColor ?? Colors.black.withValues(alpha: .12);

    return Padding(
      padding: widget.padding,
      child: Row(
        mainAxisAlignment: widget.alignment,
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < 5; i++)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.spacing / 2),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: widget.readonly ? null : () => _updateRating(i + 1.0),
                onHorizontalDragUpdate:
                    widget.readonly || !widget.allowHalfRating
                    ? null
                    : (details) {
                        final box = context.findRenderObject() as RenderBox?;
                        if (box == null) return;
                        final localPosition = box.globalToLocal(
                          details.globalPosition,
                        );
                        final itemWidth = widget.size + widget.spacing;
                        if (itemWidth <= 0) return;
                        final idx = localPosition.dx ~/ itemWidth;
                        if (idx < 0) {
                          _updateRating(0);
                        } else if (idx >= 5) {
                          _updateRating(5);
                        } else {
                          final starPosition = idx * itemWidth;
                          final position =
                              (localPosition.dx - starPosition) / widget.size;
                          _updateRating(idx + (position > 0.5 ? 1.0 : 0.5));
                        }
                      },
                child: _buildStar(i + 1, activeColor, inactiveColor),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStar(int position, Color activeColor, Color inactiveColor) {
    IconData icon;
    Color color;

    if (position <= rate) {
      icon = widget.filledIcon;
      color = activeColor;
    } else if (widget.allowHalfRating && position - 0.5 <= rate) {
      icon = widget.halfFilledIcon;
      color = activeColor;
    } else {
      icon = widget.unfilledIcon;
      color = inactiveColor;
    }

    if (widget.starAsset != null) {
      return SvgPicture.asset(
        widget.starAsset!,
        width: widget.size,
        height: widget.size,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );
    }

    return Icon(icon, color: color, size: widget.size);
  }

  Future<void> _updateRating(double newRating) async {
    if (newRating != rate) {
      setState(() {
        rate = newRating;
      });
      widget.onRateChange?.call(rate);
      await HapticFeedback.lightImpact();
    }
  }
}
