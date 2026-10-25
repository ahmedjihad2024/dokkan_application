/// Global Request State enum for standardizing asynchronous operations
enum ReqState {
  idle,
  loading,
  success,
  failure,
  empty;

  bool get isIdle => this == ReqState.idle;
  bool get isLoading => this == ReqState.loading;
  bool get isSuccess => this == ReqState.success;
  bool get isFailure => this == ReqState.failure;
  bool get isEmpty => this == ReqState.empty;
}
