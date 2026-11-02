import 'package:dokkan/core/di/dependency_injection.dart';
import 'package:dokkan/features/authentication/data/request/login_request.dart';
import 'package:dokkan/features/authentication/data/request/register_request.dart';
import 'package:dokkan/features/authentication/data/request/verify_email_request.dart';
import 'package:dokkan/features/authentication/domain/model/auth_token_model.dart';
import 'package:dokkan/features/authentication/domain/usecase/login_usecase.dart';
import 'package:dokkan/features/authentication/domain/usecase/register_usecase.dart';
import 'package:dokkan/features/authentication/domain/usecase/verify_email_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:dokkan/core/network/failure_message.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final VerifyEmailUseCase _verifyEmailUseCase;

  AuthCubit({
    LoginUseCase? loginUseCase,
    RegisterUseCase? registerUseCase,
    VerifyEmailUseCase? verifyEmailUseCase,
  }) : _loginUseCase = loginUseCase ?? sl<LoginUseCase>(),
       _registerUseCase = registerUseCase ?? sl<RegisterUseCase>(),
       _verifyEmailUseCase = verifyEmailUseCase ?? sl<VerifyEmailUseCase>(),
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

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    final result = await _registerUseCase(
      RegisterRequest(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      ),
    );

    result.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (_) => emit(AuthRegisterSuccess()),
    );
  }

  Future<void> verifyEmail({required String email, required String otp}) async {
    emit(AuthLoading());

    final result = await _verifyEmailUseCase(
      VerifyEmailRequest(email: email, otp: otp),
    );

    result.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (_) => emit(AuthVerifyEmailSuccess()),
    );
  }
}
