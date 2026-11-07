import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/forms/app_text_field.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  final ValueChanged<String> onSubmit;
  final bool isLoading;

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) {
      return 'Please enter your email address';
    }

    final emailPattern = RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$');

    if (!emailPattern.hasMatch(email)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  void _submitForm() {
    if (widget.isLoading) return;

    FocusScope.of(context).unfocus();

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    widget.onSubmit(_emailController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            label: 'Email Address',
            hintText: 'Enter your email address',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            validator: _validateEmail,
            fillColor: context.surfaceSubtleColor,
            onFieldSubmitted: (_) => _submitForm(),
          ),

          SizedBox(height: 24.h),

          PrimaryButton(
            title: 'Send Reset Code',
            onPressed: _submitForm,
            isLoading: widget.isLoading,
            height: 52.h,
          ),
        ],
      ),
    );
  }
}
