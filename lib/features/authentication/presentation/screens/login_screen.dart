import 'package:animated_visibility/animated_visibility.dart';
import 'package:dokkan/core/widgets/feedback/custom_snackbar.dart';
import 'package:dokkan/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/navigation_extension.dart';
import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/res/router/routes.dart';
import 'widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _infoMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.pushNamedAndRemoveUntil(Routes.home, (route) => false);
          }

          if (state is AuthFailure) {
            CustomSnackBar.showError(
              context,
              state.message,
              duration: const Duration(seconds: 5),
            );
          }

          if (state is AuthResendOtpSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));

            context.pushNamed(
              Routes.verifyEmailAddress,
              arguments: state.email,
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 28.h),

                // Title matching Figma (size 28sp Bold)
                Text(
                      'Welcome Back',
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

                // Subtitle matching Figma (size 14sp Regular)
                Text(
                      'Sign in to access your curated accessories',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: context.textSecondaryColor,
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 60.ms)
                    .slideY(begin: 0.12, end: 0, curve: Curves.easeOutCubic),

                SizedBox(height: 24.h),

                // Animated On-Screen Message Banner
                AnimatedVisibility(
                  visible: _infoMessage != null,
                  enter:
                      fadeIn(curve: Curves.easeOut) +
                      expandVertically(curve: Curves.easeOut),
                  exit:
                      fadeOut(curve: Curves.easeIn) +
                      shrinkVertically(curve: Curves.easeIn),
                  enterDuration: const Duration(milliseconds: 150),
                  exitDuration: const Duration(milliseconds: 125),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: context.surfaceSubtleColor,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: ColorM.primaryDark.withValues(alpha: 0.35),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: ColorM.primaryDark,
                            size: 20.sp,
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Text(
                              _infoMessage ?? '',
                              style: TextStyle(
                                color: context.textPrimaryColor,
                                fontSize: 12.5.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.close_rounded,
                              size: 18.sp,
                              color: context.textSecondaryColor,
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () {
                              setState(() => _infoMessage = null);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Login Form
                LoginForm(
                      onSignIn: (email, password) {
                        context.read<AuthCubit>().login(
                          email: email,
                          password: password,
                        );
                      },
                      onForgotPassword: () {
                        context.pushNamed(Routes.forgotPassword);
                      },
                    )
                    .animate()
                    .fadeIn(duration: 450.ms, delay: 120.ms)
                    .slideY(begin: 0.06, end: 0, curve: Curves.easeOutCubic),

                SizedBox(height: 32.h),

                // Bottom Account Switcher matching Figma (Don't have an account? Register)
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: context.textSecondaryColor,
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          context.pushNamed(Routes.register);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 8.h,
                          ),
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: ColorM.primaryDark,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 400.ms, delay: 200.ms),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
