import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/forms/app_text_field.dart';

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
      return 'Password must be at least 8 characters';
    }

    return null;
  }

  void _submitForm() {
    FocusScope.of(context).unfocus();

    final form = _formKey.currentState;

    if (form == null || !form.validate()) {
      setState(() => _showLoginError = false);
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
          if (_showLoginError) ...[
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: isDark
                    ? ColorM.dangerContainerDark
                    : ColorM.dangerContainerLight,
                border: Border.all(color: ColorM.danger),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: ColorM.danger,
                    size: 18,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Invalid email or password. Please try again.',
                      style: TextStyle(color: ColorM.danger, fontSize: 12.sp),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
          ],
          AppTextField(
            label: 'Email Address',
            hintText: 'alex@example.com',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            prefixIcon: Icon(
              Icons.email_outlined,
              color: context.textSecondaryColor,
            ),
            validator: _validateEmail,
            borderColor: _showLoginError ? ColorM.danger : null,
            onChanged: (_) {
              if (_showLoginError) {
                setState(() => _showLoginError = false);
              }
            },
          ),
          SizedBox(height: 20.h),
          AppTextField(
            label: 'Password',
            hintText: 'Enter your password',
            controller: _passwordController,
            isPassword: true,
            textInputAction: TextInputAction.done,
            prefixIcon: Icon(
              Icons.lock_outline,
              color: context.textSecondaryColor,
            ),
            validator: _validatePassword,
            borderColor: _showLoginError ? ColorM.danger : null,
            onChanged: (_) {
              if (_showLoginError) {
                setState(() => _showLoginError = false);
              }
            },
            onFieldSubmitted: (_) => _submitForm(),
          ),
          SizedBox(height: 8.h),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: widget.onForgotPassword,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  color: isDark ? ColorM.primaryLight : ColorM.primary,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          PrimaryButton(
            title: 'Sign In',
            onPressed: _submitForm,
            height: 48.h,
            backgroundColor: isDark ? Colors.white : ColorM.black,
            textColor: isDark ? Colors.black : Colors.white,
          ),
        ],
      ),
    );
  }
}
