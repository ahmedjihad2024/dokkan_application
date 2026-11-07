import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/navigation_extension.dart';
import '../../../core/extensions/theme_extensions.dart';
import '../../../core/res/gen/assets.gen.dart';
import '../../../core/res/router/routes.dart';
import '../data/repositories/auth_repository.dart';
import 'widgets/forgot_password_form.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final AuthRepository _authRepository = AuthRepositoryImpl();

  bool _isLoading = false;

  Future<void> _sendResetCode(String email) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });
    try {
      await _authRepository.forgotPassword(email);

      if (!mounted) return;

      context.pushNamed(Routes.recoveryCode, arguments: email);
    } on DioException catch (error) {
      debugPrint('FORGOT PASSWORD STATUS: ${error.response?.statusCode}');
      debugPrint('FORGOT PASSWORD RESPONSE: ${error.response?.data}');
      debugPrint('FORGOT PASSWORD REQUEST: ${error.requestOptions.data}');
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not send the recovery code. Please try again.'),
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
          _isLoading = false;
        });
      }
    }
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
              // Back button + Theme toggle
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
                        child: Assets.svg.iconBack.svg(
                          width: 16.w,
                          height: 16.w,
                          colorFilter: ColorFilter.mode(
                            context.textPrimaryColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 350.ms),

              SizedBox(height: 32.h),

              // Title
              Text(
                    'Forgot Password?',
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
                    'Enter your registered email address to receive a 6-digit recovery code.',
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

              // Email form
              ForgotPasswordForm(
                    onSubmit: _sendResetCode,
                    isLoading: _isLoading,
                  )
                  .animate()
                  .fadeIn(duration: 450.ms, delay: 120.ms)
                  .slideY(begin: 0.06, end: 0, curve: Curves.easeOutCubic),
            ],
          ),
        ),
      ),
    );
  }
}
