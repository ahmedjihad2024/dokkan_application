class RefreshTokenRequest {
  final String refreshToken;
  final bool useCookies;

  const RefreshTokenRequest({
    required this.refreshToken,
    this.useCookies = false,
  });

  Map<String, dynamic> toJson() => {
    'refreshToken': refreshToken,
    'useCookies': useCookies,
  };

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) {
    return RefreshTokenRequest(
      refreshToken: json['refreshToken'] as String? ?? '',
      useCookies: json['useCookies'] as bool? ?? false,
    );
  }

  @override
  String toString() =>
      'RefreshTokenRequest(refreshToken: $refreshToken, useCookies: $useCookies)';
}

