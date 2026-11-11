/// Represents the currently authenticated user profile fetched from `/api/auth/me`.
class UserProfileEntity {
  final String userId;
  final String email;
  final String fullName;
  final String? profilePicture;

  const UserProfileEntity({
    required this.userId,
    required this.email,
    required this.fullName,
    this.profilePicture,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileEntity &&
          runtimeType == other.runtimeType &&
          userId == other.userId;

  @override
  int get hashCode => userId.hashCode;

  @override
  String toString() =>
      'UserProfileEntity(userId: $userId, email: $email, fullName: $fullName)';
}

