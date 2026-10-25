import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../product_details/data/models/product_review_model.dart';
import 'review_item_card.dart';

class ReviewsListView extends StatelessWidget {
  final List<ProductReviewModel> reviews;
  final ScrollPhysics? physics;
  final ScrollController? controller;

  const ReviewsListView({
    super.key,
    required this.reviews,
    this.physics,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      physics: physics ?? const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        return ReviewItemCard(review: reviews[index]);
      },
    );
  }
}
