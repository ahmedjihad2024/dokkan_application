import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/shared/data/request/products_request.dart';

class SearchSortOption {
  final String label;
  final String subtitle;
  final IconData icon;
  final ProductSortBy sortBy;
  final ProductSortOrder sortOrder;

  const SearchSortOption({
    required this.label,
    required this.subtitle,
    required this.icon,
    required this.sortBy,
    required this.sortOrder,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchSortOption &&
          runtimeType == other.runtimeType &&
          sortBy == other.sortBy &&
          sortOrder == other.sortOrder;

  @override
  int get hashCode => sortBy.hashCode ^ sortOrder.hashCode;
}

const List<SearchSortOption> kSortOptions = [
  SearchSortOption(
    label: 'New Arrivals',
    subtitle: 'Latest pieces added',
    icon: Icons.auto_awesome_rounded,
    sortBy: ProductSortBy.createdAt,
    sortOrder: ProductSortOrder.desc,
  ),
  SearchSortOption(
    label: 'Price: Low → High',
    subtitle: 'Accessible first',
    icon: Icons.trending_up_rounded,
    sortBy: ProductSortBy.price,
    sortOrder: ProductSortOrder.asc,
  ),
  SearchSortOption(
    label: 'Price: High → Low',
    subtitle: 'High-end first',
    icon: Icons.trending_down_rounded,
    sortBy: ProductSortBy.price,
    sortOrder: ProductSortOrder.desc,
  ),
];

class _PricePreset {
  final String label;
  final num? min;
  final num? max;

  const _PricePreset(this.label, this.min, this.max);
}

const List<_PricePreset> kPricePresets = [
  _PricePreset('All', null, null),
  _PricePreset('< \$500', 0, 500),
  _PricePreset('\$500 – \$1.5k', 500, 1500),
  _PricePreset('\$1.5k – \$3.5k', 1500, 3500),
  _PricePreset('> \$3.5k', 3500, null),
];

class SearchFilterPanel extends StatefulWidget {
  final num? initialMinPrice;
  final num? initialMaxPrice;
  final ProductSortBy? initialSortBy;
  final ProductSortOrder? initialSortOrder;
  final Function({
    num? minPrice,
    num? maxPrice,
    ProductSortBy? sortBy,
    ProductSortOrder? sortOrder,
  }) onApply;
  final VoidCallback onReset;
  final VoidCallback onHide;

  const SearchFilterPanel({
    super.key,
    this.initialMinPrice,
    this.initialMaxPrice,
    this.initialSortBy,
    this.initialSortOrder,
    required this.onApply,
    required this.onReset,
    required this.onHide,
  });

  @override
  State<SearchFilterPanel> createState() => _SearchFilterPanelState();
}

class _SearchFilterPanelState extends State<SearchFilterPanel> {
  static const double _maxSliderBound = 5000.0;

  late final TextEditingController _minPriceController;
  late final TextEditingController _maxPriceController;
  SearchSortOption? _selectedSortOption;

  double _sliderStart = 0;
  double _sliderEnd = _maxSliderBound;

  @override
  void initState() {
    super.initState();
    _minPriceController = TextEditingController(
      text: widget.initialMinPrice != null
          ? widget.initialMinPrice.toString()
          : '',
    );
    _maxPriceController = TextEditingController(
      text: widget.initialMaxPrice != null
          ? widget.initialMaxPrice.toString()
          : '',
    );

    _syncSliderFromValues(widget.initialMinPrice, widget.initialMaxPrice);

    if (widget.initialSortBy != null && widget.initialSortOrder != null) {
      for (final option in kSortOptions) {
        if (option.sortBy == widget.initialSortBy &&
            option.sortOrder == widget.initialSortOrder) {
          _selectedSortOption = option;
          break;
        }
      }
    }
  }

  void _syncSliderFromValues(num? min, num? max) {
    _sliderStart = (min?.toDouble() ?? 0).clamp(0, _maxSliderBound);
    _sliderEnd = (max?.toDouble() ?? _maxSliderBound).clamp(_sliderStart, _maxSliderBound);
  }

  @override
  void didUpdateWidget(covariant SearchFilterPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialMinPrice != oldWidget.initialMinPrice) {
      _minPriceController.text = widget.initialMinPrice != null
          ? widget.initialMinPrice.toString()
          : '';
    }
    if (widget.initialMaxPrice != oldWidget.initialMaxPrice) {
      _maxPriceController.text = widget.initialMaxPrice != null
          ? widget.initialMaxPrice.toString()
          : '';
    }
    _syncSliderFromValues(widget.initialMinPrice, widget.initialMaxPrice);

    if (widget.initialSortBy != oldWidget.initialSortBy ||
        widget.initialSortOrder != oldWidget.initialSortOrder) {
      _selectedSortOption = null;
      if (widget.initialSortBy != null && widget.initialSortOrder != null) {
        for (final option in kSortOptions) {
          if (option.sortBy == widget.initialSortBy &&
              option.sortOrder == widget.initialSortOrder) {
            _selectedSortOption = option;
            break;
          }
        }
      }
    }
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  void _onSliderChanged(RangeValues values) {
    setState(() {
      _sliderStart = values.start;
      _sliderEnd = values.end;
      _minPriceController.text =
          _sliderStart > 0 ? _sliderStart.round().toString() : '';
      _maxPriceController.text =
          _sliderEnd < _maxSliderBound ? _sliderEnd.round().toString() : '';
    });
  }

  void _applyPreset(_PricePreset preset) {
    setState(() {
      if (preset.min == null) {
        _minPriceController.clear();
        _sliderStart = 0;
      } else {
        _minPriceController.text = preset.min.toString();
        _sliderStart = preset.min!.toDouble().clamp(0, _maxSliderBound);
      }

      if (preset.max == null) {
        _maxPriceController.clear();
        _sliderEnd = _maxSliderBound;
      } else {
        _maxPriceController.text = preset.max.toString();
        _sliderEnd = preset.max!.toDouble().clamp(_sliderStart, _maxSliderBound);
      }
    });
  }

  void _handleApply() {
    final min = num.tryParse(_minPriceController.text.trim());
    final max = num.tryParse(_maxPriceController.text.trim());

    widget.onApply(
      minPrice: min,
      maxPrice: max,
      sortBy: _selectedSortOption?.sortBy,
      sortOrder: _selectedSortOption?.sortOrder,
    );
  }

  void _handleReset() {
    _minPriceController.clear();
    _maxPriceController.clear();
    setState(() {
      _sliderStart = 0;
      _sliderEnd = _maxSliderBound;
      _selectedSortOption = null;
    });
    widget.onReset();
  }

  int get _activeCount {
    int count = 0;
    if (_minPriceController.text.isNotEmpty) count++;
    if (_maxPriceController.text.isNotEmpty) count++;
    if (_selectedSortOption != null) count++;
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? ColorM.surfaceDark : ColorM.surfaceLight,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isDark
              ? ColorM.borderDark.withValues(alpha: 0.7)
              : ColorM.borderLight,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.08),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ─── Header: Luxury Atelier Title + Active Badge + Hide / Reset ───
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 14.h, 12.w, 12.h),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(7.w),
                  decoration: BoxDecoration(
                    color: ColorM.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.tune_rounded,
                    size: 17.sp,
                    color: ColorM.primary,
                  ),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'DOKKAN ATELIER',
                      style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.3,
                        color: ColorM.primary,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      children: [
                        Text(
                          'Refine & Sort',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: context.textPrimaryColor,
                            letterSpacing: -0.2,
                          ),
                        ),
                        if (_activeCount > 0) ...[
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: ColorM.primary,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Text(
                              '$_activeCount Active',
                              style: TextStyle(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                // Hide Button
                IconButton(
                  onPressed: widget.onHide,
                  tooltip: 'Hide Filters',
                  icon: Container(
                    padding: EdgeInsets.all(5.w),
                    decoration: BoxDecoration(
                      color: isDark
                          ? ColorM.surfaceDarkElevated
                          : ColorM.surfaceLightElevated,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_up_rounded,
                      size: 18.sp,
                      color: context.textSecondaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Divider(
            height: 1,
            thickness: 1,
            color: isDark
                ? ColorM.borderDark.withValues(alpha: 0.5)
                : ColorM.borderLight.withValues(alpha: 0.7),
          ),

          // Scrollable filter contents with micro animations
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ─── 1. Price Range Section ──────────────────────────────
                _buildSectionHeader(
                  title: 'Price Range',
                  icon: Icons.payments_outlined,
                  trailingText: _buildPriceRangeLabel(),
                ),
                SizedBox(height: 8.h),

                // Quick Preset Pills
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: kPricePresets.map((preset) {
                      final isSelected = _isPresetActive(preset);
                      return Padding(
                        padding: EdgeInsets.only(right: 6.w),
                        child: GestureDetector(
                          onTap: () => _applyPreset(preset),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 5.h,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? ColorM.primary.withValues(alpha: 0.15)
                                  : (isDark
                                      ? ColorM.surfaceDarkElevated
                                      : ColorM.surfaceLightElevated),
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: isSelected
                                    ? ColorM.primary
                                    : (isDark
                                        ? ColorM.borderDark.withValues(alpha: 0.6)
                                        : ColorM.borderLight),
                                width: isSelected ? 1.2 : 1,
                              ),
                            ),
                            child: Text(
                              preset.label,
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: isSelected
                                    ? ColorM.primary
                                    : context.textPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                SizedBox(height: 10.h),

                // Dual Interactive RangeSlider
                SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: ColorM.primary,
                    inactiveTrackColor: isDark
                        ? ColorM.borderDark
                        : ColorM.borderLight,
                    thumbColor: ColorM.primary,
                    overlayColor: ColorM.primary.withValues(alpha: 0.15),
                    trackHeight: 3.h,
                    rangeThumbShape: const RoundRangeSliderThumbShape(
                      enabledThumbRadius: 8,
                      elevation: 2,
                    ),
                  ),
                  child: RangeSlider(
                    values: RangeValues(_sliderStart, _sliderEnd),
                    min: 0,
                    max: _maxSliderBound,
                    divisions: 50,
                    onChanged: _onSliderChanged,
                  ),
                ),

                // Min & Max Price Input Boxes
                Row(
                  children: [
                    Expanded(
                      child: _buildPriceBox(
                        label: 'MIN',
                        controller: _minPriceController,
                        hint: '0',
                        isDark: isDark,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                        'to',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: context.textSecondaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: _buildPriceBox(
                        label: 'MAX',
                        controller: _maxPriceController,
                        hint: '5,000+',
                        isDark: isDark,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 18.h),

                // ─── 2. Sorting Refinements Section ─────────────────────
                _buildSectionHeader(
                  title: 'Sort By',
                  icon: Icons.swap_vert_rounded,
                  trailingText: _selectedSortOption?.label,
                ),
                SizedBox(height: 10.h),

                // Selection Cards for 3 curated sort options
                Column(
                  children: kSortOptions.map((option) {
                    final isSelected = _selectedSortOption == option;

                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedSortOption = isSelected ? null : option;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeOutCubic,
                          height: 48.h,
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? ColorM.primary.withValues(alpha: 0.12)
                                : (isDark
                                    ? ColorM.surfaceDarkElevated
                                    : ColorM.surfaceLightElevated),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: isSelected
                                  ? ColorM.primary
                                  : (isDark
                                      ? ColorM.borderDark.withValues(alpha: 0.5)
                                      : ColorM.borderLight),
                              width: isSelected ? 1.4 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(6.w),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? ColorM.primary
                                      : (isDark
                                          ? ColorM.surfaceDarkSubtle
                                          : Colors.white),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  option.icon,
                                  size: 15.sp,
                                  color: isSelected
                                      ? Colors.white
                                      : context.textPrimaryColor,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      option.label,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: isSelected
                                            ? FontWeight.w700
                                            : FontWeight.w600,
                                        color: isSelected
                                            ? ColorM.primary
                                            : context.textPrimaryColor,
                                      ),
                                    ),
                                    Text(
                                      option.subtitle,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: context.textSecondaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                isSelected
                                    ? Icons.radio_button_checked_rounded
                                    : Icons.radio_button_unchecked_rounded,
                                size: 18.sp,
                                color: isSelected
                                    ? ColorM.primary
                                    : context.textSecondaryColor
                                        .withValues(alpha: 0.5),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                SizedBox(height: 18.h),

                // ─── 3. Action Buttons: Reset & Apply ────────────────────
                Row(
                  children: [
                    // Reset Button
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 44.h,
                        child: OutlinedButton(
                          onPressed: _handleReset,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: isDark
                                  ? ColorM.borderDark
                                  : ColorM.borderLight,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            foregroundColor: context.textSecondaryColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.restart_alt_rounded,
                                size: 15.sp,
                                color: context.textSecondaryColor,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'Reset',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    // Apply Filters Button
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 44.h,
                        child: ElevatedButton(
                          onPressed: _handleApply,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorM.primary,
                            foregroundColor: Colors.white,
                            elevation: 2,
                            shadowColor: ColorM.primary.withValues(alpha: 0.35),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Apply Filters',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.2,
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Icon(
                                Icons.arrow_forward_rounded,
                                size: 15.sp,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 250.ms)
        .slideY(begin: -0.04, end: 0, curve: Curves.easeOutCubic);
  }

  Widget _buildSectionHeader({
    required String title,
    required IconData icon,
    String? trailingText,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 15.sp,
          color: ColorM.primary,
        ),
        SizedBox(width: 6.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: context.textPrimaryColor,
          ),
        ),
        const Spacer(),
        if (trailingText != null && trailingText.isNotEmpty)
          Text(
            trailingText,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: ColorM.primary,
            ),
          ),
      ],
    );
  }

  String _buildPriceRangeLabel() {
    final min = _minPriceController.text.trim();
    final max = _maxPriceController.text.trim();
    if (min.isEmpty && max.isEmpty) return 'All Prices';
    if (min.isNotEmpty && max.isEmpty) return 'From \$$min';
    if (min.isEmpty && max.isNotEmpty) return 'Up to \$$max';
    return '\$$min – \$$max';
  }

  bool _isPresetActive(_PricePreset preset) {
    final currentMin = num.tryParse(_minPriceController.text.trim());
    final currentMax = num.tryParse(_maxPriceController.text.trim());
    return currentMin == preset.min && currentMax == preset.max;
  }

  Widget _buildPriceBox({
    required String label,
    required TextEditingController controller,
    required String hint,
    required bool isDark,
  }) {
    return Container(
      height: 44.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: isDark ? ColorM.surfaceDarkElevated : ColorM.surfaceLightElevated,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark
              ? ColorM.borderDark.withValues(alpha: 0.5)
              : ColorM.borderLight,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: ColorM.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 9.sp,
                fontWeight: FontWeight.w700,
                color: ColorM.primary,
              ),
            ),
          ),
          SizedBox(width: 6.w),
          Text(
            '\$',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: context.textSecondaryColor,
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              onChanged: (_) {
                final min = num.tryParse(_minPriceController.text.trim());
                final max = num.tryParse(_maxPriceController.text.trim());
                setState(() {
                  _syncSliderFromValues(min, max);
                });
              },
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: context.textPrimaryColor,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  fontSize: 12.sp,
                  color: context.textSecondaryColor.withValues(alpha: 0.7),
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                filled: false,
                fillColor: Colors.transparent,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
