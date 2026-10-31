import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extensions/navigation_extension.dart';
import '../../../core/extensions/theme_extensions.dart';
import '../../../core/res/color_manager.dart';
import '../../../core/res/gen/assets.gen.dart';
import '../../../core/res/router/routes.dart';
import '../../../core/theme/theme_cubit.dart';
import 'widgets/forgot_password_form.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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

                  // Theme toggle button
                  IconButton(
                    onPressed: () {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                    icon: Icon(
                      context.isDark ? Icons.light_mode : Icons.dark_mode,
                      color: context.textPrimaryColor,
                    ),
                    tooltip: 'Toggle theme',
                  ),
                ],
              ),

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
              ),

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
              ),

              SizedBox(height: 32.h),

              // Email form
              ForgotPasswordForm(
                onSubmit: (email) {
                  context.pushNamed(
                    Routes.recoveryCode,
                    arguments: email,
                  );
                },
              ),

              SizedBox(height: 20.h),

              // Back to login
              Center(
                child: GestureDetector(
                  onTap: () {
                    context.pushReplacementNamed(Routes.login);
                  },
                  child: Text(
                    'Back to Login',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorM.primaryDark,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
