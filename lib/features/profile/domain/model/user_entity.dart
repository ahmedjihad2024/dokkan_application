class UserEntity {
  final String userId;
  final String fullName;
  final String email;
  final String? profilePicture;

  const UserEntity({
    required this.userId,
    required this.fullName,
    required this.email,
    this.profilePicture,
  });
}
