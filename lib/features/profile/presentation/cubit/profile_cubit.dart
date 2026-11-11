import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../core/auth/app_auth_cubit.dart';
import '../../../../core/network/failure_message.dart';
import '../../../../core/services/storage_services/storage_service.dart';
import '../../../../core/shared/domain/model/user_profile_entity.dart';
import '../../../authentication/domain/usecase/get_current_user_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final StorageService storageService;
  final AppAuthCubit appAuthCubit;
  final RefreshController refreshController = RefreshController();

  ProfileCubit({
    required this.getCurrentUserUseCase,
    required this.storageService,
    required this.appAuthCubit,
  }) : super(const ProfileInitial());

  Future<bool> logout() async {
    final needsManualNavigation =
        appAuthCubit.state != AuthStatus.authenticated;
    await storageService.clearAuthTokens();
    appAuthCubit.sessionExpired();
    return needsManualNavigation;
  }

  Future<void> fetchProfile({bool isRefresh = false}) async {
    if (isClosed) return;

    emit(const ProfileLoading());

    final result = await getCurrentUserUseCase();
    if (isClosed) return;

    result.fold(
      (failure) {
        if (isRefresh) {
          refreshController.refreshFailed();
        }
        emit(ProfileFailure(failure.message));
      },
      (user) {
        if (isRefresh) {
          refreshController.refreshCompleted();
        }
        emit(ProfileSuccess(user));
      },
    );
  }

  @override
  Future<void> close() {
    refreshController.dispose();
    return super.close();
  }
}

