import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/navigation_extension.dart';
import '../../../core/extensions/theme_extensions.dart';
import '../../../core/res/color_manager.dart';
import '../../../core/res/router/routes.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/forms/app_otp_field.dart';

import '../data/repositories/auth_repository.dart';

class EnterRecoveryCodeScreen extends StatefulWidget {
  final String email;

  const EnterRecoveryCodeScreen({super.key, this.email = ''});

  @override
  State<EnterRecoveryCodeScreen> createState() =>
      _EnterRecoveryCodeScreenState();
}

class _EnterRecoveryCodeScreenState extends State<EnterRecoveryCodeScreen> {
  static const int _initialSeconds = 60;

  final AuthRepository _authRepository = AuthRepositoryImpl();

  bool _isVerifying = false;

  bool _isResending = false;

  int _remainingSeconds = _initialSeconds;
  String _recoveryCode = '';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> _resendCode() async {
    if (_remainingSeconds > 0 || _isResending) return;

    setState(() {
      _isResending = true;
    });

    try {
      await _authRepository.resendOtp(widget.email);

      if (!mounted) return;

      setState(() {
        _remainingSeconds = _initialSeconds;
        _recoveryCode = '';
      });

      _startTimer();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('A new recovery code has been requested.'),
        ),
      );
    } on DioException catch (error) {
      debugPrint('RESEND OTP STATUS: ${error.response?.statusCode}');
      debugPrint('RESEND OTP RESPONSE: ${error.response?.data}');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not resend the code. Please try again.'),
        ),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong. Please try again.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isResending = false;
        });
      }
    }
  }

  Future<void> _verifyCode() async {
    if (_isResending || _isVerifying) return;
    FocusScope.of(context).unfocus();

    if (widget.email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email address is missing.')),
      );
      return;
    }
    if (_recoveryCode.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the complete recovery code.'),
        ),
      );
      return;
    }

    setState(() {
      _isVerifying = true;
    });

    try {
      await _authRepository.validateOtp(widget.email, _recoveryCode);

      if (!mounted) return;

      context.pushNamed(
        Routes.createNewPassword,
        arguments: {'email': widget.email, 'otp': _recoveryCode},
      );
    } on DioException catch (error) {
      debugPrint('OTP STATUS: ${error.response?.statusCode}');
      debugPrint('OTP RESPONSE: ${error.response?.data}');
      debugPrint('OTP REQUEST: ${error.requestOptions.data}');
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid or expired recovery code. Please try again.'),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong. Please try again.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isVerifying = false;
        });
      }
    }
  }

  String get _formattedTime {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    final primaryTextColor = context.textPrimaryColor;
    final secondaryTextColor = context.textSecondaryColor;

    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button and screen label
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
                          context.pushReplacementNamed(Routes.forgotPassword);
                        }
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 17.sp,
                        color: primaryTextColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Recovery Code',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: secondaryTextColor,
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 350.ms),

              SizedBox(height: 36.h),

              // Main heading
              Text(
                    'Enter Recovery Code',
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: primaryTextColor,
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.12, end: 0, curve: Curves.easeOutCubic),

              SizedBox(height: 12.h),

              // Description
              Text(
                    'Please enter the 6-digit recovery code to continue resetting your password.',
                    style: TextStyle(
                      fontSize: 14.sp,
                      height: 1.6,
                      color: secondaryTextColor,
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 60.ms)
                  .slideY(begin: 0.12, end: 0, curve: Curves.easeOutCubic),

              if (widget.email.isNotEmpty) ...[
                SizedBox(height: 8.h),
                Text(
                      widget.email,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: primaryTextColor,
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 90.ms)
                    .slideY(begin: 0.12, end: 0, curve: Curves.easeOutCubic),
              ],

              SizedBox(height: 36.h),

              // OTP field
              AppOtpField(
                    length: 6,
                    onChanged: (value) {
                      setState(() {
                        _recoveryCode = value;
                      });
                    },
                  )
                  .animate()
                  .fadeIn(duration: 450.ms, delay: 120.ms)
                  .slideY(begin: 0.06, end: 0, curve: Curves.easeOutCubic),

              SizedBox(height: 24.h),

              // Resend code
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Didn't receive the code?",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: secondaryTextColor,
                      ),
                    ),
                    TextButton(
                      onPressed: _remainingSeconds == 0 && !_isResending
                          ? _resendCode
                          : null,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.only(left: 6.w),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        _isResending ? 'Sending...' : 'Resend Now',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorM.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms, delay: 150.ms),

              SizedBox(height: 6.h),

              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  _remainingSeconds > 0
                      ? 'Resend available in $_formattedTime'
                      : 'You can request a new code now.',
                  style: TextStyle(fontSize: 12.sp, color: secondaryTextColor),
                ),
              ).animate().fadeIn(duration: 400.ms, delay: 180.ms),

              SizedBox(height: 36.h),

              // Verify button
              PrimaryButton(
                    title: 'Verify Code',
                    onPressed: _verifyCode,
                    isLoading: _isVerifying,
                    height: 52.h,
                    backgroundColor: isDark
                        ? ColorM.primary
                        : const Color(0xFF0F172A),
                    textColor: Colors.white,
                  )
                  .animate()
                  .fadeIn(duration: 450.ms, delay: 200.ms)
                  .slideY(begin: 0.12, end: 0, curve: Curves.easeOutCubic),

              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }
}
