import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/theme_extensions.dart';
import '../../../../core/res/color_manager.dart';
import '../cubit/add_product_state.dart';
import 'add_product_form_field.dart';

class AddProductImagesSection extends StatelessWidget {
  final TextEditingController coverUrlController;
  final List<GalleryUrlEntry> galleryEntries;
  final String? Function(String?)? coverValidator;
  final String? Function(String?)? galleryUrlValidator;
  final VoidCallback onAddGalleryUrl;
  final ValueChanged<int> onRemoveGalleryUrl;

  const AddProductImagesSection({
    super.key,
    required this.coverUrlController,
    required this.galleryEntries,
    this.coverValidator,
    this.galleryUrlValidator,
    required this.onAddGalleryUrl,
    required this.onRemoveGalleryUrl,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final primaryAccent =
        isDark ? const Color(0xFFD47A4A) : const Color(0xFFB85C36);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AddProductFormField(
          label: 'Cover Picture URL',
          hintText: 'https://example.com/product-cover.jpg',
          controller: coverUrlController,
          keyboardType: TextInputType.url,
          validator: coverValidator,
        ),
        12.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Product Picture URLs (Optional)',
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: context.textSecondaryColor,
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onAddGalleryUrl,
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 5.h,
                  ),
                  decoration: BoxDecoration(
                    color: primaryAccent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add_link_rounded,
                        size: 14.sp,
                        color: primaryAccent,
                      ),
                      4.horizontalSpace,
                      Text(
                        'Add URL',
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: primaryAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        if (galleryEntries.isEmpty) ...[
          8.verticalSpace,
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: context.surfaceColor,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: context.borderColor),
            ),
            child: Text(
              'No extra gallery image URLs added yet. Tap "Add URL" to include more.',
              style: TextStyle(
                fontSize: 11.5.sp,
                color: context.textSecondaryColor,
              ),
            ),
          ),
        ] else ...[
          8.verticalSpace,
          for (var i = 0; i < galleryEntries.length; i++) ...[
            _GalleryUrlRow(
              key: ValueKey(galleryEntries[i].id),
              index: i,
              entry: galleryEntries[i],
              validator: galleryUrlValidator,
              onRemove: () => onRemoveGalleryUrl(galleryEntries[i].id),
            ),
            if (i < galleryEntries.length - 1) 8.verticalSpace,
          ],
        ],
      ],
    );
  }
}

class _GalleryUrlRow extends StatelessWidget {
  final int index;
  final GalleryUrlEntry entry;
  final String? Function(String?)? validator;
  final VoidCallback onRemove;

  const _GalleryUrlRow({
    super.key,
    required this.index,
    required this.entry,
    this.validator,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: AddProductFormField(
            label: 'Gallery Image URL #${index + 1}',
            hintText: 'https://example.com/product-${index + 1}.jpg',
            controller: entry.controller,
            keyboardType: TextInputType.url,
            validator: validator,
          ),
        ),
        8.horizontalSpace,
        Padding(
          padding: EdgeInsets.only(top: 22.h),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onRemove,
              borderRadius: BorderRadius.circular(10.r),
              child: Container(
                width: 42.w,
                height: 44.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorM.danger.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: ColorM.danger.withValues(alpha: 0.25),
                  ),
                ),
                child: Icon(
                  Icons.delete_outline_rounded,
                  size: 18.sp,
                  color: ColorM.danger,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

