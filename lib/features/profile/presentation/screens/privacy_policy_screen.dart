import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/widgets/cards/surface_card.dart';
import '../widgets/info_card.dart';
import '../widgets/profile_settings_appbar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> privacySections = [
      {
        'title': 'Information Collection',
        'description':
            'We only collect data necessary to fulfill bespoke orders, process encrypted payments, and coordinate insured shipping for your accessories.',
      },
      {
        'title': 'Payment Tokenization',
        'description':
            'All credit card and banking credentials are tokenized via certified PCI-DSS Level 1 payment gateways. Dokkan never stores raw card credentials.',
      },
      {
        'title': 'No Third-Party Resale',
        'description':
            'Your identity, delivery addresses, and purchasing patterns will never be sold, leased, or distributed to advertising data brokers.',
      },
      {
        'title': 'Your Privacy Rights',
        'description':
            'You maintain full rights to inspect, update, or permanently erase your profile and purchase logs by submitting a request to legal@dokkan.com.',
      },
    ];

    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: ProfileSettingsAppBar(
        onBack: () => Navigator.of(context).pop(),
        title: 'Privacy Policy',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Last updated: October 2026 • Dokkan Atelier respects your confidentiality and personal data rights.',
              style: TextStyle(
                fontSize: 12.sp,
                color: context.textSecondaryColor,
                height: 1.4,
              ),
            ),

            SizedBox(height: 20.h),

            ListView.separated(
              itemCount: privacySections.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                return SurfaceCard(
                  padding: EdgeInsets.all(16.r),
                  child: InfoCard(
                    title:
                        '${index + 1}. ${privacySections[index]['title']}',
                    description: privacySections[index]['description']!,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
