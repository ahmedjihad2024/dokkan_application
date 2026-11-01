import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../product_details/data/models/product_review_model.dart';
import 'review_item_card.dart';

class ReviewsListView extends StatelessWidget {
  final List<ProductReviewModel> reviews;

  const ReviewsListView({
    super.key,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        // Cap staggered delay to first visible items to ensure smooth lazy loading for hundreds of comments
        final delay = index < 8 ? (index * 50).ms : Duration.zero;

        return ReviewItemCard(review: reviews[index])
            .animate(delay: delay)
            .fadeIn(
              duration: 350.ms,
              curve: Curves.easeOutCubic,
            )
            .slideY(
              begin: 0.06,
              end: 0,
              duration: 350.ms,
              curve: Curves.easeOutCubic,
            );
      },
    );
  }
}
