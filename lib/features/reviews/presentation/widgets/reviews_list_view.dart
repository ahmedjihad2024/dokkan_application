import 'package:flutter/material.dart';

import '../../../../core/shared/domain/model/review_entity.dart';
import 'review_item_card.dart';

class ReviewsListView extends StatelessWidget {
  final List<ReviewEntity> reviews;

  const ReviewsListView({
    super.key,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        return ReviewItemCard(review: reviews[index]);
      },
    );
  }
}
