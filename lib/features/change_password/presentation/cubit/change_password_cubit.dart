import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/request/change_password_request.dart';
import '../../domain/usecase/change_password_usecase.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordCubit(this._changePasswordUseCase)
    : super(ChangePasswordInitialState());

  final formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> changePassword() async {
    if (!formKey.currentState!.validate()) return;

    emit(ChangePasswordLoadingState());

    final request = ChangePasswordRequest(
      oldPassword: currentPasswordController.text.trim(),
      newPassword: newPasswordController.text.trim(),
      newPasswordConfirmation: confirmPasswordController.text.trim(),
    );

    final result = await _changePasswordUseCase(request);

    result.fold(
      (failure) => emit(ChangePasswordErrorState(failure)),
      (_) => emit(ChangePasswordSuccessState()),
    );
  }

  @override
  Future<void> close() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
