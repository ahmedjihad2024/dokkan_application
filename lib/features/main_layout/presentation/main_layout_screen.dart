import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extensions/theme_extensions.dart';
import '../../../features/home/presentation/home_tab.dart';
import '../../cart/presentation/cart_screen.dart';
import '../../profile/presentation/screens/profile_screen.dart';
import 'cubit/layout_cubit.dart';
import 'cubit/layout_state.dart';
import 'widgets/dokkan_bottom_nav_bar.dart';

class MainLayoutScreen extends StatelessWidget {
  const MainLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LayoutCubit(),
      child: const _MainLayoutContent(),
    );
  }
}

class _MainLayoutContent extends StatelessWidget {
  const _MainLayoutContent();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LayoutCubit>();
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.scaffoldBackgroundColor,
          bottomNavigationBar: DokkanBottomNavBar(
            currentIndex: state.currentNavIndex,
            onTabSelected: cubit.setNavIndex,
          ),
          body: SafeArea(
            child: PageView(
              controller: cubit.pageController,
              physics: const BouncingScrollPhysics(),
              onPageChanged: cubit.setNavIndex,
              children: const [
                HomeTab(),
                CartScreen(),
                ProfileScreen(),
              ],
            ),
          ),
        );
      },
    );
  }
}
