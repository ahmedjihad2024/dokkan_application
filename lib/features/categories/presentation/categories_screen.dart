import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/navigation_extension.dart';
import '../../../core/extensions/theme_extensions.dart';
import '../../../core/res/router/routes.dart';
import '../../../core/res/sizes_manager.dart';
import '../../../core/widgets/feedback/app_error_widget.dart';
import '../../../core/widgets/refresh/customized_smart_refresh.dart';
import 'cubit/categories_cubit.dart';
import 'cubit/categories_state.dart';
import 'widgets/categories_grid.dart';
import 'widgets/categories_shimmer.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

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
      body: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          final cubit = context.read<CategoriesCubit>();

          if (state is CategoriesLoading) {
            return const CategoriesShimmer();
          }

          if (state is CategoriesError) {
            return AppErrorWidget(
              message: state.message,
              onRetry: () => cubit.getCategories(isRefresh: true),
            );
          }

          if (state is CategoriesEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.category_outlined,
                    size: 64.r,
                    color: context.textMutedColor,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'No categories available',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: context.textSecondaryColor,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () => cubit.getCategories(isRefresh: true),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is CategoriesActive) {
            final categories = state.categories;

            return CustomizedSmartRefresh(
              controller: cubit.refreshController,
              onRefresh: () => cubit.getCategories(isRefresh: true),
              enableRefresh: true,
              enableLoading: false,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.only(
                      top: 8.h,
                      left: SizeM.pagePaddingLarge.w,
                      right: SizeM.pagePaddingLarge.w,
                      bottom: 14.h,
                    ),
                    sliver: SliverToBoxAdapter(
                      child:
                          Text(
                                '${categories.length} Collections',
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
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeM.pagePaddingLarge.w,
                    ),
                    sliver: CategoriesGrid(
                      categories: categories,
                      onCategoryTap: (category) {
                        context.pushNamed(
                          Routes.productsByCategory,
                          arguments: category,
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
