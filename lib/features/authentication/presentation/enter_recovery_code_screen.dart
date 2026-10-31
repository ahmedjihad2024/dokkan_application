import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/theme_extensions.dart';
import '../../../core/res/color_manager.dart';
import '../../../core/res/router/routes.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/forms/app_otp_field.dart';

class EnterRecoveryCodeScreen extends StatefulWidget {
  final String email;

  const EnterRecoveryCodeScreen({super.key, this.email = ''});

  @override
  State<EnterRecoveryCodeScreen> createState() =>
      _EnterRecoveryCodeScreenState();
}

class _EnterRecoveryCodeScreenState extends State<EnterRecoveryCodeScreen> {
  static const int _initialSeconds = 60;

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

  void _resendCode() {
    if (_remainingSeconds > 0) return;

    setState(() {
      _remainingSeconds = _initialSeconds;
      _recoveryCode = '';
    });

    _startTimer();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Code delivery will be available after backend integration.',
        ),
      ),
    );
  }

  void _verifyCode() {
    FocusScope.of(context).unfocus();

    if (_recoveryCode.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the complete recovery code.'),
        ),
      );
      return;
    }

    Navigator.pushNamed(context, Routes.createNewPassword);
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
        child: Padding(
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
                      onPressed: () => Navigator.pop(context),
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
              ),

              SizedBox(height: 40.h),

              // Main heading
              Text(
                'Enter Recovery Code',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: primaryTextColor,
                ),
              ),

              SizedBox(height: 12.h),

              // Description
              Text(
                'Please enter the 6-digit recovery code '
                'to continue resetting your password.',
                style: TextStyle(
                  fontSize: 14.sp,
                  height: 1.6,
                  color: secondaryTextColor,
                ),
              ),

              if (widget.email.isNotEmpty) ...[
                SizedBox(height: 8.h),
                Text(
                  widget.email,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: primaryTextColor,
                  ),
                ),
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
              ),

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
                      onPressed: _remainingSeconds == 0 ? _resendCode : null,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.only(left: 6.w),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Resend Now',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorM.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 6.h),

              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  _remainingSeconds > 0
                      ? 'Resend available in $_formattedTime'
                      : 'You can request a new code now.',
                  style: TextStyle(fontSize: 12.sp, color: secondaryTextColor),
                ),
              ),

              SizedBox(height: 100.h),

              SizedBox(height: 40.h),
              // Verify button
              PrimaryButton(
                title: 'Verify Code',
                onPressed: _verifyCode,
                height: 52.h,
                backgroundColor: isDark
                    ? ColorM.primary
                    : const Color(0xFF0F172A),
                textColor: Colors.white,
              ),

              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }
}
