import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../data/models/payment_method_model.dart';
import 'payment_option_card.dart';
import 'security_guarantee_box.dart';

class StepPaymentMethod extends StatelessWidget {
  final List<PaymentMethodModel> methods;
  final String selectedMethodId;
  final ValueChanged<String> onSelectMethod;

  const StepPaymentMethod({
    super.key,
    required this.methods,
    required this.selectedMethodId,
    required this.onSelectMethod,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Text(
            'Available Payment Options',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
          ),
        ),

        // Payment Options List
        ...List.generate(methods.length, (index) {
          final method = methods[index];
          final isSelected = method.id == selectedMethodId;

          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: PaymentOptionCard(
              method: method,
              isSelected: isSelected,
              onSelect: () => onSelectMethod(method.id),
            )
                .animate(delay: (index * 60).ms)
                .fadeIn(duration: 380.ms, curve: Curves.easeOutCubic)
                .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic),
          );
        }),

        12.verticalSpace,

        // Security Guarantee Widget
        const SecurityGuaranteeBox()
            .animate()
            .fadeIn(duration: 400.ms, delay: 180.ms)
            .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic),

        24.verticalSpace,
      ],
    );
  }
}

