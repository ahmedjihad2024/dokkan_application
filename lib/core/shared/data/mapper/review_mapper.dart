import 'package:intl/intl.dart';

import '../../domain/model/review_entity.dart';
import '../response/reviews_response.dart';

extension ReviewsResponseMapper on ReviewsResponse {
  List<ReviewEntity> toDomain() {
    return reviews?.items.map((i) => i.toDomain()).toList() ?? [];
  }
}

extension ReviewItemResponseMapper on ReviewItemResponse {
  ReviewEntity toDomain() {
    String formattedDate = '';
    if (createdAt != null && createdAt!.isNotEmpty) {
      try {
        final parsed = DateTime.parse(createdAt!);
        formattedDate = DateFormat('dd MMM yyyy').format(parsed);
      } catch (_) {
        formattedDate = createdAt!;
      }
    }

    return ReviewEntity(
      comment: comment,
      rating: rating,
      date: formattedDate,
      userName: userName,
      userPicture: userPicture,
    );
  }
}
