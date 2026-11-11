import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/failure_message.dart';
import '../../../authentication/data/request/change_password_request.dart';
import '../../../authentication/domain/usecase/change_password_usecase.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase changePasswordUseCase;

  ChangePasswordCubit({required this.changePasswordUseCase})
    : super(ChangePasswordInitial());

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    if (isClosed || state is ChangePasswordLoading) return;
    emit(ChangePasswordLoading());

    final result = await changePasswordUseCase(
      ChangePasswordRequest(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmNewPassword: confirmNewPassword,
      ),
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(ChangePasswordError(failure.message)),
      (message) => emit(ChangePasswordSuccess(message)),
    );
  }
}

