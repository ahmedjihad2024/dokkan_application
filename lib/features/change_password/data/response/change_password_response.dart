import '../../../../core/network/base_response.dart';

class ChangePasswordResponse implements BasicResponse {
  final bool? isSuccess;
  final String? responseMessage;

  const ChangePasswordResponse({
    this.isSuccess,
    this.responseMessage,
  });

  @override
  bool get success => isSuccess ?? true;

  @override
  String get message =>
      responseMessage ?? (success ? 'Password changed successfully' : 'Failed to change password');

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponse(
      isSuccess: json['success'] as bool? ?? json['status'] as bool?,
      responseMessage: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        if (isSuccess != null) 'success': isSuccess,
        if (responseMessage != null) 'message': responseMessage,
      };

  @override
  String toString() =>
      'ChangePasswordResponse(success: $success, message: $message)';
}