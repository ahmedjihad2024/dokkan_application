import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/navigation_extension.dart';
import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/widgets/feedback/custom_snackbar.dart';
import '../../data/models/address_model.dart';
import '../widgets/add_edit_address_bottom_bar.dart';
import '../widgets/address_form_field.dart';
import '../widgets/governorate_dropdown_field.dart';

class AddEditAddressScreen extends StatefulWidget {
  final AddressModel? initialAddress;

  const AddEditAddressScreen({super.key, this.initialAddress});

  @override
  State<AddEditAddressScreen> createState() => _AddEditAddressScreenState();
}

class _AddEditAddressScreenState extends State<AddEditAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedState;
  late TextEditingController _cityController;
  late TextEditingController _streetController;
  late TextEditingController _apartmentController;
  late TextEditingController _phoneController;
  late TextEditingController _notesController;

  bool get isEditing => widget.initialAddress != null;

  @override
  void initState() {
    super.initState();
    final a = widget.initialAddress;
    _selectedState = GovernorateDropdownField.normalize(a?.state);
    _cityController = TextEditingController(text: a?.city ?? '');
    _streetController = TextEditingController(text: a?.street ?? '');
    _apartmentController = TextEditingController(text: a?.apartment ?? '');
    _phoneController = TextEditingController(text: a?.phoneNumber ?? '');
    _notesController = TextEditingController(text: a?.deliveryNotes ?? '');
  }

  @override
  void dispose() {
    _cityController.dispose();
    _streetController.dispose();
    _apartmentController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedState == null || _selectedState!.isEmpty) {
      CustomSnackBar.showError(context, 'Please select your state/governorate');
      return;
    }

    final newAddress = AddressModel(
      id: widget.initialAddress?.id ??
          'addr_${DateTime.now().millisecondsSinceEpoch}',
      tag: widget.initialAddress?.tag ?? 'HOME',
      state: _selectedState!,
      city: _cityController.text.trim(),
      street: _streetController.text.trim(),
      apartment: _apartmentController.text.trim(),
      phoneNumber: _phoneController.text.trim().startsWith('+20')
          ? _phoneController.text.trim()
          : '+20 ${_phoneController.text.trim()}',
      deliveryNotes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
      isDefault: widget.initialAddress?.isDefault ?? false,
    );

    context.pop(newAddress);
  }

  @override
  Widget build(BuildContext context) {
    final title = isEditing ? 'Edit Delivery Address' : 'Add Delivery Address';

    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.r),
          child: IconButton(
            style: IconButton.styleFrom(
              backgroundColor: context.surfaceElevatedColor,
              shape: const CircleBorder(),
            ),
            onPressed: () => context.pop(),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 16.sp,
              color: context.textPrimaryColor,
            ),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
            color: context.textPrimaryColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. State / Governorate Dropdown
                      GovernorateDropdownField(
                        selectedGovernorate: _selectedState,
                        onChanged: (val) => setState(() => _selectedState = val),
                      ),
                      16.verticalSpace,

                      // 2. City / District
                      AddressFormField(
                        label: 'City / District',
                        controller: _cityController,
                        hint: 'New Cairo (Fifth Settlement)',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'City / District is required';
                          }
                          return null;
                        },
                      ),
                      16.verticalSpace,

                      // 3. Street Name & Number
                      AddressFormField(
                        label: 'Street Name & Number',
                        controller: _streetController,
                        hint: 'El-Teseen St, Building 42',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Street address cannot be empty';
                          }
                          return null;
                        },
                      ),
                      16.verticalSpace,

                      // 4. Apartment / Suite / Floor
                      AddressFormField(
                        label: 'Apartment / Suite / Floor',
                        controller: _apartmentController,
                        hint: 'Apartment 3, Floor 2',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Apartment / Suite details are required';
                          }
                          return null;
                        },
                      ),
                      16.verticalSpace,

                      // 5. Phone Number
                      AddressFormField(
                        label: 'Phone Number',
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        hint: '+20 102 345 6789',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Phone number is required';
                          }
                          final digits = value.replaceAll(RegExp(r'\D'), '');
                          if (digits.length < 9) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      16.verticalSpace,

                      // 6. Delivery Notes (Optional)
                      AddressFormField(
                        label: 'Delivery Notes (Optional)',
                        controller: _notesController,
                        hint: 'Leave with security at main gate',
                      ),
                      24.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),

            // Fixed Bottom Save Button
            AddEditAddressBottomBar(
              isEditing: isEditing,
              onSave: _handleSave,
            ),
          ],
        ),
      ),
    );
  }
}

