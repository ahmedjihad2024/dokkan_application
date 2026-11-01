import 'package:animated_visibility/animated_visibility.dart';
import 'package:dokkan/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/extensions/theme_extensions.dart';
import '../../../../../core/res/color_manager.dart';
import '../../../../../core/widgets/forms/app_text_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.onSignIn,
    required this.onForgotPassword,
  });

  final void Function(String email, String password) onSignIn;
  final VoidCallback onForgotPassword;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _showLoginError = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) {
      return 'Please enter your email address';
    }
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(email)) {
      return 'Check your email spelling';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Incorrect password';
    }
    return null;
  }

  void _submitForm() {
    FocusScope.of(context).unfocus();
    final form = _formKey.currentState;
    if (form == null || !form.validate()) {
      setState(() => _showLoginError = true);
      return;
    }
    setState(() => _showLoginError = false);
    widget.onSignIn(_emailController.text.trim(), _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Animated Error Banner matching Figma 37:2074 / 37:2110
          AnimatedVisibility(
            visible: _showLoginError,
            enter:
                fadeIn(curve: Curves.easeOut) +
                expandVertically(curve: Curves.easeOut),
            exit:
                fadeOut(curve: Curves.easeIn) +
                shrinkVertically(curve: Curves.easeIn),
            enterDuration: const Duration(milliseconds: 150),
            exitDuration: const Duration(milliseconds: 125),
            child: Padding(
              padding: EdgeInsets.only(bottom: 18.h),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: context.dangerContainerColor,
                  border: Border.all(
                    color: isDark
                        ? const Color(0xFF7F1D1D)
                        : const Color(0xFFF87171),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.warning_amber_rounded,
                      color: ColorM.danger,
                      size: 20,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        'Invalid email or password. Please try again.',
                        style: TextStyle(
                          color: ColorM.danger,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Email Input (clean without prefix icons matching Figma)
          AppTextField(
            label: 'Email Address',
            hintText: 'alex@example.com',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: _validateEmail,
            fillColor: context.surfaceSubtleColor,
            borderColor: _showLoginError ? ColorM.danger : context.borderColor,
            onChanged: (_) {
              if (_showLoginError) {
                setState(() => _showLoginError = false);
              }
            },
          ),

          SizedBox(height: 18.h),

          // Password Input (clean with suffix eye toggle matching Figma)
          AppTextField(
            label: 'Password',
            hintText: '••••••••••••',
            controller: _passwordController,
            isPassword: true,
            textInputAction: TextInputAction.done,
            validator: _validatePassword,
            fillColor: context.surfaceSubtleColor,
            borderColor: _showLoginError ? ColorM.danger : context.borderColor,
            onChanged: (_) {
              if (_showLoginError) {
                setState(() => _showLoginError = false);
              }
            },
            onFieldSubmitted: (_) => _submitForm(),
          ),

          SizedBox(height: 10.h),

          // Forgot Password link (right-aligned in ColorM.primaryDark)
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: widget.onForgotPassword,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: ColorM.primaryDark,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 20.h),

          // Sign In Button matching Figma 37:1922 / 37:1952 (52h, radius 14r)
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return SizedBox(
                height: 52.h,
                child: ElevatedButton(
                  onPressed: state is AuthLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark
                        ? ColorM.textPrimaryDark
                        : ColorM.textPrimaryLight,
                    foregroundColor: isDark
                        ? ColorM.textPrimaryLight
                        : ColorM.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  child: state is AuthLoading
                      ? SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              ColorM.primary,
                            ),
                          ),
                      )
                      : Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.2,
                          ),
                        ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
