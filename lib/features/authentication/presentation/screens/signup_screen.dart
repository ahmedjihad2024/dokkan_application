import 'package:animated_visibility/animated_visibility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/navigation_extension.dart';
import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/res/gen/assets.gen.dart';
import '../../../../core/res/router/routes.dart';
import '../cubit/auth_cubit.dart';
import 'widgets/signup_form.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String? _infoMessage;
  String? _registeredEmail;

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
              // Circular Back Button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    if (context.canPop()) {
                      context.pop();
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
                      border: Border.all(color: context.borderColor, width: 1),
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
              ).animate().fadeIn(duration: 350.ms),

              SizedBox(height: 28.h),

              // Title
              Text(
                    'Create Account',
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

              // Subtitle
              Text(
                    'Join Dokkan to explore exclusive collections',
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
                          Icons.check_circle_outline_rounded,
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

              // Sign Up Form + API Integration
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthRegisterSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: const Color(0xFF00B889),
                      ),
                    );

                    context.pushNamed(
                      Routes.verifyEmailAddress,
                      arguments: _registeredEmail,
                    );
                  }

                  if (state is AuthFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: ColorM.danger,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return SignupForm(
                        onContinue: (firstName, lastName, email, password) {
                          _registeredEmail = email;

                          context.read<AuthCubit>().register(
                            firstName: firstName,
                            lastName: lastName,
                            email: email,
                            password: password,
                          );
                        },
                      )
                      .animate()
                      .fadeIn(duration: 450.ms, delay: 120.ms)
                      .slideY(
                        begin: 0.06,
                        end: 0,
                        curve: Curves.easeOutCubic,
                      );
                },
              ),

              SizedBox(height: 28.h),

              // Bottom Account Switcher
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: context.textSecondaryColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pushReplacementNamed(Routes.login);
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: ColorM.primaryDark,
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
    );
  }
}
