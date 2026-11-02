import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/widgets/feedback/custom_snackbar.dart';
import '../cubit/add_product_cubit.dart';
import '../cubit/add_product_state.dart';
import 'add_product_category_chips.dart';
import 'add_product_form_field.dart';
import 'add_product_image_pickers_card.dart';
import 'add_product_submit_button.dart';
import 'image_picker_bottom_sheet.dart';

class AddProductBody extends StatefulWidget {
  final VoidCallback? onProductPublished;

  const AddProductBody({super.key, this.onProductPublished});

  @override
  State<AddProductBody> createState() => _AddProductBodyState();
}

class _AddProductBodyState extends State<AddProductBody> {
  final _formKey = GlobalKey<FormState>();
  bool _showCoverError = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<AddProductCubit>().retrieveLostData();
      }
    });
  }

  void _handleSubmit() async {
    FocusScope.of(context).unfocus();
    final cubit = context.read<AddProductCubit>();
    final state = cubit.state;

    final hasCover =
        state.coverImagePath != null && state.coverImagePath!.trim().isNotEmpty;

    if (!hasCover) {
      setState(() {
        _showCoverError = true;
      });
      CustomSnackBar.showWarning(
        context,
        'Please select a product cover image',
        isTop: true,
      );
      return;
    }

    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      CustomSnackBar.showError(
        context,
        'Please review errors in the form before publishing',
        isTop: true,
      );
      return;
    }

    if (state.selectedCategories.isEmpty) {
      CustomSnackBar.showWarning(
        context,
        'Please select at least one product category',
        isTop: true,
      );
      return;
    }

    // Process publishing product
    await cubit.submitProduct();
    if (mounted) {
      CustomSnackBar.showSuccess(
        context,
        'Product published to catalog successfully!',
        isTop: true,
      );
      if (widget.onProductPublished != null) {
        widget.onProductPublished!();
      } else {
        Navigator.maybePop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryAccent = context.colorScheme.primary;

    return BlocConsumer<AddProductCubit, AddProductState>(
      listener: (context, state) {
        if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
          CustomSnackBar.showError(context, state.errorMessage!, isTop: true);
        }
      },
      builder: (context, state) {
        final cubit = context.read<AddProductCubit>();

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Pickers Card matching Figma 37:769 / 37:840
                AddProductImagePickersCard(
                  coverImagePath: state.coverImagePath,
                  galleryImages: state.galleryImages,
                  hasCoverError: _showCoverError &&
                      (state.coverImagePath == null ||
                          state.coverImagePath!.trim().isEmpty),
                  onCoverTap: () {
                    if (_showCoverError) {
                      setState(() {
                        _showCoverError = false;
                      });
                    }
                    ImagePickerBottomSheet.show(
                      context,
                      title: 'Select Cover Photo',
                      showRemoveOption: state.coverImagePath != null,
                      onCameraTap: () =>
                          cubit.pickCoverImage(source: ImageSource.camera),
                      onGalleryTap: () =>
                          cubit.pickCoverImage(source: ImageSource.gallery),
                      onRemoveTap: () => cubit.removeCoverImage(),
                    );
                  },
                  onAddGalleryImage: () {
                    ImagePickerBottomSheet.show(
                      context,
                      title: 'Add Gallery Photos',
                      showRemoveOption: false,
                      onCameraTap: () => cubit.pickSingleGalleryImage(
                        source: ImageSource.camera,
                      ),
                      onGalleryTap: () => cubit.pickGalleryImages(),
                    );
                  },
                  onReplaceGalleryImage: (index) {
                    ImagePickerBottomSheet.show(
                      context,
                      title: 'Gallery Photo #${index + 1}',
                      showRemoveOption: true,
                      onCameraTap: () => cubit.replaceGalleryImage(
                        index,
                        source: ImageSource.camera,
                      ),
                      onGalleryTap: () => cubit.replaceGalleryImage(
                        index,
                        source: ImageSource.gallery,
                      ),
                      onRemoveTap: () => cubit.removeGalleryImage(index),
                    );
                  },
                  onRemoveGalleryImage: (index) =>
                      cubit.removeGalleryImage(index),
                )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 60.ms)
                    .slideY(
                      begin: 0.08,
                      end: 0,
                      duration: 400.ms,
                      curve: Curves.easeOutCubic,
                    ),
                12.verticalSpace,

                // Product Name (English) matching Figma 37:781 / 37:852
                AddProductFormField(
                  label: 'Product Name (English)',
                  hintText: 'Heritage Chronograph Steel Watch',
                  initialValue: state.productNameEn,
                  onChanged: cubit.updateNameEn,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter English product name';
                    }
                    return null;
                  },
                )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 100.ms)
                    .slideY(
                      begin: 0.08,
                      end: 0,
                      duration: 400.ms,
                      curve: Curves.easeOutCubic,
                    ),
                12.verticalSpace,

                // Product Name (Arabic) matching Figma 37:785 / 37:856
                AddProductFormField(
                  label: 'اسم المنتج (بالعربية)',
                  hintText: 'ساعة كرونوغراف ستيل هيريتدج الفاخرة',
                  initialValue: state.productNameAr,
                  textDirection: TextDirection.rtl,
                  onChanged: cubit.updateNameAr,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'يرجى إدخال اسم المنتج بالعربية';
                    }
                    return null;
                  },
                )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 140.ms)
                    .slideY(
                      begin: 0.08,
                      end: 0,
                      duration: 400.ms,
                      curve: Curves.easeOutCubic,
                    ),
                12.verticalSpace,

                // Description (English) matching Figma 37:789 / 37:860
                AddProductFormField(
                  label: 'Description (English)',
                  hintText:
                      'Handcrafted 316L surgical steel, Italian calfskin, sapphire crystal glass.',
                  initialValue: state.descriptionEn,
                  maxLines: 2,
                  onChanged: cubit.updateDescEn,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter English description';
                    }
                    return null;
                  },
                )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 180.ms)
                    .slideY(
                      begin: 0.08,
                      end: 0,
                      duration: 400.ms,
                      curve: Curves.easeOutCubic,
                    ),
                12.verticalSpace,

                // Description (Arabic) matching Figma 37:793 / 37:864
                AddProductFormField(
                  label: 'الوصف (بالعربية)',
                  hintText:
                      'ستانلس ستيل 316L وجلد عجل إيطالي فاخر، زجاج كريستال ياقوتي مقاوم للخدش.',
                  initialValue: state.descriptionAr,
                  maxLines: 2,
                  textDirection: TextDirection.rtl,
                  onChanged: cubit.updateDescAr,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'يرجى إدخال الوصف بالعربية';
                    }
                    return null;
                  },
                )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 220.ms)
                    .slideY(
                      begin: 0.08,
                      end: 0,
                      duration: 400.ms,
                      curve: Curves.easeOutCubic,
                    ),
                12.verticalSpace,

                // Row: Price & Discount matching Figma 37:797 / 37:868
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AddProductFormField(
                        label: 'Unit Price (\$)',
                        hintText: 'e.g. 149.00',
                        initialValue: state.unitPrice,
                        keyboardType:
                            const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}')),
                        ],
                        onChanged: cubit.updateUnitPrice,
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
                        initialValue: state.discountRate,
                        keyboardType:
                            const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}')),
                        ],
                        textColor: primaryAccent,
                        textWeight: FontWeight.w600,
                        onChanged: cubit.updateDiscount,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Discount is required';
                          }
                          final parsed = double.tryParse(value.trim());
                          if (parsed == null || parsed < 0 || parsed > 100) {
                            return 'Enter discount 0-100';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 260.ms)
                    .slideY(
                      begin: 0.08,
                      end: 0,
                      duration: 400.ms,
                      curve: Curves.easeOutCubic,
                    ),
                12.verticalSpace,

                // Row: Stock & Weight matching Figma 37:806 / 37:877
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AddProductFormField(
                        label: 'Stock Quantity',
                        hintText: 'e.g. 12',
                        initialValue: state.stockQuantity,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: cubit.updateStock,
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
                        label: 'Weight & Finish',
                        hintText: '142g • Espresso',
                        initialValue: state.weightFinish,
                        onChanged: cubit.updateWeightFinish,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Weight & finish required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 300.ms)
                    .slideY(
                      begin: 0.08,
                      end: 0,
                      duration: 400.ms,
                      curve: Curves.easeOutCubic,
                    ),
                14.verticalSpace,

                // Categories Multi-Select Chips matching Figma 37:815 / 37:886
                AddProductCategoryChips(
                  selectedCategories: state.selectedCategories,
                  onCategoryToggled: cubit.toggleCategory,
                )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 340.ms)
                    .slideY(
                      begin: 0.08,
                      end: 0,
                      duration: 400.ms,
                      curve: Curves.easeOutCubic,
                    ),
                20.verticalSpace,

                // Submit & Publish Button matching Figma 37:826 / 37:897
                AddProductSubmitButton(
                  isLoading: state.status.isLoading,
                  onSubmit: _handleSubmit,
                )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 380.ms)
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
                24.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
  }
}
