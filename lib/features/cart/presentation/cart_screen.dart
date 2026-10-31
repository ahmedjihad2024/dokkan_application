import 'package:dokkan/core/res/color_manager.dart';
import 'package:flutter/material.dart';

class EmptyCartScreen extends StatelessWidget {
  const EmptyCartScreen({
    super.key,
    this.onExploreCollections,
  });

  final VoidCallback? onExploreCollections;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorM.backgroundLight,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 22, 20, 16),
              child: Text(
                'Shopping Bag',
                style: TextStyle(
                  color: ColorM.textPrimaryLight,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: ColorM.primaryLight,
                          shape: BoxShape.circle,
                          border: Border.all(color: ColorM.primary200),
                        ),
                        child: const Icon(
                          Icons.shopping_bag_outlined,
                          color: ColorM.primary,
                          size: 28,
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Your Shopping Bag is Empty',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ColorM.textPrimaryLight,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Explore our handcrafted collection of timepieces, '
                        'leather goods, and bespoke accessories.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ColorM.textSecondaryLight,
                          fontSize: 12,
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 18),
                      FilledButton.icon(
                        onPressed: onExploreCollections,
                        iconAlignment: IconAlignment.end,
                        icon: const Icon(Icons.arrow_forward, size: 16),
                        label: const Text('Explore Collections'),
                        style: FilledButton.styleFrom(
                          backgroundColor: ColorM.primary,
                          foregroundColor: ColorM.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 13,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const _CartBottomNavigation(),
          ],
        ),
      ),
    );
  }
}

class _CartBottomNavigation extends StatelessWidget {
  const _CartBottomNavigation();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 62,
        decoration: const BoxDecoration(
          color: ColorM.surfaceLight,
          border: Border(top: BorderSide(color: ColorM.borderLight)),
        ),
        child: const Row(
          children: [
            _NavItem(icon: Icons.home_outlined, label: 'Home'),
            _NavItem(
              icon: Icons.shopping_bag_outlined,
              label: 'Cart',
              selected: true,
            ),
            _NavItem(icon: Icons.person_outline, label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    this.selected = false,
  });

  final IconData icon;
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final color = selected ? ColorM.primary : ColorM.textSecondaryLight;

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 21, color: color),
          const SizedBox(height: 3),
          Text(label, style: TextStyle(color: color, fontSize: 10)),
        ],
      ),
    );
  }
}