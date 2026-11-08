import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthStatus { authenticated, unauthenticated }

class AppAuthCubit extends Cubit<AuthStatus> {
  AppAuthCubit(super.initial);

  void sessionExpired() {
    if (state != AuthStatus.unauthenticated) {
      emit(AuthStatus.unauthenticated);
    }
  }

  void loggedIn() {
    if (state != AuthStatus.authenticated) {
      emit(AuthStatus.authenticated);
    }
  }
}

