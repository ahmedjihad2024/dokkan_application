import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/forms/app_text_field.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key, required this.onContinue});

  final void Function(
    String firstName,
    String lastName,
    String email,
    String password,
  ) onContinue;

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _formError;
  bool _showValidationErrors = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) return 'This field is required';
    if (name.length < 2) return 'Enter at least 2 characters';
    return null;
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Email address is required';

    final emailPattern = RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$');
    if (!emailPattern.hasMatch(email)) return 'Enter a valid email address';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password must be at least 8 characters';
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != _passwordController.text) return 'Passwords do not match';
    return null;
  }

  void _submitForm() {
    FocusScope.of(context).unfocus();

    final form = _formKey.currentState;
    if (form == null) return;

    final isValid = form.validate();
    setState(() {
      _showValidationErrors = true;
      _formError = isValid ? null : 'Please check the information entered.';
    });

    if (!isValid) return;

    widget.onContinue(
      _firstNameController.text.trim(),
      _lastNameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_formError != null) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              margin: EdgeInsets.only(bottom: 20.h),
              decoration: BoxDecoration(
                color: isDark
                    ? ColorM.dangerContainerDark
                    : ColorM.dangerContainerLight,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: ColorM.danger.withValues(alpha: 0.4),
                ),
              ),
              child: Text(
                _formError!,
                style: TextStyle(color: ColorM.danger, fontSize: 13.sp),
              ),
            ),
          ],
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  label: 'First Name',
                  hintText: 'John',
                  controller: _firstNameController,
                  validator: _validateName,
                  textInputAction: TextInputAction.next,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: AppTextField(
                  label: 'Last Name',
                  hintText: 'Doe',
                  controller: _lastNameController,
                  validator: _validateName,
                  textInputAction: TextInputAction.next,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          AppTextField(
            label: 'Email Address',
            hintText: 'alex@example.com',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: _validateEmail,
          ),
          SizedBox(height: 20.h),
          AppTextField(
            label: 'Password',
            hintText: 'Enter your password',
            controller: _passwordController,
            isPassword: true,
            textInputAction: TextInputAction.next,
            validator: _validatePassword,
            onChanged: (_) {
              if (_showValidationErrors &&
                  _confirmPasswordController.text.isNotEmpty) {
                _formKey.currentState?.validate();
              }
            },
          ),
          SizedBox(height: 20.h),
          AppTextField(
            label: 'Confirm Password',
            hintText: 'Re-enter your password',
            controller: _confirmPasswordController,
            isPassword: true,
            textInputAction: TextInputAction.done,
            validator: _validateConfirmPassword,
            onChanged: (_) {
              if (_showValidationErrors) {
                _formKey.currentState?.validate();
              }
            },
            onFieldSubmitted: (_) => _submitForm(),
          ),
          SizedBox(height: 12.h),
          Text(
            'A 6-digit verification code will be sent to your email.',
            style: TextStyle(
              fontSize: 12.sp,
              color: context.textSecondaryColor,
            ),
          ),
          SizedBox(height: 28.h),
          PrimaryButton(
            title: 'Continue to Verification',
            onPressed: _submitForm,
            trailingIcon: Icon(Icons.arrow_forward, size: 18.sp),
          ),
        ],
      ),
    );
  }
}
