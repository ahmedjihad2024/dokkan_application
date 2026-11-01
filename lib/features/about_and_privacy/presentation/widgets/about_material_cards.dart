import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/cards/surface_card.dart';
import 'info_card.dart';

class AboutMaterialCards extends StatelessWidget {
  const AboutMaterialCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SurfaceCard(
            padding: EdgeInsets.all(16.r),
            child: InfoCard(
              icon: Icons.verified_user_outlined,
              title: '316L Surgical Steel',
              description: 'Corrosion-proof luxury',
              titleFontSize: 14.sp,
              descriptionFontSize: 11.sp,
            ),
          ),
        ),
        12.horizontalSpace,
        Expanded(
          child: SurfaceCard(
            padding: EdgeInsets.all(16.r),
            child: InfoCard(
              icon: Icons.shopping_bag_outlined,
              title: 'Italian Calfskin',
              description: 'Handcrafted patina',
              titleFontSize: 14.sp,
              descriptionFontSize: 11.sp,
            ),
          ),
        ),
      ],
    );
  }
}

