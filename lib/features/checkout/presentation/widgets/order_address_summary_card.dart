import 'package:dokkan/features/checkout/domain/model/address_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';

class OrderAddressSummaryCard extends StatelessWidget {
  final AddressModel address;
  final VoidCallback onChange;

  const OrderAddressSummaryCard({
    super.key,
    required this.address,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: context.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 18.sp,
                color: ColorM.primaryDark,
              ),
              8.horizontalSpace,
              Text(
                'Delivery Address',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: context.textPrimaryColor,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: onChange,
                child: Text(
                  'Change',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorM.primaryDark,
                  ),
                ),
              ),
            ],
          ),
          10.verticalSpace,
          Text(
            '${address.street}, ${address.apartment}',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: context.textPrimaryColor,
            ),
          ),
          2.verticalSpace,
          Text(
            '${address.city}, ${address.state} • ${address.phoneNumber}',
            style: TextStyle(
              fontSize: 11.sp,
              color: context.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

