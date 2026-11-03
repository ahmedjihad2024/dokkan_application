import 'package:flutter/material.dart';

class ReviewEntity {
  final String comment;
  final double rating;
  final String date;
  final String userName;
  final String? userPicture;

  const ReviewEntity({
    required this.comment,
    required this.rating,
    required this.date,
    required this.userName,
    this.userPicture,
  });

  /// Backward-compatible alias for widgets accessing dateText
  String get dateText => date;

  /// Computes initials from userName (e.g. "Ahmed Jihad" -> "AJ")
  String get initials {
    final trimmed = userName.trim();
    if (trimmed.isEmpty) return 'U';
    final parts = trimmed.split(RegExp(r'\s+'));
    if (parts.length >= 2 && parts[0].isNotEmpty && parts[1].isNotEmpty) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return trimmed.substring(0, trimmed.length >= 2 ? 2 : 1).toUpperCase();
  }

  /// Consistent avatar color based on user name
  Color get avatarBgColor {
    const colors = [
      Color(0xFFC06C38),
      Color(0xFF475569),
      Color(0xFF2563EB),
      Color(0xFF059669),
      Color(0xFF7C3AED),
      Color(0xFFDB2777),
    ];
    return colors[userName.hashCode.abs() % colors.length];
  }

  @override
  String toString() =>
      'ReviewEntity(userName: $userName, rating: $rating, date: $date, comment: $comment)';
}
