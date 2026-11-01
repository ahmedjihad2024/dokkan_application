import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/navigation_extension.dart';
import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/forms/app_text_field.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _hasError = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _clearErrorIfPresent() {
    if (_hasError) {
      setState(() {
        _hasError = false;
      });
    }
  }

  String? _validateCurrentPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your current password';
    }
    return null;
  }

  String? _validateNewPassword(String? value) {
    if (value == null || value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password changed successfully')),
      );
      context.pop();
    } else {
      setState(() {
        _hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            label: 'Current Password',
            hintText: '••••••••••••',
            controller: _currentPasswordController,
            isPassword: true,
            textInputAction: TextInputAction.next,
            validator: _validateCurrentPassword,
            fillColor: context.surfaceSubtleColor,
            borderColor: _hasError ? ColorM.danger : context.borderColor,
            onChanged: (_) => _clearErrorIfPresent(),
          )
              .animate()
              .fadeIn(duration: 400.ms, delay: 120.ms)
              .slideY(
                begin: 0.08,
                end: 0,
                duration: 400.ms,
                curve: Curves.easeOutCubic,
              ),
          16.verticalSpace,
          AppTextField(
            label: 'New Password',
            hintText: '••••••••••••',
            controller: _newPasswordController,
            isPassword: true,
            textInputAction: TextInputAction.next,
            validator: _validateNewPassword,
            fillColor: context.surfaceSubtleColor,
            borderColor: _hasError ? ColorM.danger : context.borderColor,
            onChanged: (_) => _clearErrorIfPresent(),
          )
              .animate()
              .fadeIn(duration: 400.ms, delay: 180.ms)
              .slideY(
                begin: 0.08,
                end: 0,
                duration: 400.ms,
                curve: Curves.easeOutCubic,
              ),
          16.verticalSpace,
          AppTextField(
            label: 'Confirm New Password',
            hintText: '••••••••••••',
            controller: _confirmPasswordController,
            isPassword: true,
            textInputAction: TextInputAction.done,
            validator: _validateConfirmPassword,
            fillColor: context.surfaceSubtleColor,
            borderColor: _hasError ? ColorM.danger : context.borderColor,
            onChanged: (_) => _clearErrorIfPresent(),
            onFieldSubmitted: (_) => _submitForm(),
          )
              .animate()
              .fadeIn(duration: 400.ms, delay: 240.ms)
              .slideY(
                begin: 0.08,
                end: 0,
                duration: 400.ms,
                curve: Curves.easeOutCubic,
              ),
          16.verticalSpace,
          PrimaryButton(
            onPressed: _submitForm,
            title: 'Save New Password',
          )
              .animate()
              .fadeIn(duration: 400.ms, delay: 300.ms)
              .slideY(
                begin: 0.08,
                end: 0,
                duration: 400.ms,
                curve: Curves.easeOutCubic,
              )
              .scale(
                begin: const Offset(0.98, 0.98),
                end: const Offset(1, 1),
                duration: 400.ms,
                curve: Curves.easeOutCubic,
              ),
        ],
      ),
    );
  }
}
