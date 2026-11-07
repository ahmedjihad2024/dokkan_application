import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/sizes_manager.dart';
import '../../../../core/widgets/feedback/custom_snackbar.dart';
import '../../domain/models/contact_channel_model.dart';

class ContactInfoCard extends StatelessWidget {
  final ContactChannelModel channel;

  const ContactInfoCard({
    super.key,
    required this.channel,
  });

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: channel.value));
    CustomSnackBar.showSuccess(
      context,
      'Copied to clipboard: ${channel.value}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(SizeM.inputBorderRadius.r),
        border: Border.all(color: context.borderColor),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: context.surfaceElevatedColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              channel.icon,
              color: context.colorScheme.primary,
              size: 22.r,
            ),
          ),
          Gap(14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  channel.title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: context.textMutedColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(2.h),
                Text(
                  channel.value,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: context.textPrimaryColor,
                  ),
                ),
                Gap(2.h),
                Text(
                  channel.hint,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: context.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _copyToClipboard(context),
            icon: Icon(
              Icons.copy_rounded,
              size: 18.r,
              color: context.textSecondaryColor,
            ),
            tooltip: 'Copy',
          ),
        ],
      ),
    );
  }
}

