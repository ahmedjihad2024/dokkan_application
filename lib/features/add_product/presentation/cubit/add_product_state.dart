import 'package:flutter/material.dart';

import '../../../../core/enums/request_state.dart';
import '../../../../core/shared/domain/model/category_entity.dart';
import '../../../../core/shared/domain/model/product_entity.dart';

class GalleryUrlEntry {
  final int id;
  final TextEditingController controller;

  const GalleryUrlEntry({
    required this.id,
    required this.controller,
  });
}

class AddProductState {
  final ReqState status;
  final bool isEditMode;
  final ReqState categoriesStatus;
  final List<CategoryEntity> availableCategories;
  final String? categoriesError;
  final Set<String> selectedCategoryIds;
  final ReqState sellerStatus;
  final String? sellerId;
  final String? sellerError;
  final List<GalleryUrlEntry> galleryEntries;
  final ProductEntity? savedProduct;
  final String? errorMessage;
  final int feedbackCount;

  const AddProductState({
    this.status = ReqState.idle,
    this.isEditMode = false,
    this.categoriesStatus = ReqState.idle,
    this.availableCategories = const [],
    this.categoriesError,
    this.selectedCategoryIds = const {},
    this.sellerStatus = ReqState.idle,
    this.sellerId,
    this.sellerError,
    this.galleryEntries = const [],
    this.savedProduct,
    this.errorMessage,
    this.feedbackCount = 0,
  });

  AddProductState copyWith({
    ReqState? status,
    bool? isEditMode,
    ReqState? categoriesStatus,
    List<CategoryEntity>? availableCategories,
    String? categoriesError,
    bool clearCategoriesError = false,
    Set<String>? selectedCategoryIds,
    ReqState? sellerStatus,
    String? sellerId,
    String? sellerError,
    bool clearSellerError = false,
    List<GalleryUrlEntry>? galleryEntries,
    ProductEntity? savedProduct,
    String? errorMessage,
    bool clearError = false,
    int? feedbackCount,
  }) {
    return AddProductState(
      status: status ?? this.status,
      isEditMode: isEditMode ?? this.isEditMode,
      categoriesStatus: categoriesStatus ?? this.categoriesStatus,
      availableCategories: availableCategories ?? this.availableCategories,
      categoriesError:
          clearCategoriesError ? null : (categoriesError ?? this.categoriesError),
      selectedCategoryIds: selectedCategoryIds ?? this.selectedCategoryIds,
      sellerStatus: sellerStatus ?? this.sellerStatus,
      sellerId: sellerId ?? this.sellerId,
      sellerError: clearSellerError ? null : (sellerError ?? this.sellerError),
      galleryEntries: galleryEntries ?? this.galleryEntries,
      savedProduct: savedProduct ?? this.savedProduct,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      feedbackCount: feedbackCount ?? this.feedbackCount,
    );
  }
}
