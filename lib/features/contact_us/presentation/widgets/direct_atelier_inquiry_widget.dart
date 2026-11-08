import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/sizes_manager.dart';
import '../../../../core/widgets/feedback/custom_snackbar.dart';

class DirectAtelierInquiryWidget extends StatefulWidget {
  const DirectAtelierInquiryWidget({super.key});

  @override
  State<DirectAtelierInquiryWidget> createState() =>
      _DirectAtelierInquiryWidgetState();
}

class _DirectAtelierInquiryWidgetState
    extends State<DirectAtelierInquiryWidget> {
  static const List<String> _inquiryOptions = [
    'Bespoke Timepiece Consultation',
    'Order Tracking & Assistance',
    'Custom Jewelry Engraving',
    'Private Boutique Viewing Appointment',
    'Branch Visit & Atelier Tour',
    'Leather Goods & Restoration Inquiry',
    'Corporate & VIP Gifting',
  ];

  String _selectedSubject = _inquiryOptions.first;
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) {
      CustomSnackBar.showError(
        context,
        'Please enter your message before sending',
      );
      return;
    }

    CustomSnackBar.showSuccess(
      context,
      'Your inquiry has been received. Our concierge will reply shortly.',
    );
    _messageController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(SizeM.cardBorderRadius.r),
        border: Border.all(color: context.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.edit_note_rounded,
                size: 22.r,
                color: context.colorScheme.primary,
              ),
              Gap(8.w),
              Text(
                'Direct Atelier Inquiry',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: context.textPrimaryColor,
                ),
              ),
            ],
          ),
          Gap(4.h),
          Text(
            'Send a message directly to our concierge team',
            style: TextStyle(
              fontSize: 12.sp,
              color: context.textSecondaryColor,
            ),
          ),
          Gap(14.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: context.surfaceElevatedColor,
              borderRadius: BorderRadius.circular(SizeM.inputBorderRadius.r),
              border: Border.all(color: context.borderColor),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedSubject,
                isExpanded: true,
                dropdownColor: context.surfaceColor,
                borderRadius: BorderRadius.circular(SizeM.inputBorderRadius.r),
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: context.textMutedColor,
                ),
                items: _inquiryOptions.map((option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(
                      option,
                      style: TextStyle(
                        color: context.textPrimaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedSubject = newValue;
                    });
                  }
                },
              ),
            ),
          ),
          Gap(12.h),
          TextField(
            controller: _messageController,
            maxLines: 4,
            style: TextStyle(
              fontSize: 13.sp,
              color: context.textPrimaryColor,
            ),
            decoration: InputDecoration(
              hintText:
                  'Describe your desired request, inquiry or preferred branch...',
              hintStyle: TextStyle(
                color: context.textMutedColor,
                fontSize: 13.sp,
              ),
            ),
          ),
          Gap(14.h),
          SizedBox(
            width: double.infinity,
            height: SizeM.buttonHeight.h,
            child: ElevatedButton(
              onPressed: _sendMessage,
              child: const Text('Send Atelier Message'),
            ),
          ),
        ],
      ),
    );
  }
}

