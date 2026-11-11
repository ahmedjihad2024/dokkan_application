import '../../../../core/network/base_response.dart';

class CurrentUserResponse implements BasicResponse {
  final String userId;
  final String email;
  final String fullName;
  final String? profilePicture;
  final bool? isSuccess;
  final String? responseMessage;

  const CurrentUserResponse({
    required this.userId,
    required this.email,
    required this.fullName,
    this.profilePicture,
    this.isSuccess,
    this.responseMessage,
  });

  @override
  bool get success => isSuccess ?? userId.isNotEmpty;

  @override
  String get message =>
      responseMessage ??
      (success ? 'Success' : 'Failed to fetch current user profile');

  factory CurrentUserResponse.fromJson(Map<String, dynamic> json) {
    final source =
        json['data'] is Map<String, dynamic>
            ? json['data'] as Map<String, dynamic>
            : json;

    return CurrentUserResponse(
      userId:
          (source['userId'] ?? source['id'] ?? source['sellerId'])
              ?.toString() ??
          '',
      email: source['email']?.toString() ?? '',
      fullName: source['fullName']?.toString() ?? '',
      profilePicture: source['profilePicture']?.toString(),
      isSuccess: json['success'] as bool?,
      responseMessage: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'email': email,
    'fullName': fullName,
    'profilePicture': profilePicture,
  };
}

