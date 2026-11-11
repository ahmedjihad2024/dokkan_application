import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/navigation_extension.dart';
import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/network/failure_message.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/res/router/routes.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/feedback/custom_snackbar.dart';
import '../../../../core/widgets/forms/app_text_field.dart';
import '../cubit/change_password_cubit.dart';
import '../cubit/change_password_state.dart';

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({super.key});

  String? _validateCurrentPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your current password';
    }
    return null;
  }

  String? _validateNewPassword(String? value) {
    if (value == null || value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value, String newPassword) {
    if (value != newPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChangePasswordCubit>();

    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccessState) {
          CustomSnackBar.showSuccess(context, 'Password changed successfully');
          if (Navigator.canPop(context)) {
            context.pop();
          }
        } else if (state is ChangePasswordErrorState) {
          CustomSnackBar.showError(context, state.failure.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is ChangePasswordLoadingState;
        final hasError = state is ChangePasswordErrorState;

        return Form(
          key: cubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                    label: 'Current Password',
                    hintText: '••••••••••••',
                    controller: cubit.currentPasswordController,
                    isPassword: true,
                    textInputAction: TextInputAction.next,
                    validator: _validateCurrentPassword,
                    fillColor: context.surfaceSubtleColor,
                    borderColor: hasError ? ColorM.danger : context.borderColor,
                  )
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 120.ms)
                  .slideY(
                    begin: 0.08,
                    end: 0,
                    duration: 400.ms,
                    curve: Curves.easeOutCubic,
                  ),
              16.verticalSpace,
              AppTextField(
                    label: 'New Password',
                    hintText: '••••••••••••',
                    controller: cubit.newPasswordController,
                    isPassword: true,
                    textInputAction: TextInputAction.next,
                    validator: _validateNewPassword,
                    fillColor: context.surfaceSubtleColor,
                    borderColor: hasError ? ColorM.danger : context.borderColor,
                  )
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 180.ms)
                  .slideY(
                    begin: 0.08,
                    end: 0,
                    duration: 400.ms,
                    curve: Curves.easeOutCubic,
                  ),
              16.verticalSpace,
              AppTextField(
                    label: 'Confirm New Password',
                    hintText: '••••••••••••',
                    controller: cubit.confirmPasswordController,
                    isPassword: true,
                    textInputAction: TextInputAction.done,
                    validator: (val) => _validateConfirmPassword(
                      val,
                      cubit.newPasswordController.text,
                    ),
                    fillColor: context.surfaceSubtleColor,
                    borderColor: hasError ? ColorM.danger : context.borderColor,
                    onFieldSubmitted: (_) => cubit.changePassword(),
                  )
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 240.ms)
                  .slideY(
                    begin: 0.08,
                    end: 0,
                    duration: 400.ms,
                    curve: Curves.easeOutCubic,
                  ),
              16.verticalSpace,
              PrimaryButton(
                    isLoading: isLoading,
                    onPressed: () => cubit.changePassword(),
                    title: 'Save New Password',
                  )
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 300.ms)
                  .slideY(
                    begin: 0.08,
                    end: 0,
                    duration: 400.ms,
                    curve: Curves.easeOutCubic,
                  )
                  .scale(
                    begin: const Offset(0.98, 0.98),
                    end: const Offset(1, 1),
                    duration: 400.ms,
                    curve: Curves.easeOutCubic,
                  ),
            ],
          ),
        );
      },
    );
  }
}
