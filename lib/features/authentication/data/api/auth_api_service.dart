import 'package:dio/dio.dart';

import '../request/login_request.dart';
import '../response/login_response.dart';

abstract class AuthApiService {
  Future<LoginResponse> login(LoginRequest request);
}

class AuthApiServiceImpl implements AuthApiService {
  final Dio _dio;

  AuthApiServiceImpl(this._dio);

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    final response = await _dio.post(
      '/api/auth/login',
      data: request.toJson(),
    );
    return LoginResponse.fromJson(response.data as Map<String, dynamic>);
  }
}

