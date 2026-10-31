import 'package:dokkan/core/res/color_manager.dart';
import 'package:dokkan/core/res/sizes_manager.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ContactInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String footer;

  const ContactInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorM.backgroundLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorM.cardBackground),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ColorM.primary200,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: ColorM.primary400, size: SizeM.pagePaddingLarge),
          ),
          Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: SizeM.elementSpacing,
                    color: ColorM.textMutedLight,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: SizeM.commonBorderRadius,
                    fontWeight: FontWeight.bold,
                    color: ColorM.surfaceDark,
                  ),
                ),
                Gap(2),
                Text(
                  footer,
                  style: TextStyle(
                    fontSize: SizeM.elementSpacing,
                    color: ColorM.borderDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}