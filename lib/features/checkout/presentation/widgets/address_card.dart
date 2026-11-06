import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../domain/model/address_entity.dart';

class AddressCard extends StatelessWidget {
  final AddressModel address;
  final bool isSelected;
  final bool isDeleting;
  final VoidCallback onSelect;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const AddressCard({
    super.key,
    required this.address,
    required this.isSelected,
    this.isDeleting = false,
    required this.onSelect,
    required this.onEdit,
    required this.onDelete,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Radio, Optional Default Badge, and Edit/Delete Actions
            Row(
              children: [
                // Radio indicator
                Container(
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

                if (address.isDefault) ...[
                  10.horizontalSpace,
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 3.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorM.success.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      'DEFAULT',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorM.success,
                      ),
                    ),
                  ),
                ],

                const Spacer(),

                // Edit Button
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_outlined),
                  iconSize: 18.sp,
                  color: context.textSecondaryColor,
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  tooltip: 'Edit Address',
                ),
                12.horizontalSpace,

                // Delete Button
                if (isDeleting)
                  SizedBox(
                    width: 22.sp,
                    height: 22.sp,
                    child: Padding(
                      padding: EdgeInsets.all(3.r),
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: ColorM.danger,
                      ),
                    ),
                  )
                else
                  IconButton(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete_outline_rounded),
                    iconSize: 18.sp,
                    color: ColorM.danger,
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    tooltip: 'Delete Address',
                  ),
              ],
            ),
            12.verticalSpace,

            // Street & Apartment
            Text(
              '${address.street}, ${address.apartment}',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: context.textPrimaryColor,
              ),
            ),
            4.verticalSpace,

            // City & State
            Text(
              '${address.city}, ${address.state}',
              style: TextStyle(
                fontSize: 12.sp,
                color: context.textSecondaryColor,
              ),
            ),
            8.verticalSpace,

            // Phone
            Row(
              children: [
                Icon(
                  Icons.phone_outlined,
                  size: 13.sp,
                  color: context.textSecondaryColor,
                ),
                6.horizontalSpace,
                Text(
                  address.phoneNumber,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: context.textPrimaryColor,
                  ),
                ),
              ],
            ),

            // Optional delivery notes
            if (address.deliveryNotes != null &&
                address.deliveryNotes!.isNotEmpty) ...[
              6.verticalSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.note_alt_outlined,
                    size: 13.sp,
                    color: context.textSecondaryColor,
                  ),
                  6.horizontalSpace,
                  Expanded(
                    child: Text(
                      address.deliveryNotes!,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: context.textSecondaryColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
