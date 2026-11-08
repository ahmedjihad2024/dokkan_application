import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../domain/models/branch_model.dart';
import 'branch_card.dart';

class BranchesSection extends StatelessWidget {
  final List<BranchModel> branches;

  const BranchesSection({
    super.key,
    this.branches = BranchModel.defaultBranches,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.storefront_outlined,
              size: 20.r,
              color: context.colorScheme.primary,
            ),
            Gap(8.w),
            Text(
              'Our Boutiques & Branches',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: context.textPrimaryColor,
              ),
            ),
            const Spacer(),
            Text(
              '${branches.length} Locations',
              style: TextStyle(
                fontSize: 12.sp,
                color: context.textMutedColor,
              ),
            ),
          ],
        ),
        Gap(12.h),
        ...branches.asMap().entries.map(
          (entry) {
            final index = entry.key;
            final branch = entry.value;
            return BranchCard(branch: branch)
                .animate(delay: (200 + index * 60).ms)
                .fadeIn(duration: 400.ms, curve: Curves.easeOutCubic)
                .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic);
          },
        ),
      ],
    );
  }
}

