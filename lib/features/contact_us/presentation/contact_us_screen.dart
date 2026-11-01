import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/navigation_extension.dart';
import '../../../core/extensions/theme_extensions.dart';
import '../../../core/res/sizes_manager.dart';
import '../widgets/contactInfoCard.dart';
import '../widgets/directAtelierInquiryWidget.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(8.r),
          child: IconButton(
            style: IconButton.styleFrom(
              backgroundColor: context.surfaceColor,
              shape: const CircleBorder(),
            ),
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        title: const Text('Contact Us'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 8.h,
          left: SizeM.pagePaddingLarge.w,
          right: SizeM.pagePaddingLarge.w,
          bottom: 24.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 14.h),
              child: Text(
                'Our atelier advisors are available 7 days a week for bespoke consultations and order assistance.',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: context.textSecondaryColor,
                ),
              ),
            )
                .animate()
                .fadeIn(duration: 400.ms)
                .slideX(begin: -0.06, end: 0, curve: Curves.easeOutCubic),

            const ContactInfoCard(
              icon: Icons.mail_outline,
              title: 'Concierge Email',
              subtitle: 'concierge@dokkan-atelier.com',
              footer: 'Replies within 2 hours',
            )
                .animate(delay: 80.ms)
                .fadeIn(duration: 400.ms, curve: Curves.easeOutCubic)
                .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic)
                .scale(
                  begin: const Offset(0.98, 0.98),
                  end: const Offset(1, 1),
                  curve: Curves.easeOutCubic,
                ),
            12.verticalSpace,

            const ContactInfoCard(
              icon: Icons.phone_outlined,
              title: 'Atelier Hotline',
              subtitle: '+971 4 800 DOKKAN',
              footer: 'Mon-Sat 8AM-8PM GST',
            )
                .animate(delay: 140.ms)
                .fadeIn(duration: 400.ms, curve: Curves.easeOutCubic)
                .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic)
                .scale(
                  begin: const Offset(0.98, 0.98),
                  end: const Offset(1, 1),
                  curve: Curves.easeOutCubic,
                ),
            12.verticalSpace,

            const ContactInfoCard(
              icon: Icons.location_on_outlined,
              title: 'Flagship Boutique',
              subtitle: 'Atelier 42, Design District, Dubai',
              footer: 'Private viewings by booking',
            )
                .animate(delay: 200.ms)
                .fadeIn(duration: 400.ms, curve: Curves.easeOutCubic)
                .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic)
                .scale(
                  begin: const Offset(0.98, 0.98),
                  end: const Offset(1, 1),
                  curve: Curves.easeOutCubic,
                ),
            20.verticalSpace,

            const DirectAtelierInquiryWidget()
                .animate(delay: 260.ms)
                .fadeIn(duration: 450.ms, curve: Curves.easeOutCubic)
                .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic),
          ],
        ),
      ),
    );
  }
}
