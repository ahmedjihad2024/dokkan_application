import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/forms/app_text_field.dart';
import '../widgets/profile_settings_appbar.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
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
      Navigator.of(context).pop();
    } else {
      setState(() {
        _hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: ProfileSettingsAppBar(
        onBack: () => Navigator.of(context).pop(),
        title: 'Change Password',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose a strong password containing at least 8 characters, numbers, and special symbols.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: context.textSecondaryColor,
                  height: 1.4,
                ),
              ),

              SizedBox(height: 24.h),

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
              ),

              SizedBox(height: 16.h),

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
              ),

              SizedBox(height: 16.h),

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
              ),

              SizedBox(height: 16.h),

              PrimaryButton(onPressed: _submitForm, title: 'Save New Password'),
            ],
          ),
        ),
      ),
    );
  }
}
