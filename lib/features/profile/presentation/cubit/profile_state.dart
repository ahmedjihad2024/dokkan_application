part of 'profile_cubit.dart';

sealed class ProfileState {
  const ProfileState();
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

final class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

final class ProfileSuccess extends ProfileState {
  final UserProfileEntity user;

  const ProfileSuccess(this.user);
}

final class ProfileFailure extends ProfileState {
  final String message;

  const ProfileFailure(this.message);
}

