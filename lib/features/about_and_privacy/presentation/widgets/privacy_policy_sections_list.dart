import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'privacy_policy_section_card.dart';

class PrivacyPolicySectionsList extends StatelessWidget {
  const PrivacyPolicySectionsList({super.key});

  static const List<Map<String, String>> _privacySections = [
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

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _privacySections.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => 16.verticalSpace,
      itemBuilder: (context, index) {
        final section = _privacySections[index];
        return PrivacyPolicySectionCard(
          index: index + 1,
          title: section['title']!,
          description: section['description']!,
        )
            .animate(delay: (120 + (index * 60)).ms)
            .fadeIn(
              duration: 400.ms,
              curve: Curves.easeOutCubic,
            )
            .slideY(
              begin: 0.08,
              end: 0,
              duration: 400.ms,
              curve: Curves.easeOutCubic,
            )
            .scale(
              begin: const Offset(0.98, 0.98),
              end: const Offset(1, 1),
              duration: 400.ms,
              curve: Curves.easeOutCubic,
            );
      },
    );
  }
}
