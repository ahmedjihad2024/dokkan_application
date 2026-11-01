import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/cards/surface_card.dart';
import 'info_card.dart';

class PrivacyPolicySectionCard extends StatelessWidget {
  const PrivacyPolicySectionCard({
    super.key,
    required this.index,
    required this.title,
    required this.description,
  });

  final int index;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      padding: EdgeInsets.all(16.r),
      child: InfoCard(
        title: '$index. $title',
        description: description,
      ),
    );
  }
}

