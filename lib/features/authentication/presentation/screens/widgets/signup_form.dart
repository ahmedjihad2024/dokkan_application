import 'package:animated_visibility/animated_visibility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/extensions/theme_extensions.dart';
import '../../../../../core/res/color_manager.dart';
import '../../../../../core/widgets/forms/app_text_field.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key, required this.onContinue});

  final void Function(
    String firstName,
    String lastName,
    String email,
    String password,
  ) onContinue;

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _errorMessage;
  bool _hasError = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) return 'This field is required';
    if (name.length < 2) return 'Enter at least 2 characters';
    return null;
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Please enter your email address';

    final emailPattern = RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$');
    if (!emailPattern.hasMatch(email)) return 'Check your email spelling';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password must be at least 8 characters';
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != _passwordController.text) return 'Passwords do not match';
    return null;
  }

  void _submitForm() {
    FocusScope.of(context).unfocus();

    final form = _formKey.currentState;
    if (form == null) return;

    if (_passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty &&
        _passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _hasError = true;
        _errorMessage = 'Passwords do not match. Please verify.';
      });
      return;
    }

    final isValid = form.validate();
    if (!isValid) {
      setState(() {
        _hasError = true;
        _errorMessage = _passwordController.text != _confirmPasswordController.text
            ? 'Passwords do not match. Please verify.'
            : 'Please complete all fields correctly.';
      });
      return;
    }

    setState(() {
      _hasError = false;
      _errorMessage = null;
    });

    widget.onContinue(
      _firstNameController.text.trim(),
      _lastNameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text,
    );
  }

  void _clearErrorIfPresent() {
    if (_hasError) {
      setState(() {
        _hasError = false;
        _errorMessage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Animated Error Banner matching Figma 37:2148 / 37:2197
          AnimatedVisibility(
            visible: _hasError && _errorMessage != null,
            enter: fadeIn(curve: Curves.easeOut) +
                expandVertically(curve: Curves.easeOut),
            exit: fadeOut(curve: Curves.easeIn) +
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
                    color: isDark ? const Color(0xFF7F1D1D) : const Color(0xFFF87171),
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
                        _errorMessage ?? '',
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

          // First Name and Last Name Row
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  label: 'First Name',
                  hintText: 'Alexander',
                  controller: _firstNameController,
                  validator: _validateName,
                  textInputAction: TextInputAction.next,
                  fillColor: context.surfaceSubtleColor,
                  borderColor: _hasError ? ColorM.danger : context.borderColor,
                  onChanged: (_) => _clearErrorIfPresent(),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: AppTextField(
                  label: 'Last Name',
                  hintText: 'Mansour',
                  controller: _lastNameController,
                  validator: _validateName,
                  textInputAction: TextInputAction.next,
                  fillColor: context.surfaceSubtleColor,
                  borderColor: _hasError ? ColorM.danger : context.borderColor,
                  onChanged: (_) => _clearErrorIfPresent(),
                ),
              ),
            ],
          ),

          SizedBox(height: 18.h),

          // Email Input
          AppTextField(
            label: 'Email Address',
            hintText: 'alex@example.com',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: _validateEmail,
            fillColor: context.surfaceSubtleColor,
            borderColor: _hasError ? ColorM.danger : context.borderColor,
            onChanged: (_) => _clearErrorIfPresent(),
          ),

          SizedBox(height: 18.h),

          // Password Input
          AppTextField(
            label: 'Password',
            hintText: '••••••••••••',
            controller: _passwordController,
            isPassword: true,
            textInputAction: TextInputAction.next,
            validator: _validatePassword,
            fillColor: context.surfaceSubtleColor,
            borderColor: _hasError ? ColorM.danger : context.borderColor,
            onChanged: (_) => _clearErrorIfPresent(),
          ),

          SizedBox(height: 18.h),

          // Confirm Password Input
          AppTextField(
            label: 'Confirm Password',
            hintText: '••••••••••••',
            controller: _confirmPasswordController,
            isPassword: true,
            textInputAction: TextInputAction.done,
            validator: _validateConfirmPassword,
            fillColor: context.surfaceSubtleColor,
            borderColor: _hasError ? ColorM.danger : context.borderColor,
            onChanged: (_) => _clearErrorIfPresent(),
            onFieldSubmitted: (_) => _submitForm(),
          ),

          SizedBox(height: 10.h),

          // Verification note matching Figma 37:1984 / 37:2028
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ⓘ',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: ColorM.primaryDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 5.w),
              Expanded(
                child: Text(
                  'A 6-digit verification code will be sent to your email.',
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    color: ColorM.primaryDark,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 24.h),

          // Continue to Verification Button matching Figma 37:1984 / 37:2028 (52h, 14r, ColorM.primaryDark)
          SizedBox(
            height: 52.h,
            child: ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorM.primaryDark,
                foregroundColor: ColorM.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Continue to Verification',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 18.sp,
                    color: ColorM.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
