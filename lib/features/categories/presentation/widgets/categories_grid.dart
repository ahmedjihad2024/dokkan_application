import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/res/sizes_manager.dart';
import 'collection_card.dart';

class CategoriesGrid extends StatelessWidget {
  final ValueChanged<String>? onCategoryTap;

  const CategoriesGrid({
    super.key,
    this.onCategoryTap,
  });

  static const List<({String title, String sub, String count, IconData icon})>
      collections = [
    (
      title: 'Timepieces',
      sub: 'Automatic & quartz',
      count: '50 Items',
      icon: Icons.access_time_rounded,
    ),
    (
      title: 'Bags & Luggage',
      sub: 'Handcrafted leather',
      count: '42 Items',
      icon: Icons.shopping_bag_outlined,
    ),
    (
      title: 'Eyewear',
      sub: 'Artisan frames',
      count: '28 Items',
      icon: Icons.visibility_outlined,
    ),
    (
      title: 'Fine Jewelry',
      sub: 'Gold & silver',
      count: '36 Items',
      icon: Icons.diamond_outlined,
    ),
    (
      title: 'Wallets',
      sub: 'Slim cardholders',
      count: '34 Items',
      icon: Icons.account_balance_wallet_outlined,
    ),
    (
      title: 'Accessories',
      sub: 'Cufflinks & belts',
      count: '28 Items',
      icon: Icons.watch_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: SizeM.elementSpacing.w,
        mainAxisSpacing: SizeM.elementSpacing.h,
        childAspectRatio: 0.8,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final item = collections[index];
          return CollectionCard(
            title: item.title,
            subtitle: item.sub,
            itemCount: item.count,
            icon: item.icon,
            onTap: () => onCategoryTap?.call(item.title),
          )
              .animate(delay: (index * 60).ms)
              .fadeIn(
                duration: 400.ms,
                curve: Curves.easeOutCubic,
              )
              .slideY(
                begin: 0.12,
                end: 0,
                duration: 400.ms,
                curve: Curves.easeOutCubic,
              )
              .scale(
                begin: const Offset(0.95, 0.95),
                end: const Offset(1, 1),
                duration: 400.ms,
                curve: Curves.easeOutCubic,
              );
        },
        childCount: collections.length,
      ),
    );
  }
}
