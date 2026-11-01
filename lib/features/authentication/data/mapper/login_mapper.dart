import '../../domain/model/auth_token_model.dart';
import '../response/login_response.dart';

extension LoginResponseMapper on LoginResponse {
  AuthTokenModel toDomain() {
    DateTime? parsedExpiry;
    if (expiresAtUtc != null && expiresAtUtc!.isNotEmpty) {
      parsedExpiry = DateTime.tryParse(expiresAtUtc!);
    }
    return AuthTokenModel(
      accessToken: accessToken ?? '',
      expiresAtUtc: parsedExpiry,
      refreshToken: refreshToken ?? '',
    );
  }
}

