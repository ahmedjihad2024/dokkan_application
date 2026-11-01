import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/navigation_extension.dart';
import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/res/router/routes.dart';
import '../../../../core/widgets/buttons/primary_button.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  final String? email;

  const CreateNewPasswordScreen({super.key, this.email});

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

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Password reset successfully! Please sign in with your new password.',
        ),
        backgroundColor: Color(0xFF00B889),
      ),
    );

    context.pushNamedAndRemoveUntil(Routes.login, (route) => false);
  }

  // Interactive password requirement indicator
  Widget _buildRequirementItem({
    required String text,
    required bool isValid,
  }) {
    final bool hasStarted = _hasStartedTyping || _hasAttemptedSubmit;

    final Color color;
    final IconData icon;

    if (!hasStarted) {
      color = context.textSecondaryColor;
      icon = Icons.radio_button_unchecked_rounded;
    } else if (isValid) {
      color = const Color(0xFF00B889);
      icon = Icons.check_circle_rounded;
    } else {
      color = const Color(0xFFEF4444);
      icon = Icons.cancel_rounded;
    }

    return AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 200),
      style: TextStyle(
        color: color,
        fontSize: 14.sp,
        fontWeight: isValid && hasStarted ? FontWeight.w600 : FontWeight.w400,
      ),
      child: Row(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, anim) =>
                ScaleTransition(scale: anim, child: child),
            child: Icon(
              icon,
              key: ValueKey('$text-$hasStarted-$isValid'),
              color: color,
              size: 18.sp,
            ),
          ),
          SizedBox(width: 8.w),
          Text(text),
        ],
      ),
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
                        onPressed: () {
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.pushReplacementNamed(Routes.login);
                          }
                        },
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
                ).animate().fadeIn(duration: 350.ms),

                SizedBox(height: 40.h),

                // Main heading
                Text(
                  'Create New Password',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: context.textPrimaryColor,
                  ),
                )
                    .animate()
                    .fadeIn(duration: 400.ms)
                    .slideY(
                      begin: 0.12,
                      end: 0,
                      curve: Curves.easeOutCubic,
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
                )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 60.ms)
                    .slideY(
                      begin: 0.12,
                      end: 0,
                      curve: Curves.easeOutCubic,
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
                )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 100.ms)
                    .slideY(
                      begin: 0.06,
                      end: 0,
                      curve: Curves.easeOutCubic,
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
                  onChanged: (val) {
                    setState(() {
                      if (!_hasStartedTyping && val.isNotEmpty) {
                        _hasStartedTyping = true;
                      }
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
                      return 'Please enter a new password.';
                    }

                    if (!_hasMinLength || !_hasUppercase || !_hasNumber) {
                      return 'Please meet all password requirements.';
                    }

                    return null;
                  },
                )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 120.ms)
                    .slideY(
                      begin: 0.06,
                      end: 0,
                      curve: Curves.easeOutCubic,
                    ),

                SizedBox(height: 16.h),

                // Interactive password requirements
                _buildRequirementItem(
                  text: 'At least 8 characters',
                  isValid: _hasMinLength,
                )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 140.ms),

                SizedBox(height: 8.h),

                _buildRequirementItem(
                  text: 'Includes uppercase letters and numbers',
                  isValid: _hasUppercase && _hasNumber,
                )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 160.ms),

                SizedBox(height: 24.h),

                // Confirm password
                Text(
                  'Confirm Password',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimaryColor,
                  ),
                )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 180.ms)
                    .slideY(
                      begin: 0.06,
                      end: 0,
                      curve: Curves.easeOutCubic,
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
                  onChanged: (_) {
                    setState(() {});
                  },
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
                )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 200.ms)
                    .slideY(
                      begin: 0.06,
                      end: 0,
                      curve: Curves.easeOutCubic,
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
                )
                    .animate()
                    .fadeIn(duration: 450.ms, delay: 220.ms)
                    .slideY(
                      begin: 0.12,
                      end: 0,
                      curve: Curves.easeOutCubic,
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
