import '../../../network/base_response.dart';

class RefreshTokenResponse implements BasicResponse {
  final String? accessToken;
  final String? expiresAtUtc;
  final String? refreshToken;
  final bool? isSuccess;
  final String? responseMessage;

  const RefreshTokenResponse({
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
      responseMessage ??
      (success ? 'Token refreshed successfully' : 'Failed to refresh token');

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponse(
      accessToken: json['accessToken'] as String?,
      expiresAtUtc: json['expiresAtUtc'] as String?,
      refreshToken: json['refreshToken'] as String?,
      isSuccess: json['success'] as bool?,
      responseMessage: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    if (accessToken != null) 'accessToken': accessToken,
    if (expiresAtUtc != null) 'expiresAtUtc': expiresAtUtc,
    if (refreshToken != null) 'refreshToken': refreshToken,
    if (isSuccess != null) 'success': isSuccess,
    if (responseMessage != null) 'message': responseMessage,
  };

  @override
  String toString() =>
      'RefreshTokenResponse(accessToken: $accessToken, expiresAtUtc: $expiresAtUtc, refreshToken: $refreshToken, success: $success, message: $message)';
}

