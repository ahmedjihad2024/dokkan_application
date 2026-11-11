import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../core/widgets/cards/surface_card.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';

class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({super.key});

  String _getInitials(String name) {
    if (name.trim().isEmpty) return 'U';
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state == ThemeMode.dark;
    final cubit = context.read<ProfileCubit>();

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoadingState && cubit.currentUser == null) {
          return SurfaceCard(
            padding: EdgeInsets.all(16.r),
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        final user =
            cubit.currentUser ??
            (state is ProfileSuccessState ? state.user : null);

        final userName = (user?.fullName.isNotEmpty == true)
            ? user!.fullName
            : (user?.fullName.isNotEmpty == true ? user!.fullName : 'User');

        final userEmail = user?.email ?? '';
        final avatarUrl = user?.profilePicture ?? user?.profilePicture;
        final selectedImage = cubit.selectedImage;

        return SurfaceCard(
          padding: EdgeInsets.all(16.r),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => cubit.pickProfileImage(),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 28.r,
                      backgroundColor: context.colorScheme.primary.withAlpha(
                        30,
                      ),
                      backgroundImage: selectedImage != null
                          ? FileImage(selectedImage)
                          : (avatarUrl != null && avatarUrl.isNotEmpty
                                    ? NetworkImage(avatarUrl)
                                    : null)
                                as ImageProvider?,
                      child:
                          (selectedImage == null &&
                              (avatarUrl == null || avatarUrl.isEmpty))
                          ? Text(
                              _getInitials(userName),
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: context.colorScheme.primary,
                              ),
                            )
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(3.r),
                        decoration: BoxDecoration(
                          color: context.colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          size: 11.sp,
                          color: ColorM.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              14.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: context.textPrimaryColor,
                      ),
                    ),
                    if (userEmail.isNotEmpty) ...[
                      2.verticalSpace,
                      Text(
                        userEmail,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: context.textSecondaryColor,
                        ),
                      ),
                    ],
                    6.verticalSpace,
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? ColorM.successContainerDark
                            : ColorM.successContainerLight,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6.r,
                            height: 6.r,
                            decoration: const BoxDecoration(
                              color: ColorM.success,
                              shape: BoxShape.circle,
                            ),
                          ),
                          4.horizontalSpace,
                          Text(
                            'Atelier Club',
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: ColorM.success,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
