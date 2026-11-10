import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../widgets/profile_header_card.dart';
import '../widgets/profile_tiles_list.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Account & Profile',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: context.textPrimaryColor,
                ),
              ),
              20.verticalSpace,
              const ProfileHeaderCard(
                name: 'Alexander Mansour',
                email: 'alexander.mansour@atelier.com',
              ),
              16.verticalSpace,
              const ProfileTilesList(),
            ],
          ),
        )
            .animate()
            .fadeIn(duration: 380.ms, curve: Curves.easeOutCubic)
            .slideY(begin: 0.04, end: 0, curve: Curves.easeOutCubic),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
