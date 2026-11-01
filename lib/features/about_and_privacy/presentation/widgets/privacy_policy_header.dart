import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';

class PrivacyPolicyHeader extends StatelessWidget {
  const PrivacyPolicyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Last updated: October 2026 • Dokkan Atelier respects your confidentiality and personal data rights.',
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
