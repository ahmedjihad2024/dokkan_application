import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart' as sk;

import '../../../../core/enums/request_state.dart';
import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../domain/model/address_entity.dart';
import 'address_card.dart';
import 'address_empty_view.dart';
import 'address_error_view.dart';
import 'address_skeleton_card.dart';

class StepSelectAddress extends StatelessWidget {
  final ReqState status;
  final String? errorMessage;
  final List<AddressModel> addresses;
  final String? selectedAddressId;
  final String? deletingAddressId;
  final ValueChanged<String> onSelectAddress;
  final ValueChanged<AddressModel> onEditAddress;
  final ValueChanged<AddressModel> onDeleteAddress;
  final VoidCallback onAddNewAddress;
  final VoidCallback onRetry;

  const StepSelectAddress({
    super.key,
    required this.status,
    this.errorMessage,
    required this.addresses,
    required this.selectedAddressId,
    this.deletingAddressId,
    required this.onSelectAddress,
    required this.onEditAddress,
    required this.onDeleteAddress,
    required this.onAddNewAddress,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (status == ReqState.loading) {
      final isDark = context.isDark;
      return sk.Skeletonizer(
        enabled: true,
        effect: sk.ShimmerEffect(
          baseColor: isDark
              ? const Color(0xFF1F2937)
              : const Color(0xFFE2E8F0),
          highlightColor: isDark
              ? const Color(0xFF374151)
              : const Color(0xFFF1F5F9),
          duration: const Duration(milliseconds: 1400),
        ),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: const AddressSkeletonCard(),
            );
          },
        ),
      );
    }

    if (status == ReqState.failure) {
      return AddressErrorView(
        errorMessage: errorMessage,
        onRetry: onRetry,
      );
    }

    if (addresses.isEmpty) {
      return AddressEmptyView(onAddAddress: onAddNewAddress);
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      itemCount: addresses.length + 2,
      itemBuilder: (context, index) {
        // 1. Header showing count of saved addresses
        if (index == 0) {
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Text(
              'Saved Delivery Addresses (${addresses.length})',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: context.textPrimaryColor,
              ),
            ),
          );
        }

        // 2. Add New Address Button as footer
        if (index == addresses.length + 1) {
          return Padding(
            padding: EdgeInsets.only(top: 8.h, bottom: 24.h),
            child: InkWell(
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
          );
        }

        // 3. Address items (index 1 to addresses.length)
        final addressIndex = index - 1;
        final address = addresses[addressIndex];
        final isSelected = address.id == selectedAddressId;
        final isDeleting = address.id == deletingAddressId;

        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: AddressCard(
            address: address,
            isSelected: isSelected,
            isDeleting: isDeleting,
            onSelect: () => onSelectAddress(address.id),
            onEdit: () => onEditAddress(address),
            onDelete: isDeleting ? () {} : () => onDeleteAddress(address),
          )
              .animate(delay: (addressIndex * 60).ms)
              .fadeIn(duration: 380.ms, curve: Curves.easeOutCubic)
              .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic),
        );
      },
    );
  }
}
