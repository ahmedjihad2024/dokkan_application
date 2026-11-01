import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../extensions/theme_extensions.dart';
import '../../res/color_manager.dart';
import '../../res/fonts_manager.dart';
import '../../res/translations_manager.dart';

export 'package:pull_to_refresh/pull_to_refresh.dart' show RefreshController;

class CustomizedSmartRefresh extends StatelessWidget {
  final Widget child;
  final RefreshController controller;
  final ScrollController? scrollController;
  final void Function()? onLoading;
  final void Function()? onRefresh;
  final bool enableLoading;
  final bool enableRefresh;
  final EdgeInsetsGeometry? classicFooterPadding;
  final ScrollPhysics? physics;
  final RefreshStyle? refreshStyle;

  const CustomizedSmartRefresh({
    super.key,
    required this.child,
    required this.controller,
    this.scrollController,
    this.onLoading,
    this.onRefresh,
    this.enableLoading = false,
    this.enableRefresh = true,
    this.classicFooterPadding,
    this.physics,
    this.refreshStyle
  });

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      key: super.key,
      controller: controller,
      scrollController: scrollController,
      enablePullUp: enableLoading,
      enablePullDown: enableRefresh,
      physics: physics,
      header: ClassicHeader(
        refreshStyle: refreshStyle ?? RefreshStyle.Behind,
        idleIcon: const Icon(Icons.arrow_downward, color: ColorM.primary),
        releaseIcon: const Icon(Icons.refresh, color: ColorM.primary),
        refreshingIcon: SizedBox(
          width: 25.0,
          height: 50.0.w,
          child: const Center(
            child: SizedBox(
              width: 25.0,
              height: 25.0,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation<Color>(ColorM.primary),
              ),
            ),
          ),
        ),
        idleText: '',
        refreshingText: '',
        completeText: '',
        failedText: '',
        releaseText: '',
        canTwoLevelText: '',
        textStyle: const TextStyle(fontSize: 0, height: 0),
      ),
      footer: ClassicFooter(
        outerBuilder: (child) {
          return Padding(
            padding: classicFooterPadding ?? EdgeInsets.zero,
            child: child,
          );
        },
        textStyle: context.labelSmall.copyWith(
          color: context.textPrimaryColor.withValues(alpha: .5),
          fontWeight: FontWeightM.medium,
        ),
        loadingText: Translation.loading.tr,
        noDataText: Translation.no_more.tr,
        failedText: Translation.failed_loading.tr,
        idleText: Translation.load_more.tr,
        canLoadingText: Translation.load_more.tr,
        spacing: 12.w,
        height: 50 + (classicFooterPadding?.vertical ?? 0),
        loadingIcon: SizedBox(
          width: 15.w,
          height: 15.w,
          child: const CircularProgressIndicator(
            color: ColorM.primary,
            valueColor: AlwaysStoppedAnimation<Color>(ColorM.primary),
            backgroundColor: Colors.transparent,
            strokeWidth: 2.2,
            strokeCap: StrokeCap.round,
          ),
        ),
      ),
      onLoading: onLoading,
      onRefresh: onRefresh != null
          ? () {
              HapticFeedback.mediumImpact();
              onRefresh!();
            }
          : null,
      child: child,
    );
  }
}
