import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';

class ChangePasswordHeader extends StatelessWidget {
  const ChangePasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Choose a strong password containing at least 8 characters, numbers, and special symbols.',
      style: TextStyle(
        fontSize: 12.sp,
        color: context.textSecondaryColor,
        height: 1.4,
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: 60.ms)
        .slideY(
          begin: 0.08,
          end: 0,
          duration: 400.ms,
          curve: Curves.easeOutCubic,
        );
  }
}
