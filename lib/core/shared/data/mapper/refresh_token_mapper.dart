import '../../domain/model/refresh_token_entity.dart';
import '../response/refresh_token_response.dart';

extension RefreshTokenResponseMapper on RefreshTokenResponse {
  RefreshTokenEntity toDomain() {
    DateTime? parsedExpiry;
    if (expiresAtUtc != null && expiresAtUtc!.trim().isNotEmpty) {
      parsedExpiry = DateTime.tryParse(expiresAtUtc!.trim());
    }

    return RefreshTokenEntity(
      accessToken: accessToken ?? '',
      refreshToken: refreshToken ?? '',
      expiresAtUtc: parsedExpiry,
      rawExpiresAtUtc: expiresAtUtc,
    );
  }
}

