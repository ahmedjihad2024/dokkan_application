import '../../../../core/network/base_response.dart';

class LoginResponse implements BasicResponse {
  final String? accessToken;
  final String? expiresAtUtc;
  final String? refreshToken;
  final bool? isSuccess;
  final String? responseMessage;

  const LoginResponse({
    this.accessToken,
    this.expiresAtUtc,
    this.refreshToken,
    this.isSuccess,
    this.responseMessage,
  });

  @override
  bool get success =>
      isSuccess ?? (accessToken != null && accessToken!.isNotEmpty);

  @override
  String get message =>
      responseMessage ?? (success ? 'Success' : 'Failed to authenticate');

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['accessToken'] as String?,
      expiresAtUtc: json['expiresAtUtc'] as String?,
      refreshToken: json['refreshToken'] as String?,
      isSuccess: json['success'] as bool?,
      responseMessage: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'expiresAtUtc': expiresAtUtc,
    'refreshToken': refreshToken,
    if (isSuccess != null) 'success': isSuccess,
    if (responseMessage != null) 'message': responseMessage,
  };

  @override
  String toString() =>
      'LoginResponse(success: $success, message: $message, expiresAtUtc: $expiresAtUtc)';
}
