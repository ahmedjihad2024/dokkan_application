import '../../domain/model/user_entity.dart';

class UserModel {
  final String? userId;
  final String? fullName;
  final String? email;
  final String? profilePicture;

  const UserModel({
    this.userId,
    this.fullName,
    this.email,
    this.profilePicture,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json[' userId']?.toString() ?? json['userId']?.toString(),
      fullName: json['fullName']?.toString(),
      email: json['email']?.toString(),
      profilePicture:
          json['profilePicture']?.toString() ??
          json['profilePicture']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': userId,
    'name': fullName,
    'email': email,
    'profilePicture': profilePicture,
  };

  UserEntity toEntity() => UserEntity(
    userId: userId ?? '',
    fullName: fullName ?? '',
    email: email ?? '',
    profilePicture: profilePicture ?? '',
  );
}
