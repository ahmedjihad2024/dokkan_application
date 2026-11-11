import '../../../../core/network/error_handler/failure.dart';

abstract class ChangePasswordState {}

class ChangePasswordInitialState extends ChangePasswordState {}
class ChangePasswordLoadingState extends ChangePasswordState {}
class ChangePasswordSuccessState extends ChangePasswordState {}
class ChangePasswordErrorState extends ChangePasswordState {
  final Failure failure;
  ChangePasswordErrorState(this.failure);
}