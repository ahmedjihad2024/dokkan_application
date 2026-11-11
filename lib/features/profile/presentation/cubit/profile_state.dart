import 'dart:io';

import '../../../../core/network/error_handler/failure.dart';
import '../../domain/model/user_entity.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

// Get User States
class ProfileLoadingState extends ProfileState {}
class ProfileSuccessState extends ProfileState {
  final UserEntity user;
  ProfileSuccessState(this.user);
}
class ProfileErrorState extends ProfileState {
  final Failure failure;
  ProfileErrorState(this.failure);
}

// Image Picker State
class ProfileImagePickedState extends ProfileState {
  final File imageFile;
  ProfileImagePickedState(this.imageFile);
}

// Logout States
class LogoutLoadingState extends ProfileState {}
class LogoutSuccessState extends ProfileState {
  final String message;
  LogoutSuccessState(this.message);
}
class LogoutErrorState extends ProfileState {
  final Failure failure;
  LogoutErrorState(this.failure);
}