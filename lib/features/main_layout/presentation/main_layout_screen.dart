import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extensions/theme_extensions.dart';
import '../../../features/cart/presentation/cart_screen.dart';
import '../../../features/home/presentation/home_tab.dart';
import '../../../features/profile/presentation/profile_screen.dart';
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

class _MainLayoutContent extends StatefulWidget {
  const _MainLayoutContent();

  @override
  State<_MainLayoutContent> createState() => _MainLayoutContentState();
}

class _MainLayoutContentState extends State<_MainLayoutContent> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    context.read<LayoutCubit>().setNavIndex(index);
    if (_pageController.hasClients) {
      _pageController.jumpToPage(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        final cubit = context.read<LayoutCubit>();
        return Scaffold(
          backgroundColor: context.scaffoldBackgroundColor,
          bottomNavigationBar: DokkanBottomNavBar(
            currentIndex: state.currentNavIndex,
            cartCount: state.cartCount,
            onTabSelected: _onTabSelected,
          ),
          body: SafeArea(
            child: PageView(
              controller: _pageController,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (index) {
                cubit.setNavIndex(index);
              },
              children: [
                HomeTab(state: state, cubit: cubit),
                const CartScreen(),
                const ProfileScreen(),
              ],
            ),
          ),
        );
      },
    );
  }
}
