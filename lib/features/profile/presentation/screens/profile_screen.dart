import 'package:dokkan/core/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/navigation_extension.dart';
import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/res/gen/assets.gen.dart';
import '../../../../core/res/router/routes.dart';
import '../widgets/profile_header_card.dart';
import '../widgets/profile_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state == ThemeMode.dark;

    final List<ProfileTile> items = [
      ProfileTile(
        title: 'Appearance (Dark/Light)',
        icon: Assets.svg.iconTheme,
        trailing: Switch.adaptive(
          value: isDarkMode,
          thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.selected)) {
              return ColorM.white;
            }
            return null;
          }),
          trackColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.selected)) {
              return context.colorScheme.primary;
            }
            return null;
          }),
          onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
        ),
      ),
      ProfileTile(
        title: 'Change Password',
        icon: Assets.svg.iconLock,
        onTap: () => context.pushNamed(Routes.changePassword),
      ),
      ProfileTile(
        title: 'Manage Products (Admin)',
        icon: Assets.svg.navCart,
        onTap: () => context.pushNamed(Routes.manageProducts),
      ),
      ProfileTile(
        title: 'Privacy & Policy',
        icon: Assets.svg.iconShield,
        onTap: () => context.pushNamed(Routes.privacyPolicy),
      ),
      ProfileTile(
        title: 'About Us',
        icon: Assets.svg.iconAbout,
        onTap: () => context.pushNamed(Routes.aboutUs),
      ),
      ProfileTile(
        title: 'Contact Us',
        icon: Assets.svg.iconContact,
        onTap: () => context.pushNamed(Routes.contactUs),
      ),
      ProfileTile(
        title: 'Logout',
        icon: Assets.svg.iconLogout,
        titleColor: ColorM.danger,
        iconColor: ColorM.danger,
        iconBackgroundColor: ColorM.danger.withAlpha(50),
        trailing: const SizedBox.shrink(),
        onTap: () {
          context.pushNamedAndRemoveUntil(Routes.login, (route) => false);
        },
      ),
    ];

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

              SizedBox(height: 20.h),

              ProfileHeaderCard(
                name: 'Alexander Mansour',
                email: 'alexander.mansour@atelier.com',
              ),

              SizedBox(height: 16.h),

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                separatorBuilder: (context, index) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ProfileTile(
                    title: item.title,
                    icon: item.icon,
                    onTap: item.onTap,
                    trailing: item.trailing,
                    titleColor: item.titleColor,
                    iconColor: item.iconColor,
                    iconBackgroundColor: item.iconBackgroundColor,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
