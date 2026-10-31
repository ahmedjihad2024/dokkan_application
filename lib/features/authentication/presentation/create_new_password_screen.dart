import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/theme_extensions.dart';
import '../../../core/res/color_manager.dart';
import '../../../core/widgets/buttons/primary_button.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

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

  bool get _hasMinLength => _passwordController.text.length >= 8;

  bool get _hasUppercase => RegExp(r'[A-Z]').hasMatch(_passwordController.text);

  bool get _hasNumber => RegExp(r'[0-9]').hasMatch(_passwordController.text);

  void _resetPassword() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Password reset will be available after backend integration.',
        ),
      ),
    );
  }

  // Simple password requirement style
  Widget _buildSimpleRequirement(String text) {
    const color = Color(0xFF00B889);

    return Row(
      children: [
        Icon(Icons.check, color: color, size: 20.sp),
        SizedBox(width: 8.w),
        Text(
          text,
          style: TextStyle(color: color, fontSize: 14.sp),
        ),
      ],
    );
  }

  InputDecoration _passwordDecoration({
    required String hint,
    required bool isVisible,
    required VoidCallback onToggle,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: context.textSecondaryColor, fontSize: 14.sp),
      filled: true,
      fillColor: context.surfaceElevatedColor,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 17.h),
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
        borderSide: BorderSide(color: ColorM.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      suffixIcon: IconButton(
        onPressed: onToggle,
        icon: Icon(
          isVisible ? Icons.visibility_off : Icons.visibility,
          color: context.textSecondaryColor,
          size: 20.sp,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button and header
                Row(
                  children: [
                    Container(
                      width: 42.w,
                      height: 42.w,
                      decoration: BoxDecoration(
                        color: context.surfaceElevatedColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: context.borderColor),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 17.sp,
                          color: context.textPrimaryColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Password Recovery',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: context.textSecondaryColor,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40.h),

                // Main heading
                Text(
                  'Create New Password',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: context.textPrimaryColor,
                  ),
                ),

                SizedBox(height: 12.h),

                Text(
                  'Your new password must be different from '
                  'your previously used password.',
                  style: TextStyle(
                    fontSize: 14.sp,
                    height: 1.6,
                    color: context.textSecondaryColor,
                  ),
                ),

                SizedBox(height: 32.h),

                // New password
                Text(
                  'New Password',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimaryColor,
                  ),
                ),

                SizedBox(height: 10.h),

                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(
                    color: context.textPrimaryColor,
                    fontSize: 14.sp,
                  ),
                  onChanged: (_) {
                    setState(() {});
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
                      return 'Please enter a new password.';
                    }

                    if (!_hasMinLength || !_hasUppercase || !_hasNumber) {
                      return 'Please meet all password requirements.';
                    }

                    return null;
                  },
                ),

                SizedBox(height: 16.h),

                // Simple password requirements
                _buildSimpleRequirement('At least 8 characters'),

                SizedBox(height: 8.h),

                _buildSimpleRequirement(
                  'Includes uppercase letters and numbers',
                ),

                SizedBox(height: 24.h),

                // Confirm password
                Text(
                  'Confirm Password',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimaryColor,
                  ),
                ),

                SizedBox(height: 10.h),

                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: !_isConfirmPasswordVisible,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                    color: context.textPrimaryColor,
                    fontSize: 14.sp,
                  ),
                  decoration: _passwordDecoration(
                    hint: 'Confirm your new password',
                    isVisible: _isConfirmPasswordVisible,
                    onToggle: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
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
                ),

                SizedBox(height: 40.h),

                // Reset button
                PrimaryButton(
                  title: 'Reset Password & Sign In',
                  onPressed: _resetPassword,
                  height: 52.h,
                  backgroundColor: isDark
                      ? ColorM.primary
                      : const Color(0xFF0F172A),
                  textColor: Colors.white,
                ),

                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
