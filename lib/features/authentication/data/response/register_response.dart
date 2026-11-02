import '../../../../core/network/base_response.dart';

class RegisterResponse extends BaseResponse {
  const RegisterResponse({
    required super.message,
    super.status = true,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      message: json['message'] as String? ??
          'Registration Successful, an OTP has been sent to your email.',
      status: json['status'] as bool? ?? json['success'] as bool? ?? true,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'message': message,
    'status': status,
  };

  @override
  String toString() => 'RegisterResponse(message: $message, status: $status)';
}
