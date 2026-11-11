import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../core/widgets/cards/surface_card.dart';
import '../../../../core/widgets/images/custom_cached_image.dart';

class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({
    super.key,
    required this.name,
    required this.email,
    this.profilePicture,
  });

  final String name;
  final String email;
  final String? profilePicture;

  String get _initials {
    final parts =
        name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state == ThemeMode.dark;
    final trimmedAvatar = profilePicture?.trim();
    final hasAvatar = trimmedAvatar != null && trimmedAvatar.isNotEmpty;

    final initialsAvatar = CircleAvatar(
      radius: 28.r,
      backgroundColor: context.colorScheme.primary.withAlpha(30),
      child: Text(
        _initials,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: context.colorScheme.primary,
        ),
      ),
    );

    return SurfaceCard(
      padding: EdgeInsets.all(16.r),
      child: Row(
        children: [
          if (hasAvatar)
            CircularCachedImage(
              imageUrl: trimmedAvatar,
              size: 56.r,
              errorWidget: initialsAvatar,
              placeholder: initialsAvatar,
            )
          else
            initialsAvatar,
          14.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name.isNotEmpty ? name : 'Dokkan Member',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: context.textPrimaryColor,
                  ),
                ),
                2.verticalSpace,
                Text(
                  email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: context.textSecondaryColor,
                  ),
                ),
                6.verticalSpace,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
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
  }
}
