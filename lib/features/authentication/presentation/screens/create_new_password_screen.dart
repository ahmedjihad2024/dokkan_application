import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/navigation_extension.dart';
import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/res/router/routes.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/feedback/custom_snackbar.dart';
import '../cubit/auth_cubit.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  final String? email;
  final String otp;
  const CreateNewPasswordScreen({super.key, this.email, this.otp = ''});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _hasStartedTyping = false;
  bool _hasAttemptedSubmit = false;

  bool get _hasMinLength => _passwordController.text.length >= 8;

  bool get _hasUppercase => RegExp(r'[A-Z]').hasMatch(_passwordController.text);

  bool get _hasNumber => RegExp(r'[0-9]').hasMatch(_passwordController.text);

  void _resetPassword() {
    FocusScope.of(context).unfocus();

    setState(() {
      _hasAttemptedSubmit = true;
    });

    if (!_formKey.currentState!.validate()) return;

    if (widget.email == null || widget.email!.isEmpty || widget.otp.isEmpty) {
      CustomSnackBar.showError(
        context,
        'Recovery information is missing. Please try again.',
      );
      return;
    }

    context.read<AuthCubit>().resetPassword(
      email: widget.email!,
      otp: widget.otp,
      newPassword: _passwordController.text,
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  InputDecoration _passwordDecoration({
    required String hint,
    required bool isVisible,
    required VoidCallback onToggle,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: context.textMutedColor,
        fontSize: 14.sp,
      ),
      filled: true,
      fillColor: context.surfaceSubtleColor,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: context.borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: context.borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: ColorM.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: ColorM.danger),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: ColorM.danger, width: 1.5),
      ),
      suffixIcon: IconButton(
        icon: Icon(
          isVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: context.textMutedColor,
          size: 20.sp,
        ),
        onPressed: onToggle,
      ),
    );
  }

  Widget _buildRequirement(String text, bool isMet) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
          color: isMet ? const Color(0xFF00B889) : context.textMutedColor,
          size: 16.sp,
        ),
        SizedBox(width: 8.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 12.sp,
            color: isMet ? context.textPrimaryColor : context.textMutedColor,
            fontWeight: isMet ? FontWeight.w500 : FontWeight.w400,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthResetPasswordSuccess) {
          CustomSnackBar.showSuccess(
            context,
            'Password reset successfully! Please sign in with your new password.',
          );
          context.pushNamedAndRemoveUntil(Routes.login, (route) => false);
        }
        if (state is AuthFailure) {
          CustomSnackBar.showError(context, state.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Scaffold(
          backgroundColor: context.scaffoldBackgroundColor,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              if (context.canPop()) {
                                context.pop();
                              } else {
                                context.pushReplacementNamed(Routes.login);
                              }
                            },
                            borderRadius: BorderRadius.circular(19.r),
                            child: Container(
                              width: 38.w,
                              height: 38.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: context.surfaceSubtleColor,
                                shape: BoxShape.circle,
                                border: Border.all(color: context.borderColor),
                              ),
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 16.sp,
                                color: context.textPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ).animate().fadeIn(duration: 350.ms),

                    SizedBox(height: 32.h),

                    // Title
                    Text(
                          'Create New Password',
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w700,
                            color: context.textPrimaryColor,
                            letterSpacing: -0.5,
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 400.ms)
                        .slideY(begin: 0.12, end: 0, curve: Curves.easeOutCubic),

                    SizedBox(height: 8.h),

                    // Description
                    Text(
                          'Your new password must be unique from previously used passwords for security.',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: context.textSecondaryColor,
                            height: 1.5,
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 400.ms, delay: 60.ms)
                        .slideY(begin: 0.12, end: 0, curve: Curves.easeOutCubic),

                    SizedBox(height: 32.h),

                    // Password label
                    Text(
                      'New Password',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: context.textPrimaryColor,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // New password field
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                        color: context.textPrimaryColor,
                        fontSize: 14.sp,
                      ),
                      onChanged: (_) {
                        setState(() {
                          _hasStartedTyping = true;
                        });
                      },
                      decoration: _passwordDecoration(
                        hint: 'Enter your new password',
                        isVisible: _isPasswordVisible,
                        onToggle: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password.';
                        }

                        if (!_hasMinLength || !_hasUppercase || !_hasNumber) {
                          return 'Password does not meet all requirements.';
                        }

                        return null;
                      },
                    )
                        .animate()
                        .fadeIn(duration: 400.ms, delay: 100.ms)
                        .slideY(begin: 0.06, end: 0, curve: Curves.easeOutCubic),

                    SizedBox(height: 14.h),

                    // Password requirements checklist
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: (_hasStartedTyping || _hasAttemptedSubmit) ? 1.0 : 0.6,
                      child: Container(
                        padding: EdgeInsets.all(14.w),
                        decoration: BoxDecoration(
                          color: context.surfaceSubtleColor,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: context.borderColor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Password Requirements:',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: context.textPrimaryColor,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            _buildRequirement(
                              'At least 8 characters long',
                              _hasMinLength,
                            ),
                            SizedBox(height: 6.h),
                            _buildRequirement(
                              'Contains an uppercase letter',
                              _hasUppercase,
                            ),
                            SizedBox(height: 6.h),
                            _buildRequirement(
                              'Contains at least one number',
                              _hasNumber,
                            ),
                          ],
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 400.ms, delay: 150.ms)
                        .slideY(begin: 0.06, end: 0, curve: Curves.easeOutCubic),

                    SizedBox(height: 20.h),

                    // Confirm password label
                    Text(
                      'Confirm Password',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: context.textPrimaryColor,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // Confirm password field
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: !_isConfirmPasswordVisible,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(
                        color: context.textPrimaryColor,
                        fontSize: 14.sp,
                      ),
                      onChanged: (_) {
                        setState(() {});
                      },
                      decoration: _passwordDecoration(
                        hint: 'Confirm your new password',
                        isVisible: _isConfirmPasswordVisible,
                        onToggle: () {
                          setState(() {
                            _isConfirmPasswordVisible =
                                !_isConfirmPasswordVisible;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password.';
                        }

                        if (value != _passwordController.text) {
                          return 'Passwords do not match.';
                        }

                        return null;
                      },
                    )
                        .animate()
                        .fadeIn(duration: 400.ms, delay: 200.ms)
                        .slideY(begin: 0.06, end: 0, curve: Curves.easeOutCubic),

                    SizedBox(height: 40.h),

                    // Reset button
                    PrimaryButton(
                      title: 'Reset Password & Sign In',
                      onPressed: isLoading ? () {} : _resetPassword,
                      isLoading: isLoading,
                      height: 52.h,
                      backgroundColor: isDark
                          ? ColorM.primary
                          : const Color(0xFF0F172A),
                      textColor: Colors.white,
                    )
                        .animate()
                        .fadeIn(duration: 450.ms, delay: 220.ms)
                        .slideY(begin: 0.12, end: 0, curve: Curves.easeOutCubic),

                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
