import 'dart:async';

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
import '../../../../core/widgets/forms/app_otp_field.dart';
import '../cubit/auth_cubit.dart';

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
    context.read<AuthCubit>().resendOtp(email: widget.email);
  }

  void _verifyCode() {
    FocusScope.of(context).unfocus();

    if (widget.email.isEmpty) {
      CustomSnackBar.showError(context, 'Email address is missing.');
      return;
    }
    if (_recoveryCode.length != 6) {
      CustomSnackBar.showError(
        context,
        'Please enter the complete 6-digit recovery code.',
      );
      return;
    }

    context.read<AuthCubit>().validateOtp(
      email: widget.email,
      otp: _recoveryCode,
    );
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

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthValidateOtpSuccess) {
          context.pushNamed(
            Routes.createNewPassword,
            arguments: {'email': state.email, 'otp': state.otp},
          );
        }
        if (state is AuthResendOtpSuccess) {
          CustomSnackBar.showSuccess(
            context,
            'A new recovery code has been requested.',
          );
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
                              context.pushReplacementNamed(Routes.forgotPassword);
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
                              color: primaryTextColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).animate().fadeIn(duration: 350.ms),

                  SizedBox(height: 32.h),

                  // Title
                  Text(
                        'Enter Recovery Code',
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w700,
                          color: primaryTextColor,
                          letterSpacing: -0.5,
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .slideY(begin: 0.12, end: 0, curve: Curves.easeOutCubic),

                  SizedBox(height: 8.h),

                  // Description
                  Text(
                        widget.email.isNotEmpty
                            ? 'We have sent a 6-digit recovery code to ${widget.email}. Enter it below to proceed.'
                            : 'Enter the 6-digit recovery code sent to your email.',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: secondaryTextColor,
                          height: 1.5,
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 400.ms, delay: 60.ms)
                      .slideY(begin: 0.12, end: 0, curve: Curves.easeOutCubic),

                  SizedBox(height: 32.h),

                  // OTP input
                  AppOtpField(
                    length: 6,
                    onChanged: (value) {
                      setState(() {
                        _recoveryCode = value;
                      });
                    },
                    onCompleted: (value) {
                      setState(() {
                        _recoveryCode = value;
                      });
                      _verifyCode();
                    },
                  )
                      .animate()
                      .fadeIn(duration: 450.ms, delay: 120.ms)
                      .slideY(begin: 0.06, end: 0, curve: Curves.easeOutCubic),

                  SizedBox(height: 24.h),

                  // Resend code row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Didn't receive the code?",
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: secondaryTextColor,
                        ),
                      ),
                      TextButton(
                        onPressed: (_remainingSeconds == 0 && !isLoading)
                            ? _resendCode
                            : null,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          isLoading ? 'Sending...' : 'Resend Now',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorM.primary,
                          ),
                        ),
                      ),
                    ],
                  ).animate().fadeIn(duration: 400.ms, delay: 150.ms),

                  SizedBox(height: 6.h),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      _remainingSeconds > 0
                          ? 'Resend available in $_formattedTime'
                          : 'You can request a new code now.',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: secondaryTextColor,
                      ),
                    ),
                  ).animate().fadeIn(duration: 400.ms, delay: 180.ms),

                  SizedBox(height: 36.h),

                  // Verify button
                  PrimaryButton(
                    title: 'Verify Code',
                    onPressed: isLoading ? () {} : _verifyCode,
                    isLoading: isLoading,
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
      },
    );
  }
}
