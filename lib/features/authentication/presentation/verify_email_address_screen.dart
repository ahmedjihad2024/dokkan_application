import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/navigation_extension.dart';
import '../../../core/extensions/theme_extensions.dart';
import '../../../core/res/color_manager.dart';
import '../../../core/res/router/routes.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/forms/app_otp_field.dart';

class VerifyEmailAddressScreen extends StatefulWidget {
  final String email;

  const VerifyEmailAddressScreen({super.key, required this.email});

  @override
  State<VerifyEmailAddressScreen> createState() =>
      _VerifyEmailAddressScreenState();
}

class _VerifyEmailAddressScreenState extends State<VerifyEmailAddressScreen> {
  static const int _initialSeconds = 60;

  int _remainingSeconds = _initialSeconds;
  String _verificationCode = '';
  bool _hasError = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        timer.cancel();
      }
    });
  }

  void _resendCode() {
    if (_remainingSeconds > 0) return;

    setState(() {
      _remainingSeconds = _initialSeconds;
      _verificationCode = '';
      _hasError = false;
    });

    _startCountdown();

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

    if (_verificationCode.length != 6) {
      setState(() => _hasError = true);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the complete 6-digit code.'),
        ),
      );
      return;
    }

    setState(() => _hasError = false);

    Navigator.pushNamed(context, Routes.recoveryCode);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button and screen header
              Row(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => context.pop(),
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

                  SizedBox(width: 12.w),

                  Text(
                    'Verification',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: context.textPrimaryColor,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 28.h),

              // Title
              Text(
                'Verify Email Address',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  color: context.textPrimaryColor,
                  letterSpacing: -0.5,
                ),
              ),

              SizedBox(height: 8.h),

              // Description
              Text(
                'We sent a 6-digit confirmation code to',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: context.textSecondaryColor,
                  height: 1.5,
                ),
              ),

              SizedBox(height: 4.h),

              // Email address
              Text(
                widget.email,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: context.textPrimaryColor,
                ),
              ),

              SizedBox(height: 24.h),

              // OTP input
              AppOtpField(
                length: 6,
                hasError: _hasError,
                onChanged: (code) {
                  setState(() {
                    _verificationCode = code;
                    _hasError = false;
                  });
                },
              ),

              SizedBox(height: 16.h),

              // Resend code
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: _remainingSeconds == 0 ? _resendCode : null,
                  child: Text(
                    'Resend Now',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: _remainingSeconds == 0
                          ? ColorM.primaryDark
                          : ColorM.primaryDark.withValues(alpha: 0.65),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 8.h),

              // Countdown
              if (_remainingSeconds > 0)
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Resend code in 00:${_remainingSeconds.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: context.textSecondaryColor,
                    ),
                  ),
                ),

              SizedBox(height: 24.h),

              // Verify button
              PrimaryButton(
                title: 'Verify & Proceed',
                onPressed: _verifyCode,
                height: 52.h,
                backgroundColor: context.isDark
                    ? ColorM.primary
                    : const Color(0xFF0F172A),
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
