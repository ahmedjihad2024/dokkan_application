import 'package:flutter/material.dart';

class ProductReviewModel {
  final String id;
  final String author;
  final String initials;
  final Color avatarBgColor;
  final bool isVerified;
  final double rating;
  final String dateText;
  final String comment;

  const ProductReviewModel({
    required this.id,
    required this.author,
    required this.initials,
    required this.avatarBgColor,
    this.isVerified = true,
    required this.rating,
    required this.dateText,
    required this.comment,
  });

  ProductReviewModel copyWith({
    String? id,
    String? author,
    String? initials,
    Color? avatarBgColor,
    bool? isVerified,
    double? rating,
    String? dateText,
    String? comment,
  }) {
    return ProductReviewModel(
      id: id ?? this.id,
      author: author ?? this.author,
      initials: initials ?? this.initials,
      avatarBgColor: avatarBgColor ?? this.avatarBgColor,
      isVerified: isVerified ?? this.isVerified,
      rating: rating ?? this.rating,
      dateText: dateText ?? this.dateText,
      comment: comment ?? this.comment,
    );
  }

  static List<ProductReviewModel> defaultReviews() {
    return const [
      ProductReviewModel(
        id: 'rev_1',
        author: 'Karim Mansour',
        initials: 'KM',
        avatarBgColor: Color(0xFFC06C38),
        isVerified: true,
        rating: 5.0,
        dateText: '2 days ago',
        comment:
            '“The watch finish and calfskin strap are exceptional. Premium packaging.”',
      ),
      ProductReviewModel(
        id: 'rev_2',
        author: 'Layla Al-Sabah',
        initials: 'LA',
        avatarBgColor: Color(0xFF475569),
        isVerified: true,
        rating: 5.0,
        dateText: '1 week ago',
        comment:
            '“Arrived within 48h in a beautiful gift box. Exquisite craftsmanship!”',
      ),
      ProductReviewModel(
        id: 'rev_3',
        author: 'Tarek Zein',
        initials: 'TZ',
        avatarBgColor: Color(0xFF2563EB),
        isVerified: true,
        rating: 4.0,
        dateText: '2 weeks ago',
        comment:
            '“Great craftsmanship and weight. The leather strap takes a couple days to break in.”',
      ),
      ProductReviewModel(
        id: 'rev_4',
        author: 'Omar Farooq',
        initials: 'OF',
        avatarBgColor: Color(0xFF059669),
        isVerified: false,
        rating: 3.0,
        dateText: '3 weeks ago',
        comment:
            '“Solid everyday watch, looks elegant but slightly heavier than expected.”',
      ),
    ];
  }
}
