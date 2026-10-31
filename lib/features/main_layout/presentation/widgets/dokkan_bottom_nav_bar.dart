import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/res/gen/assets.gen.dart';

class DokkanBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final int cartCount;
  final ValueChanged<int> onTabSelected;

  const DokkanBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.cartCount,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78.h,
      decoration: BoxDecoration(
        color: context.surfaceColor,
        border: Border(top: BorderSide(color: context.borderColor, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Home Tab matching Figma 37:397
            _NavBarItem(
              icon: Assets.svg.navHome,
              label: 'Home',
              isSelected: currentIndex == 0,
              onTap: () => onTabSelected(0),
            ),
            // Cart Tab with Badge matching Figma 37:403
            _NavBarItem(
              icon: Assets.svg.navCart,
              label: 'Cart',
              isSelected: currentIndex == 1,
              badgeCount: cartCount,
              onTap: () => onTabSelected(1),
            ),
            // Profile Tab matching Figma 37:410
            _NavBarItem(
              icon: Assets.svg.navProfile,
              label: 'Profile',
              isSelected: currentIndex == 2,
              onTap: () => onTabSelected(2),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final SvgGenImage icon;
  final String label;
  final bool isSelected;
  final int? badgeCount;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    this.badgeCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = ColorM.primary;
    final inactiveColor = context.textSecondaryColor;
    final itemColor = isSelected ? activeColor : inactiveColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: SizedBox(
        width: 80.w,
        height: 52.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                icon.svg(
                  width: 22.w,
                  height: 22.w,
                  colorFilter: ColorFilter.mode(itemColor, BlendMode.srcIn),
                ),
                if (badgeCount != null && badgeCount! > 0)
                  Positioned(
                    top: -4.h,
                    right: -8.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 1.h,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16.w,
                        minHeight: 16.h,
                      ),
                      decoration: BoxDecoration(
                        color: ColorM.danger,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        badgeCount! > 99 ? '99+' : badgeCount.toString(),
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w700,
                          color: ColorM.white,
                          height: 1.1,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: itemColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

