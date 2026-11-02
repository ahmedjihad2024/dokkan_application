import '../api/auth_api_service.dart';
import '../request/login_request.dart';
import '../request/register_request.dart';
import '../request/verify_email_request.dart';
import '../response/login_response.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login(LoginRequest request);

  Future<void> register(RegisterRequest request);

  Future<void> verifyEmail(VerifyEmailRequest request);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApiService _apiService;

  AuthRemoteDataSourceImpl(this._apiService);

  @override
  Future<LoginResponse> login(LoginRequest request) {
    return _apiService.login(request);
  }

  @override
  Future<void> register(RegisterRequest request) {
    return _apiService.register(request);
  }

  @override
  Future<void> verifyEmail(VerifyEmailRequest request) {
    return _apiService.verifyEmail(request);
  }
}