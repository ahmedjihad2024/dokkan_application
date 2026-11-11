import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/widgets/feedback/custom_snackbar.dart';
import '../cubit/add_product_cubit.dart';
import '../cubit/add_product_state.dart';
import 'add_product_category_chips.dart';
import 'add_product_form_field.dart';
import 'add_product_images_section.dart';
import 'add_product_submit_button.dart';
import 'retry_error_banner.dart';

class AddProductBody extends StatefulWidget {
  final VoidCallback? onProductPublished;

  const AddProductBody({super.key, this.onProductPublished});

  @override
  State<AddProductBody> createState() => _AddProductBodyState();
}

class _AddProductBodyState extends State<AddProductBody> {
  final _formKey = GlobalKey<FormState>();

  String? _validateUrl(String? value, {required bool isRequired}) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return isRequired ? 'Please enter image URL' : null;
    }
    final uri = Uri.tryParse(trimmed);
    final isValid =
        uri != null &&
        uri.hasScheme &&
        (uri.isScheme('http') || uri.isScheme('https')) &&
        uri.host.isNotEmpty;
    return isValid ? null : 'Enter a valid http/https image URL';
  }

  void _handleSubmit(AddProductCubit cubit, AddProductState state) {
    FocusScope.of(context).unfocus();

    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      CustomSnackBar.showError(
        context,
        'Please review errors in the form before saving',
        isTop: true,
      );
      return;
    }

    if (!state.isEditMode && state.selectedCategoryIds.isEmpty) {
      CustomSnackBar.showWarning(
        context,
        'Please select at least one product category',
        isTop: true,
      );
      return;
    }

    cubit.submitProduct();
  }

  @override
  Widget build(BuildContext context) {
    final primaryAccent = context.colorScheme.primary;

    return BlocConsumer<AddProductCubit, AddProductState>(
      listenWhen: (previous, current) =>
          previous.feedbackCount != current.feedbackCount ||
          previous.status != current.status,
      listener: (context, state) {
        if (state.status.isFailure &&
            state.errorMessage != null &&
            state.errorMessage!.isNotEmpty) {
          CustomSnackBar.showError(context, state.errorMessage!, isTop: true);
          return;
        }

        if (state.status.isSuccess) {
          CustomSnackBar.showSuccess(
            context,
            state.isEditMode
                ? 'Product updated successfully!'
                : 'Product published to catalog successfully!',
            isTop: true,
          );
          if (widget.onProductPublished != null) {
            widget.onProductPublished!();
          } else {
            Navigator.of(context).pop(true);
          }
        }
      },
      builder: (context, state) {
        final cubit = context.read<AddProductCubit>();
        final editing = cubit.editingProduct;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!state.isEditMode && state.sellerStatus.isFailure) ...[
                  RetryErrorBanner(
                    message:
                        state.sellerError ??
                        'Unable to fetch seller profile ID',
                    accentColor: primaryAccent,
                    onRetry: cubit.loadSellerProfile,
                  ),
                  12.verticalSpace,
                ],
                AddProductImagesSection(
                  coverUrlController: cubit.coverUrlController,
                  galleryEntries: state.galleryEntries,
                  coverValidator: (value) => _validateUrl(
                    value,
                    isRequired:
                        !state.isEditMode ||
                        (editing?.coverPictureUrl?.trim().isNotEmpty ?? false),
                  ),
                  galleryUrlValidator: (value) =>
                      _validateUrl(value, isRequired: false),
                  onAddGalleryUrl: cubit.addGalleryUrlField,
                  onRemoveGalleryUrl: cubit.removeGalleryUrlField,
                ),
                12.verticalSpace,
                AddProductFormField(
                  label: 'Product Name (English)',
                  hintText: 'Heritage Chronograph Steel Watch',
                  controller: cubit.nameEnController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter English product name';
                    }
                    return null;
                  },
                ),
                12.verticalSpace,
                AddProductFormField(
                  label: 'اسم المنتج (بالعربية)',
                  hintText: 'ساعة كرونوغراف ستيل هيريتدج الفاخرة',
                  controller: cubit.nameArController,
                  textDirection: TextDirection.rtl,
                  validator: (value) {
                    final wasPresent =
                        editing?.arabicName?.trim().isNotEmpty ?? false;
                    if ((!state.isEditMode || wasPresent) &&
                        (value == null || value.trim().isEmpty)) {
                      return 'يرجى إدخال اسم المنتج بالعربية';
                    }
                    return null;
                  },
                ),
                12.verticalSpace,
                AddProductFormField(
                  label: 'Description (English)',
                  hintText:
                      'Handcrafted 316L surgical steel, Italian calfskin, sapphire crystal glass.',
                  controller: cubit.descEnController,
                  maxLines: 2,
                  validator: (value) {
                    final wasPresent =
                        editing?.description?.trim().isNotEmpty ?? false;
                    if ((!state.isEditMode || wasPresent) &&
                        (value == null || value.trim().isEmpty)) {
                      return 'Please enter English description';
                    }
                    return null;
                  },
                ),
                12.verticalSpace,
                AddProductFormField(
                  label: 'الوصف (بالعربية)',
                  hintText:
                      'ستانلس ستيل 316L وجلد عجل إيطالي فاخر، زجاج كريستال ياقوتي مقاوم للخدش.',
                  controller: cubit.descArController,
                  maxLines: 2,
                  textDirection: TextDirection.rtl,
                  validator: (value) {
                    final wasPresent =
                        editing?.arabicDescription?.trim().isNotEmpty ?? false;
                    if ((!state.isEditMode || wasPresent) &&
                        (value == null || value.trim().isEmpty)) {
                      return 'يرجى إدخال الوصف بالعربية';
                    }
                    return null;
                  },
                ),
                12.verticalSpace,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AddProductFormField(
                        label: 'Unit Price (\$)',
                        hintText: 'e.g. 149.00',
                        controller: cubit.priceController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d{0,2}'),
                          ),
                        ],
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Price is required';
                          }
                          final parsed = double.tryParse(value.trim());
                          if (parsed == null || parsed <= 0) {
                            return 'Enter valid price';
                          }
                          return null;
                        },
                      ),
                    ),
                    12.horizontalSpace,
                    Expanded(
                      child: AddProductFormField(
                        label: 'Discount Rate (%)',
                        hintText: 'e.g. 25',
                        controller: cubit.discountController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        textColor: primaryAccent,
                        textWeight: FontWeight.w600,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Discount is required';
                          }
                          final parsed = int.tryParse(value.trim());
                          if (parsed == null || parsed < 0 || parsed > 100) {
                            return 'Enter discount 0-100';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                12.verticalSpace,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AddProductFormField(
                        label: 'Stock Quantity',
                        hintText: 'e.g. 12',
                        controller: cubit.stockController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Stock is required';
                          }
                          final parsed = int.tryParse(value.trim());
                          if (parsed == null || parsed < 0) {
                            return 'Enter valid count';
                          }
                          return null;
                        },
                      ),
                    ),
                    12.horizontalSpace,
                    Expanded(
                      child: AddProductFormField(
                        label: 'Weight (g)',
                        hintText: 'e.g. 142.5',
                        controller: cubit.weightController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d{0,2}'),
                          ),
                        ],
                        validator: (value) {
                          final trimmed = value?.trim() ?? '';
                          if (trimmed.isEmpty) {
                            return (!state.isEditMode ||
                                    editing?.weight != null)
                                ? 'Weight is required'
                                : null;
                          }
                          final parsed = double.tryParse(trimmed);
                          if (parsed == null || parsed <= 0) {
                            return 'Enter valid weight';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                12.verticalSpace,
                AddProductFormField(
                  label: 'Color',
                  hintText: 'e.g. Silver / Espresso',
                  controller: cubit.colorController,
                  validator: (value) {
                    final wasPresent =
                        editing?.color?.trim().isNotEmpty ?? false;
                    if ((!state.isEditMode || wasPresent) &&
                        (value == null || value.trim().isEmpty)) {
                      return 'Please enter product color';
                    }
                    return null;
                  },
                ),
                14.verticalSpace,
                AddProductCategoryChips(
                  status: state.categoriesStatus,
                  categories: state.availableCategories,
                  errorMessage: state.categoriesError,
                  selectedCategoryIds: state.selectedCategoryIds,
                  onCategoryToggled: cubit.toggleCategory,
                  onRetry: cubit.loadCategories,
                ),
                20.verticalSpace,
                AddProductSubmitButton(
                  isLoading: state.status.isLoading,
                  isEditMode: state.isEditMode,
                  onSubmit: () => _handleSubmit(cubit, state),
                ),
                24.verticalSpace,
              ],
            ),
          )
              .animate()
              .fadeIn(duration: 320.ms, curve: Curves.easeOutCubic)
              .slideY(begin: 0.03, end: 0, curve: Curves.easeOutCubic),
        );
      },
    );
  }
}
