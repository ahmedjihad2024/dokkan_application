import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/navigation_extension.dart';
import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/res/router/routes.dart';

class PaymentRedirectScreen extends StatefulWidget {
  final Map<String, dynamic>? orderData;

  const PaymentRedirectScreen({super.key, this.orderData});

  @override
  State<PaymentRedirectScreen> createState() => _PaymentRedirectScreenState();
}

class _PaymentRedirectScreenState extends State<PaymentRedirectScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 2400), () {
      if (mounted) {
        context.pushReplacementNamed(
          Routes.checkoutPaymentSuccess,
          arguments: widget.orderData,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: context.scaffoldBackgroundColor,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Pulsing lock animation
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 100.w,
                        height: 100.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorM.primaryDark.withValues(alpha: 0.1),
                        ),
                      )
                          .animate(onPlay: (c) => c.repeat(reverse: true))
                          .scale(
                            begin: const Offset(1.0, 1.0),
                            end: const Offset(1.18, 1.18),
                            duration: 1200.ms,
                            curve: Curves.easeInOut,
                          ),
                      Container(
                        width: 70.w,
                        height: 70.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorM.primaryDark.withValues(alpha: 0.18),
                        ),
                        child: Icon(
                          Icons.lock_rounded,
                          size: 32.sp,
                          color: ColorM.primaryDark,
                        ),
                      ),
                      SizedBox(
                        width: 110.w,
                        height: 110.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            ColorM.primaryDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                  28.verticalSpace,

                  Text(
                    'Redirecting to secure payment...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: context.textPrimaryColor,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic),
                  10.verticalSpace,

                  Text(
                    'Connecting to Paymob 256-bit SSL gateway.\nPlease do not refresh or close this screen.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: context.textSecondaryColor,
                      height: 1.45,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 400.ms, delay: 100.ms),
                  40.verticalSpace,

                  // Security Compliance Badge
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: context.surfaceElevatedColor,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: context.borderColor),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.verified_user_outlined,
                          size: 14.sp,
                          color: ColorM.success,
                        ),
                        6.horizontalSpace,
                        Text(
                          'PCI-DSS Level 1 Certified • 256-bit SSL',
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            color: context.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 400.ms, delay: 200.ms),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

