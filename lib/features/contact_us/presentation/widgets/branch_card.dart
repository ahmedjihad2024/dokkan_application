import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/sizes_manager.dart';
import '../../../../core/widgets/feedback/custom_snackbar.dart';
import '../../domain/models/branch_model.dart';

class BranchCard extends StatelessWidget {
  final BranchModel branch;

  const BranchCard({
    super.key,
    required this.branch,
  });

  void _copy(BuildContext context, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    CustomSnackBar.showSuccess(context, '$label copied to clipboard');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(SizeM.cardBorderRadius.r),
        border: Border.all(
          color: branch.isFlagship
              ? context.colorScheme.primary.withValues(alpha: 0.4)
              : context.borderColor,
          width: branch.isFlagship ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  branch.name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: context.textPrimaryColor,
                  ),
                ),
              ),
              if (branch.isFlagship)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 3.h,
                  ),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    'FLAGSHIP',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w800,
                      color: context.colorScheme.primary,
                      letterSpacing: 0.5,
                    ),
                  ),
                )
              else
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 3.h,
                  ),
                  decoration: BoxDecoration(
                    color: context.surfaceElevatedColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    branch.city,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: context.textSecondaryColor,
                    ),
                  ),
                ),
            ],
          ),
          Gap(10.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 16.r,
                color: context.colorScheme.primary,
              ),
              Gap(8.w),
              Expanded(
                child: Text(
                  branch.address,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: context.textSecondaryColor,
                    height: 1.3,
                  ),
                ),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () => _copy(context, branch.address, 'Address'),
                icon: Icon(
                  Icons.copy_rounded,
                  size: 15.r,
                  color: context.textMutedColor,
                ),
                tooltip: 'Copy address',
              ),
            ],
          ),
          Gap(6.h),
          Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 16.r,
                color: context.textMutedColor,
              ),
              Gap(8.w),
              Expanded(
                child: Text(
                  branch.workingHours,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: context.textMutedColor,
                  ),
                ),
              ),
            ],
          ),
          Gap(6.h),
          Row(
            children: [
              Icon(
                Icons.phone_outlined,
                size: 16.r,
                color: context.textMutedColor,
              ),
              Gap(8.w),
              Expanded(
                child: Text(
                  branch.phone,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimaryColor,
                  ),
                ),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () => _copy(context, branch.phone, 'Phone'),
                icon: Icon(
                  Icons.copy_rounded,
                  size: 15.r,
                  color: context.textMutedColor,
                ),
                tooltip: 'Copy phone',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

