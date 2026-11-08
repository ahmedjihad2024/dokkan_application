import '../api/refresh_token_api_service.dart';
import '../request/refresh_token_request.dart';
import '../response/refresh_token_response.dart';

abstract class RefreshTokenRemoteDataSource {
  Future<RefreshTokenResponse> refreshToken(RefreshTokenRequest request);
}

class RefreshTokenRemoteDataSourceImpl implements RefreshTokenRemoteDataSource {
  final RefreshTokenApiService _apiService;

  RefreshTokenRemoteDataSourceImpl(this._apiService);

  @override
  Future<RefreshTokenResponse> refreshToken(RefreshTokenRequest request) {
    return _apiService.refreshToken(request);
  }
}

