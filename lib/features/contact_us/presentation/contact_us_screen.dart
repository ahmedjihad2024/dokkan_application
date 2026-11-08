import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../core/extensions/navigation_extension.dart';
import '../../../core/extensions/theme_extensions.dart';
import '../../../core/res/sizes_manager.dart';
import '../domain/models/contact_channel_model.dart';
import 'widgets/branches_section.dart';
import 'widgets/contact_header_banner.dart';
import 'widgets/contact_info_card.dart';
import 'widgets/direct_atelier_inquiry_widget.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.surfaceColor,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.r),
          child: IconButton(
            style: IconButton.styleFrom(
              backgroundColor: context.surfaceElevatedColor,
              shape: const CircleBorder(),
            ),
            onPressed: () => context.pop(),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18.sp,
              color: context.textPrimaryColor,
            ),
          ),
        ),
        title: Text(
          'Contact Us',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: context.textPrimaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: SizeM.pagePaddingLarge.w,
            vertical: 16.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ContactHeaderBanner()
                  .animate()
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: -0.06, end: 0, curve: Curves.easeOutCubic),
              Gap(20.h),
              Text(
                'Customer Support Channels',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: context.textPrimaryColor,
                ),
              ),
              Gap(10.h),
              ...ContactChannelModel.defaultChannels.asMap().entries.map(
                (entry) {
                  final index = entry.key;
                  final channel = entry.value;
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: ContactInfoCard(channel: channel)
                        .animate(delay: (80 + index * 50).ms)
                        .fadeIn(duration: 400.ms, curve: Curves.easeOutCubic)
                        .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic),
                  );
                },
              ),
              Gap(16.h),
              const BranchesSection(),
              Gap(16.h),
              const DirectAtelierInquiryWidget()
                  .animate(delay: 350.ms)
                  .fadeIn(duration: 450.ms, curve: Curves.easeOutCubic)
                  .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic),
              Gap(24.h),
            ],
          ),
        ),
      ),
    );
  }
}
