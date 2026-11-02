part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final AuthTokenModel tokenModel;
  AuthSuccess({required this.tokenModel});
}

final class AuthFailure extends AuthState {
  final String message;
  AuthFailure({required this.message});
}

final class AuthRegisterSuccess extends AuthState {}
final class AuthVerifyEmailSuccess extends AuthState {}