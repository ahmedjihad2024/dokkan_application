import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/request_state.dart';
import '../../../../core/network/failure_message.dart';
import '../../../../core/shared/data/request/create_product_request.dart';
import '../../../../core/shared/data/request/update_product_request.dart';
import '../../../../core/shared/domain/model/category_entity.dart';
import '../../../../core/shared/domain/model/product_entity.dart';
import '../../../../core/shared/domain/usecase/create_product_usecase.dart';
import '../../../../core/shared/domain/usecase/get_categories_usecase.dart';
import '../../../../core/shared/domain/usecase/update_product_usecase.dart';
import '../../../authentication/domain/usecase/get_current_user_usecase.dart';
import 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  final CreateProductUseCase createProductUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  final TextEditingController coverUrlController = TextEditingController();
  final TextEditingController nameEnController = TextEditingController();
  final TextEditingController nameArController = TextEditingController();
  final TextEditingController descEnController = TextEditingController();
  final TextEditingController descArController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController colorController = TextEditingController();

  ProductEntity? _editingProduct;
  Set<String> _initialCategoryIds = const {};
  bool _categoriesTouchedByUser = false;
  int _nextGalleryId = 0;
  final List<TextEditingController> _retiredGalleryControllers = [];

  AddProductCubit({
    required this.createProductUseCase,
    required this.updateProductUseCase,
    required this.getCategoriesUseCase,
    required this.getCurrentUserUseCase,
  }) : super(const AddProductState());

  ProductEntity? get editingProduct => _editingProduct;

  Future<void> init([ProductEntity? product]) async {
    if (isClosed) return;

    if (product != null) {
      _editingProduct = product;
      _prefillFromProduct(product);
      final initialGalleryEntries =
          product.productPictures
              .where((url) => url.trim().isNotEmpty)
              .map((url) => _createGalleryEntry(initialText: url))
              .toList();

      emit(
        state.copyWith(
          isEditMode: true,
          galleryEntries: initialGalleryEntries,
          sellerId: product.sellerId,
          sellerStatus:
              product.sellerId != null && product.sellerId!.trim().isNotEmpty
                  ? ReqState.success
                  : ReqState.idle,
        ),
      );
      await loadCategories();
      return;
    }

    await Future.wait([loadCategories(), loadSellerProfile()]);
  }

  void _prefillFromProduct(ProductEntity product) {
    coverUrlController.text = product.coverPictureUrl?.trim() ?? '';
    nameEnController.text = product.name;
    nameArController.text = product.arabicName?.trim() ?? '';
    descEnController.text = product.description?.trim() ?? '';
    descArController.text = product.arabicDescription?.trim() ?? '';
    priceController.text = _formatDouble(product.price);
    discountController.text = product.discountPercentage.toString();
    stockController.text = product.stock.toString();
    weightController.text =
        product.weight != null ? _formatDouble(product.weight!) : '';
    colorController.text = product.color?.trim() ?? '';
  }

  String _formatDouble(double value) {
    return value == value.roundToDouble()
        ? value.toInt().toString()
        : value.toString();
  }

  GalleryUrlEntry _createGalleryEntry({String initialText = ''}) {
    return GalleryUrlEntry(
      id: _nextGalleryId++,
      controller: TextEditingController(text: initialText),
    );
  }

  Future<void> loadCategories() async {
    if (isClosed) return;

    emit(
      state.copyWith(
        categoriesStatus: ReqState.loading,
        clearCategoriesError: true,
      ),
    );

    final result = await getCategoriesUseCase();
    if (isClosed) return;

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            categoriesStatus: ReqState.failure,
            categoriesError: failure.message,
          ),
        );
      },
      (categories) {
        final matchedIds = _matchInitialCategoryIds(categories);
        if (_editingProduct != null) {
          _initialCategoryIds = matchedIds;
        }

        final selectedIds =
            _categoriesTouchedByUser ? state.selectedCategoryIds : matchedIds;

        emit(
          state.copyWith(
            categoriesStatus: ReqState.success,
            availableCategories: categories,
            selectedCategoryIds: selectedIds,
            clearCategoriesError: true,
          ),
        );
      },
    );
  }

  Set<String> _matchInitialCategoryIds(List<CategoryEntity> categories) {
    final product = _editingProduct;
    if (product == null || product.categories.isEmpty) {
      return const {};
    }

    final productCategoryTokens =
        product.categories
            .map((e) => e.trim().toLowerCase())
            .where((e) => e.isNotEmpty)
            .toSet();

    final matched = <String>{};
    for (final category in categories) {
      final idToken = category.id.trim().toLowerCase();
      final nameToken = category.name.trim().toLowerCase();
      if (productCategoryTokens.contains(idToken) ||
          productCategoryTokens.contains(nameToken)) {
        matched.add(category.id);
      }
    }
    return matched;
  }

  Future<void> loadSellerProfile() async {
    if (isClosed) return;

    emit(
      state.copyWith(
        sellerStatus: ReqState.loading,
        clearSellerError: true,
      ),
    );

    final result = await getCurrentUserUseCase();
    if (isClosed) return;

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            sellerStatus: ReqState.failure,
            sellerError: failure.message,
          ),
        );
      },
      (user) {
        final resolvedId = user.userId.trim();
        if (resolvedId.isEmpty) {
          emit(
            state.copyWith(
              sellerStatus: ReqState.failure,
              sellerError: 'Account profile did not include a valid seller ID.',
            ),
          );
          return;
        }

        emit(
          state.copyWith(
            sellerStatus: ReqState.success,
            sellerId: resolvedId,
            clearSellerError: true,
          ),
        );
      },
    );
  }

  void addGalleryUrlField() {
    if (isClosed) return;
    final updated = List<GalleryUrlEntry>.from(state.galleryEntries)
      ..add(_createGalleryEntry());
    emit(state.copyWith(galleryEntries: updated, clearError: true));
  }

  void removeGalleryUrlField(int entryId) {
    if (isClosed) return;
    final index = state.galleryEntries.indexWhere((e) => e.id == entryId);
    if (index == -1) return;

    final updated = List<GalleryUrlEntry>.from(state.galleryEntries);
    final removed = updated.removeAt(index);
    // Defer disposal until cubit.close() so animating/rebuilding rows never
    // read a disposed TextEditingController during the same frame.
    _retiredGalleryControllers.add(removed.controller);
    emit(state.copyWith(galleryEntries: updated, clearError: true));
  }

  void toggleCategory(String categoryId) {
    if (isClosed) return;
    _categoriesTouchedByUser = true;
    final updated = Set<String>.from(state.selectedCategoryIds);
    if (updated.contains(categoryId)) {
      updated.remove(categoryId);
    } else {
      updated.add(categoryId);
    }
    emit(state.copyWith(selectedCategoryIds: updated, clearError: true));
  }

  List<String> _currentGalleryUrls() {
    return state.galleryEntries
        .map((entry) => entry.controller.text.trim())
        .where((url) => url.isNotEmpty)
        .toList();
  }

  Future<void> submitProduct() async {
    if (isClosed || state.status.isLoading) return;

    if (state.isEditMode && _editingProduct != null) {
      await _submitUpdate(_editingProduct!);
    } else {
      await _submitCreate();
    }
  }

  Future<void> _submitCreate() async {
    emit(state.copyWith(status: ReqState.loading, clearError: true));

    if (state.sellerId == null || state.sellerId!.trim().isEmpty) {
      await loadSellerProfile();
      if (isClosed) return;
    }

    final sellerId = state.sellerId?.trim();
    if (sellerId == null || sellerId.isEmpty) {
      emit(
        state.copyWith(
          status: ReqState.failure,
          errorMessage:
              state.sellerError ?? 'Could not load seller profile ID.',
          feedbackCount: state.feedbackCount + 1,
        ),
      );
      return;
    }

    final price = double.tryParse(priceController.text.trim());
    final stock = int.tryParse(stockController.text.trim());
    final weight = double.tryParse(weightController.text.trim());
    final discount = int.tryParse(discountController.text.trim()) ?? 0;

    if (price == null || stock == null || weight == null) {
      emit(
        state.copyWith(
          status: ReqState.failure,
          errorMessage: 'Please enter valid numeric values before publishing.',
          feedbackCount: state.feedbackCount + 1,
        ),
      );
      return;
    }

    final request = CreateProductRequest(
      sellerId: sellerId,
      name: nameEnController.text.trim(),
      description: descEnController.text.trim(),
      nameArabic: nameArController.text.trim(),
      descriptionArabic: descArController.text.trim(),
      coverPictureUrl: coverUrlController.text.trim(),
      price: price,
      stock: stock,
      weight: weight,
      color: colorController.text.trim(),
      discountPercentage: discount,
      categoryIds: state.selectedCategoryIds.toList(),
      productPictureUrls: _currentGalleryUrls(),
    );

    final result = await createProductUseCase(request);
    if (isClosed) return;

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: ReqState.failure,
            errorMessage: failure.message,
            feedbackCount: state.feedbackCount + 1,
          ),
        );
      },
      (product) {
        emit(
          state.copyWith(
            status: ReqState.success,
            savedProduct: product,
            clearError: true,
            feedbackCount: state.feedbackCount + 1,
          ),
        );
      },
    );
  }

  Future<void> _submitUpdate(ProductEntity original) async {
    final changedName = _changedNonEmptyString(
      nameEnController.text,
      original.name,
    );
    final changedNameArabic = _changedNonEmptyString(
      nameArController.text,
      original.arabicName,
    );
    final changedDescription = _changedNonEmptyString(
      descEnController.text,
      original.description,
    );
    final changedDescriptionArabic = _changedNonEmptyString(
      descArController.text,
      original.arabicDescription,
    );
    final changedCoverUrl = _changedNonEmptyString(
      coverUrlController.text,
      original.coverPictureUrl,
    );
    final changedColor = _changedNonEmptyString(
      colorController.text,
      original.color,
    );

    final parsedPrice = double.tryParse(priceController.text.trim());
    final changedPrice =
        parsedPrice != null && (parsedPrice - original.price).abs() > 1e-9
            ? parsedPrice
            : null;

    final parsedStock = int.tryParse(stockController.text.trim());
    final changedStock =
        parsedStock != null && parsedStock != original.stock
            ? parsedStock
            : null;

    final parsedWeight = double.tryParse(weightController.text.trim());
    final changedWeight =
        parsedWeight != null &&
                (original.weight == null ||
                    (parsedWeight - original.weight!).abs() > 1e-9)
            ? parsedWeight
            : null;

    final parsedDiscount = int.tryParse(discountController.text.trim());
    final changedDiscount =
        parsedDiscount != null && parsedDiscount != original.discountPercentage
            ? parsedDiscount
            : null;

    final categoriesChanged =
        !setEquals(state.selectedCategoryIds, _initialCategoryIds) &&
        state.selectedCategoryIds.isNotEmpty;
    final changedCategoryIds =
        categoriesChanged ? state.selectedCategoryIds.toList() : null;

    final currentPictures = _currentGalleryUrls();
    final originalPictures =
        original.productPictures
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();
    final picturesChanged = !listEquals(currentPictures, originalPictures);

    final request = UpdateProductRequest(
      id: original.id,
      name: changedName,
      nameArabic: changedNameArabic,
      description: changedDescription,
      descriptionArabic: changedDescriptionArabic,
      coverPictureUrl: changedCoverUrl,
      price: changedPrice,
      stock: changedStock,
      weight: changedWeight,
      color: changedColor,
      discountPercentage: changedDiscount,
      categoryIds: changedCategoryIds,
      productPictures: picturesChanged ? currentPictures : null,
    );

    if (!request.hasChanges) {
      emit(
        state.copyWith(
          status: ReqState.failure,
          errorMessage: 'No changes detected to update.',
          feedbackCount: state.feedbackCount + 1,
        ),
      );
      return;
    }

    emit(state.copyWith(status: ReqState.loading, clearError: true));

    final result = await updateProductUseCase(request);
    if (isClosed) return;

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: ReqState.failure,
            errorMessage: failure.message,
            feedbackCount: state.feedbackCount + 1,
          ),
        );
      },
      (product) {
        emit(
          state.copyWith(
            status: ReqState.success,
            savedProduct: product,
            clearError: true,
            feedbackCount: state.feedbackCount + 1,
          ),
        );
      },
    );
  }

  String? _changedNonEmptyString(String rawCurrent, String? original) {
    final current = rawCurrent.trim();
    final baseline = (original ?? '').trim();
    if (current == baseline || current.isEmpty) {
      return null;
    }
    return current;
  }

  @override
  Future<void> close() {
    coverUrlController.dispose();
    nameEnController.dispose();
    nameArController.dispose();
    descEnController.dispose();
    descArController.dispose();
    priceController.dispose();
    discountController.dispose();
    stockController.dispose();
    weightController.dispose();
    colorController.dispose();

    for (final entry in state.galleryEntries) {
      entry.controller.dispose();
    }
    for (final controller in _retiredGalleryControllers) {
      controller.dispose();
    }

    return super.close();
  }
}
