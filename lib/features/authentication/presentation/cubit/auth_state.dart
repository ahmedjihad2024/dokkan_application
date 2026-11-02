part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  AuthSuccess();
}

final class AuthFailure extends AuthState {
  final String message;
  AuthFailure({required this.message});
}

final class AuthRegisterSuccess extends AuthState {
  final String message;
  AuthRegisterSuccess({required this.message});
}

final class AuthVerifyEmailSuccess extends AuthState {
  final String message;
  AuthVerifyEmailSuccess({required this.message});
}

final class AuthResendOtpLoading extends AuthState {}

final class AuthResendOtpSuccess extends AuthState {
  final String message;
  final String email;

  AuthResendOtpSuccess({required this.message, required this.email});
}
