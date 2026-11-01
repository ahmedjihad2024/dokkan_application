import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../data/models/payment_method_model.dart';

class PaymentOptionCard extends StatelessWidget {
  final PaymentMethodModel method;
  final bool isSelected;
  final VoidCallback onSelect;

  const PaymentOptionCard({
    super.key,
    required this.method,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected ? ColorM.primaryDark : context.borderColor;
    final borderWidth = isSelected ? 1.5 : 1.0;

    return InkWell(
      onTap: onSelect,
      borderRadius: BorderRadius.circular(16.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: borderColor, width: borderWidth),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: ColorM.primaryDark.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Radio Indicator
            Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? ColorM.primaryDark
                        : context.textSecondaryColor,
                    width: 1.5,
                  ),
                  color: isSelected ? ColorM.primaryDark : Colors.transparent,
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 8.w,
                          height: 8.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : null,
              ),
            ),
            12.horizontalSpace,

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method.title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: context.textPrimaryColor,
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    method.subtitle,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: context.textSecondaryColor,
                      height: 1.35,
                    ),
                  ),

                  // Optional Badges row (Visa, Mastercard, Meeza)
                  if (method.badges.isNotEmpty) ...[
                    10.verticalSpace,
                    Wrap(
                      spacing: 6.w,
                      children: method.badges.map((badge) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: context.surfaceElevatedColor,
                            borderRadius: BorderRadius.circular(4.r),
                            border: Border.all(color: context.borderColor),
                          ),
                          child: Text(
                            badge,
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              color: context.textPrimaryColor,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

