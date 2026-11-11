import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/network/failure_message.dart';
import '../../../../core/widgets/feedback/custom_snackbar.dart';
import '../cubit/change_password_cubit.dart';
import '../cubit/change_password_state.dart';
import '../widgets/change_password_app_bar.dart';
import '../widgets/change_password_form.dart';
import '../widgets/change_password_header.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ChangePasswordCubit>(),
      child: BlocListener<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccessState) {
            CustomSnackBar.showSuccess(
              context,
              'Password changed successfully',
            );
            Navigator.of(context).pop();
          } else if (state is ChangePasswordErrorState) {
            CustomSnackBar.showError(context, state.failure.message);
          }
        },

        child: Scaffold(
          backgroundColor: context.scaffoldBackgroundColor,
          appBar: const ChangePasswordAppBar(),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ChangePasswordHeader(),
                24.verticalSpace,
                const ChangePasswordForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
