import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/widgets/refresh/customized_smart_refresh.dart';
import '../cubit/profile_cubit.dart';
import '../widgets/profile_header_card.dart';
import '../widgets/profile_header_shimmer.dart';
import '../widgets/profile_tiles_list.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<ProfileCubit>();

    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomizedSmartRefresh(
          controller: cubit.refreshController,
          onRefresh: () => cubit.fetchProfile(isRefresh: true),
          enableRefresh: true,
          enableLoading: false,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverPadding(
                padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
                sliver: SliverToBoxAdapter(
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
                      const _ProfileHeaderSection(),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 16.h),
                sliver: const ProfileTilesList(),
              ),
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

class _ProfileHeaderSection extends StatelessWidget {
  const _ProfileHeaderSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return switch (state) {
          ProfileInitial() || ProfileLoading() => Column(
            children: [
              const ProfileHeaderShimmer(),
              16.verticalSpace,
            ],
          ),
          ProfileSuccess(:final user) => Column(
            children: [
              ProfileHeaderCard(
                name: user.fullName,
                email: user.email,
                profilePicture: user.profilePicture,
              ),
              16.verticalSpace,
            ],
          ),
          ProfileFailure() => const SizedBox.shrink(),
        };
      },
    );
  }
}
