import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String? description;
  final IconData? icon;
  final double? titleFontSize;
  final double? descriptionFontSize;

  const InfoCard({
    super.key,
    required this.title,
    this.description,
    this.icon,
    this.titleFontSize,
    this.descriptionFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 24.sp, color: context.colorScheme.primary),
          10.verticalSpace,
        ],
        Text(
          title,
          style: TextStyle(
            fontSize: titleFontSize ?? 16.sp,
            fontWeight: FontWeight.bold,
            color: context.textPrimaryColor,
          ),
        ),
        8.verticalSpace,
        Text(
          description ?? '',
          style: TextStyle(
            fontSize: descriptionFontSize ?? 13.sp,
            color: context.textSecondaryColor,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

