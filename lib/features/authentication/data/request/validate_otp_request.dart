class ValidateOtpRequest {
  final String email;
  final String otp;

  const ValidateOtpRequest({
    required this.email,
    required this.otp,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'otp': otp,
  };

  @override
  String toString() => 'ValidateOtpRequest(email: $email, otp: $otp)';
}

