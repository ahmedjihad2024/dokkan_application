import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/enums/request_state.dart';
import '../../../core/extensions/navigation_extension.dart';
import '../../../core/extensions/theme_extensions.dart';
import '../../../core/res/color_manager.dart';
import '../../../core/res/router/routes.dart';
import '../../../core/res/sizes_manager.dart';
import '../../../core/widgets/feedback/app_error_widget.dart';
import '../../../core/widgets/refresh/customized_smart_refresh.dart';
import '../../../core/widgets/state/req_state_widget.dart';
import 'widgets/categories_grid.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(milliseconds: 800));
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  Future<void> _handleLoadMore() async {
    await Future.delayed(const Duration(milliseconds: 800));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(8.r),
          child: IconButton(
            style: IconButton.styleFrom(
              backgroundColor: context.surfaceColor,
              shape: const CircleBorder(),
            ),
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        title: const Text('Categories'),
      ),
      body: ReqStateWidget(
        state: ReqState.success,
        errorMessage: '',
        onRetry: () {},
        onLoading: (_) => const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(ColorM.primary),
          ),
        ),
        onFailure: (context, error) => AppErrorWidget(
          message: error ?? '',
          onRetry: () {},
        ),
        onEmpty: (context) => Center(
          child: Text(
            'No collections available',
            style: TextStyle(
              fontSize: 14.sp,
              color: context.textSecondaryColor,
            ),
          ),
        ),
        onSuccess: (context) => CustomizedSmartRefresh(
          controller: _refreshController,
          onRefresh: _handleRefresh,
          onLoading: _handleLoadMore,
          enableRefresh: true,
          enableLoading: true,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              // Subtitle
              SliverPadding(
                padding: EdgeInsets.only(
                  top: 8.h,
                  left: SizeM.pagePaddingLarge.w,
                  right: SizeM.pagePaddingLarge.w,
                  bottom: 14.h,
                ),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    '6 Collections • 218 Handcrafted Pieces',
                    style: TextStyle(
                      color: context.textSecondaryColor,
                      fontSize: 13.sp,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .slideY(
                        begin: 0.1,
                        end: 0,
                        curve: Curves.easeOutCubic,
                      ),
                ),
              ),

              // Categories grid with animated cards
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeM.pagePaddingLarge.w,
                ),
                sliver: CategoriesGrid(
                  onCategoryTap: (categoryTitle) {
                    context.pushNamed(
                      Routes.productsByCategory,
                      arguments: categoryTitle,
                    );
                  },
                ),
              ),

              // Bottom padding sliver
              SliverToBoxAdapter(
                child: SizedBox(height: 24.h),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
