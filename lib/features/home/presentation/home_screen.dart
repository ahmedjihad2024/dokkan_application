import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extensions/theme_extensions.dart';
import 'cubit/home_cubit.dart';
import 'cubit/home_state.dart';
import 'tabs/cart_tab.dart';
import 'tabs/home_tab.dart';
import 'tabs/profile_tab.dart';
import 'widgets/dokkan_bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends StatefulWidget {
  const _HomeScreenContent();

  @override
  State<_HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<_HomeScreenContent> {
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
    context.read<HomeCubit>().setNavIndex(index);
    if (_pageController.hasClients) {
      _pageController.jumpToPage(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
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
                const CartTab(),
                const ProfileTab(),
              ],
            ),
          ),
        );
      },
    );
  }
}
