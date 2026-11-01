import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/cards/surface_card.dart';
import 'info_card.dart';

class AboutHeritageCard extends StatelessWidget {
  const AboutHeritageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      padding: EdgeInsets.all(16.r),
      child: const InfoCard(
        title: 'Our Heritage & Philosophy',
        description:
            'Dokkan was founded with a devotion to artisanal authenticity. We unite heritage leatherwork, surgical precision timepieces, and fine precious metals to create accessories made to endure for generations.',
      ),
    );
  }
}

