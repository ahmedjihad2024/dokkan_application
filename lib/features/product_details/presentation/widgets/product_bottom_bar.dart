import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';

class ProductBottomBar extends StatelessWidget {
  final int quantity;
  final double totalPrice;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onAddToCart;
  final bool isLoading;

  const ProductBottomBar({
    super.key,
    required this.quantity,
    required this.totalPrice,
    required this.onIncrement,
    required this.onDecrement,
    required this.onAddToCart,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final barBg = context.isDark ? context.surfaceSubtleColor : ColorM.white;
    final barBorder = context.borderColor;
    final qtyBg = context.surfaceElevatedColor;
    final textColor = context.textPrimaryColor;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: barBg,
        border: Border(
          top: BorderSide(color: barBorder, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: context.isDark ? 0.3 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          child: Row(
            children: [
              // Quantity Selector (104x48, radius 14) matching Figma 37:557 / 37:617
              Container(
                width: 104.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: qtyBg,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Minus button
                    InkWell(
                      onTap: isLoading ? null : onDecrement,
                      borderRadius: BorderRadius.circular(8.r),
                      child: Container(
                        width: 32.w,
                        height: 36.h,
                        alignment: Alignment.center,
                        child: Text(
                          '−',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                        ),
                      ),
                    ),

                    // Current Quantity Number
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 150),
                      transitionBuilder: (child, animation) =>
                          ScaleTransition(scale: animation, child: child),
                      child: Text(
                        '$quantity',
                        key: ValueKey('qty_$quantity'),
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                    ),

                    // Plus button
                    InkWell(
                      onTap: isLoading ? null : onIncrement,
                      borderRadius: BorderRadius.circular(8.r),
                      child: Container(
                        width: 32.w,
                        height: 36.h,
                        alignment: Alignment.center,
                        child: Text(
                          '+',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 12.w),

              // Add to Bag Button (226x48, radius 14) matching Figma 37:561 / 37:621
              Expanded(
                child: SizedBox(
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : onAddToCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorM.primaryDark,
                      foregroundColor: ColorM.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: isLoading
                        ? SizedBox(
                            width: 22.r,
                            height: 22.r,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(ColorM.white),
                            ),
                          )
                        : Text(
                            'Add to Bag • \$${totalPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: ColorM.white,
                              letterSpacing: -0.2,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
