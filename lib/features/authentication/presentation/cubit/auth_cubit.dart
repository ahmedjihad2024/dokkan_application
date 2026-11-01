import 'package:dokkan/core/di/dependency_injection.dart';
import 'package:dokkan/core/network/failure_message.dart';
import 'package:dokkan/features/authentication/data/request/login_request.dart';
import 'package:dokkan/features/authentication/domain/model/auth_token_model.dart';
import 'package:dokkan/features/authentication/domain/usecase/login_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;

  AuthCubit({LoginUseCase? loginUseCase})
      : _loginUseCase = loginUseCase ?? sl<LoginUseCase>(),
        super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    final result = await _loginUseCase(
      LoginRequest(email: email, password: password),
    );
    result.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (tokenModel) => emit(AuthSuccess(tokenModel: tokenModel)),
    );
  }
}