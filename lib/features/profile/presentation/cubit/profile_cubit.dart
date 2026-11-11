import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/model/user_entity.dart';
import '../../domain/use_cases/get_me_use_case.dart';
import '../../domain/use_cases/logout_use_case.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetMeUseCase _getMeUseCase;
  final LogoutUseCase _logoutUseCase;

  ProfileCubit({required this._getMeUseCase, required this._logoutUseCase})
    : super(ProfileInitialState());

  UserEntity? currentUser;
  File? selectedImage;
  bool _isPickingImage = false;

  Future<void> pickProfileImage() async {
    if (_isPickingImage) return;

    _isPickingImage = true;

    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
        emit(ProfileImagePickedState(selectedImage!));
      }
    } catch (e) {
      print("Image Picker Error: $e");
    } finally {
      _isPickingImage = false;
    }
  }

  Future<void> getUserProfile() async {
    emit(ProfileLoadingState());

    final result = await _getMeUseCase();

    result.fold(
      (failure) {
        emit(ProfileErrorState(failure));
      },
      (user) {
        currentUser = user;
        emit(ProfileSuccessState(user));
      },
    );
  }

  Future<void> logout() async {
    emit(LogoutLoadingState());

    final result = await _logoutUseCase();

    result.fold(
      (failure) => emit(LogoutErrorState(failure)),
      (message) => emit(LogoutSuccessState(message)),
    );
  }
}
