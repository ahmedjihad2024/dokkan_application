import '../../../../core/network/base_response.dart';
import '../../../authentication/data/api/auth_api_service.dart';
import '../request/change_password_request.dart';

abstract class ChangePasswordRemoteDataSource {
  Future<BaseResponse> changePassword(ChangePasswordRequest request);
}

class ChangePasswordRemoteDataSourceImpl
    implements ChangePasswordRemoteDataSource {
  final AuthApiService _apiService;

  ChangePasswordRemoteDataSourceImpl(this._apiService);

  @override
  Future<BaseResponse> changePassword(ChangePasswordRequest request) {
    return _apiService.changePassword(request);
  }
}
