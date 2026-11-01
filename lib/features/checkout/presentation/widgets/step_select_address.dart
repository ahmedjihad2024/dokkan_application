import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/enums/request_state.dart';
import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../data/models/address_model.dart';
import 'address_card.dart';
import 'address_empty_view.dart';
import 'address_error_view.dart';
import 'address_skeleton_card.dart';

class StepSelectAddress extends StatelessWidget {
  final ReqState status;
  final List<AddressModel> addresses;
  final String? selectedAddressId;
  final ValueChanged<String> onSelectAddress;
  final ValueChanged<AddressModel> onEditAddress;
  final ValueChanged<AddressModel> onDeleteAddress;
  final VoidCallback onAddNewAddress;
  final VoidCallback onRetry;

  const StepSelectAddress({
    super.key,
    required this.status,
    required this.addresses,
    required this.selectedAddressId,
    required this.onSelectAddress,
    required this.onEditAddress,
    required this.onDeleteAddress,
    required this.onAddNewAddress,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (status == ReqState.loading) {
      return ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
        children: [
          const AddressSkeletonCard(),
          12.verticalSpace,
          const AddressSkeletonCard(),
          12.verticalSpace,
          const AddressSkeletonCard(),
        ],
      );
    }

    if (status == ReqState.failure) {
      return AddressErrorView(onRetry: onRetry);
    }

    if (addresses.isEmpty) {
      return AddressEmptyView(onAddAddress: onAddNewAddress);
    }

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Text(
            'Saved Delivery Addresses (${addresses.length})',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
          ),
        ),
        ...List.generate(addresses.length, (index) {
          final address = addresses[index];
          final isSelected = address.id == selectedAddressId;

          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: AddressCard(
              address: address,
              isSelected: isSelected,
              onSelect: () => onSelectAddress(address.id),
              onEdit: () => onEditAddress(address),
              onDelete: () => onDeleteAddress(address),
            )
                .animate(delay: (index * 60).ms)
                .fadeIn(duration: 380.ms, curve: Curves.easeOutCubic)
                .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic),
          );
        }),
        8.verticalSpace,
        InkWell(
          onTap: onAddNewAddress,
          borderRadius: BorderRadius.circular(14.r),
          child: Container(
            width: double.infinity,
            height: 48.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.surfaceColor,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: ColorM.primaryDark,
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_rounded,
                  color: ColorM.primaryDark,
                  size: 20.sp,
                ),
                6.horizontalSpace,
                Text(
                  'Add New Address',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorM.primaryDark,
                  ),
                ),
              ],
            ),
          ),
        )
            .animate()
            .fadeIn(duration: 400.ms, delay: 140.ms)
            .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic),
        24.verticalSpace,
      ],
    );
  }
}

