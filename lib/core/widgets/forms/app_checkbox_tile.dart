import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../extensions/theme_extensions.dart';
import '../../res/color_manager.dart';
import '../../res/gen/assets.gen.dart';

class AppCheckboxTile extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Widget child;

  const AppCheckboxTile({
    super.key,
    required this.value,
    required this.onChanged,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 22.w,
            height: 22.w,
            decoration: BoxDecoration(
              color: value ? ColorM.primary : context.surfaceElevatedColor,
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(
                color: value ? ColorM.primary : context.borderColor,
                width: 1.5,
              ),
            ),
            child: value
                ? Center(
                    child: Assets.svg.iconCheck.svg(
                      width: 14.w,
                      height: 14.w,
                      colorFilter: const ColorFilter.mode(
                        ColorM.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  )
                : null,
          ),
          SizedBox(width: 10.w),
          Expanded(child: child),
        ],
      ),
    );
  }
}