class AuthTokenModel {
  final String accessToken;
  final DateTime? expiresAtUtc;
  final String refreshToken;

  const AuthTokenModel({
    required this.accessToken,
    this.expiresAtUtc,
    required this.refreshToken,
  });

  bool get isExpired {
    if (expiresAtUtc == null) return false;
    return DateTime.now().toUtc().isAfter(expiresAtUtc!);
  }

  @override
  String toString() =>
      'AuthTokenModel(expiresAtUtc: $expiresAtUtc, isExpired: $isExpired)';
}

