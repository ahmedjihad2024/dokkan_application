import 'package:dokkan/features/profile/data/response/user_response.dart';

import '../../../../core/network/base_response.dart';
import '../../../authentication/data/api/auth_api_service.dart';

abstract class ProfileRemoteDataSource {
  Future<UserResponse> getMe();
  Future<BaseResponse> logout();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final AuthApiService _apiService;

  ProfileRemoteDataSourceImpl(this._apiService);

  @override
  Future<UserResponse> getMe() => _apiService.getMe();

  @override
  Future<BaseResponse> logout() => _apiService.logout();
}
