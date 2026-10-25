import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../enums/request_state.dart';
import '../../extensions/theme_extensions.dart';
import '../../res/color_manager.dart';
import '../feedback/app_error_widget.dart';

typedef StateWidgetBuilder = Widget Function(BuildContext context);
typedef ErrorStateWidgetBuilder = Widget Function(
  BuildContext context,
  String? errorMessage,
);

class ReqStateWidget extends StatelessWidget {
  final ReqState state;
  final StateWidgetBuilder onSuccess;
  final StateWidgetBuilder? onLoading;
  final ErrorStateWidgetBuilder? onFailure;
  final StateWidgetBuilder? onEmpty;
  final StateWidgetBuilder? onIdle;
  final String? errorMessage;
  final VoidCallback? onRetry;

  const ReqStateWidget({
    super.key,
    required this.state,
    required this.onSuccess,
    this.onLoading,
    this.onFailure,
    this.onEmpty,
    this.onIdle,
    this.errorMessage,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case ReqState.loading:
        return onLoading?.call(context) ?? _buildDefaultLoading();

      case ReqState.failure:
        return onFailure?.call(context, errorMessage) ??
            _buildDefaultFailure(context);

      case ReqState.empty:
        return onEmpty?.call(context) ?? _buildDefaultEmpty(context);

      case ReqState.idle:
        return onIdle?.call(context) ?? onSuccess(context);

      case ReqState.success:
        return onSuccess(context);
    }
  }

  Widget _buildDefaultLoading() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(ColorM.primary),
      ),
    );
  }

  Widget _buildDefaultFailure(BuildContext context) {
    return AppErrorWidget(message: errorMessage, onRetry: onRetry);
  }

  Widget _buildDefaultEmpty(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.inbox_outlined,
              color: context.textSecondaryColor,
              size: 48.sp,
            ),
            SizedBox(height: 12.h),
            Text(
              'No items available right now',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: context.textSecondaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
