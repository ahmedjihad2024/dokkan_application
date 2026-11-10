import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/navigation_extension.dart';
import '../../../core/extensions/theme_extensions.dart';
import '../../../core/res/sizes_manager.dart';
import 'cubit/search_cubit.dart';
import 'cubit/search_state.dart';
import 'widgets/search_active_filter_chips.dart';
import 'widgets/search_body.dart';
import 'widgets/search_filter_panel.dart';
import 'widgets/search_input_field.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();

    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.surfaceColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20.sp,
            color: context.textPrimaryColor,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Search & Discover',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: context.textPrimaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          final isFilterOpen = _isFilterOpen(state);
          final activeCount = _activeFiltersCount(state);

          return Column(
            children: [
              // Search Input & Filter toggle bar
              Padding(
                padding: EdgeInsets.fromLTRB(
                  SizeM.pagePadding.w,
                  10.h,
                  SizeM.pagePadding.w,
                  8.h,
                ),
                child: SearchInputField(
                  controller: cubit.searchController,
                  onChanged: cubit.onSearchChanged,
                  onSubmitted: cubit.onSearchSubmitted,
                  onClear: cubit.clearSearch,
                  onToggleFilter: cubit.toggleFilterPanel,
                  isFilterOpen: isFilterOpen,
                  activeFiltersCount: activeCount,
                ),
              ),

              // Collapsible Filter Panel
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
                child: isFilterOpen
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(
                          SizeM.pagePadding.w,
                          4.h,
                          SizeM.pagePadding.w,
                          12.h,
                        ),
                        child: SearchFilterPanel(
                          initialMinPrice: cubit.minPrice,
                          initialMaxPrice: cubit.maxPrice,
                          initialSortBy: cubit.sortBy,
                          initialSortOrder: cubit.sortOrder,
                          onApply: ({minPrice, maxPrice, sortBy, sortOrder}) {
                            cubit.applyFilters(
                              minPrice: minPrice,
                              maxPrice: maxPrice,
                              sortBy: sortBy,
                              sortOrder: sortOrder,
                            );
                          },
                          onReset: cubit.resetFilters,
                          onHide: cubit.toggleFilterPanel,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),

              // Active Filter Tags Row
              if (activeCount > 0) SearchActiveFilterChips(cubit: cubit),

              // Main Body Content
              Expanded(child: SearchBody(cubit: cubit, state: state)),
            ],
          );
        },
      ),
    );
  }

  bool _isFilterOpen(SearchState state) {
    if (state is SearchActive) return state.isFilterPanelOpen;
    if (state is SearchEmpty) return state.isFilterPanelOpen;
    if (state is SearchError) return state.isFilterPanelOpen;
    return false;
  }

  int _activeFiltersCount(SearchState state) {
    if (state is SearchActive) return state.activeFiltersCount;
    return 0;
  }
}
