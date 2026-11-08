class RefreshTokenEntity {
  final String accessToken;
  final String refreshToken;
  final DateTime? expiresAtUtc;
  final String? rawExpiresAtUtc;

  const RefreshTokenEntity({
    required this.accessToken,
    required this.refreshToken,
    this.expiresAtUtc,
    this.rawExpiresAtUtc,
  });

  bool get isExpired {
    if (expiresAtUtc == null) return false;
    return DateTime.now().toUtc().isAfter(expiresAtUtc!);
  }

  @override
  String toString() =>
      'RefreshTokenEntity(accessToken: $accessToken, refreshToken: $refreshToken, expiresAtUtc: $expiresAtUtc, isExpired: $isExpired)';
}

