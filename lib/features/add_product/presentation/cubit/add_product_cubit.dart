import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/enums/request_state.dart';
import 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  final ImagePicker _picker;

  AddProductCubit({ImagePicker? picker})
      : _picker = picker ?? ImagePicker(),
        super(const AddProductState());

  Future<void> pickCoverImage({ImageSource source = ImageSource.gallery}) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );
      if (image != null) {
        emit(state.copyWith(coverImagePath: image.path));
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to pick cover image: $e'));
    }
  }

  Future<void> pickGalleryImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage(
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );
      if (images.isNotEmpty) {
        final current = List<String>.from(state.galleryImages);
        for (final img in images) {
          if (current.length < 3) {
            current.add(img.path);
          }
        }
        emit(state.copyWith(galleryImages: current));
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to pick gallery images: $e'));
    }
  }

  Future<void> pickSingleGalleryImage({ImageSource source = ImageSource.camera}) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );
      if (image != null) {
        final current = List<String>.from(state.galleryImages);
        if (current.length < 3) {
          current.add(image.path);
          emit(state.copyWith(galleryImages: current));
        }
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to pick image: $e'));
    }
  }

  Future<void> replaceGalleryImage(
    int index, {
    ImageSource source = ImageSource.gallery,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );
      if (image != null && index >= 0 && index < state.galleryImages.length) {
        final current = List<String>.from(state.galleryImages);
        current[index] = image.path;
        emit(state.copyWith(galleryImages: current));
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to update image: $e'));
    }
  }

  Future<void> retrieveLostData() async {
    try {
      final LostDataResponse response = await _picker.retrieveLostData();
      if (response.isEmpty) return;
      if (response.file != null) {
        if (state.coverImagePath == null) {
          emit(state.copyWith(coverImagePath: response.file!.path));
        } else if (state.galleryImages.length < 3) {
          final current = List<String>.from(state.galleryImages)
            ..add(response.file!.path);
          emit(state.copyWith(galleryImages: current));
        }
      } else if (response.files != null && response.files!.isNotEmpty) {
        final current = List<String>.from(state.galleryImages);
        for (final f in response.files!) {
          if (current.length < 3) current.add(f.path);
        }
        emit(state.copyWith(galleryImages: current));
      }
    } catch (_) {}
  }

  void removeGalleryImage(int index) {
    if (index >= 0 && index < state.galleryImages.length) {
      final current = List<String>.from(state.galleryImages)..removeAt(index);
      emit(state.copyWith(galleryImages: current));
    }
  }

  void removeCoverImage() {
    emit(state.copyWith(clearCoverImage: true));
  }

  void toggleCategory(String category) {
    final updated = Set<String>.from(state.selectedCategories);
    if (updated.contains(category)) {
      if (updated.length > 1) {
        updated.remove(category);
      }
    } else {
      updated.add(category);
    }
    emit(state.copyWith(selectedCategories: updated));
  }

  void updateNameEn(String value) => emit(state.copyWith(productNameEn: value));
  void updateNameAr(String value) => emit(state.copyWith(productNameAr: value));
  void updateDescEn(String value) => emit(state.copyWith(descriptionEn: value));
  void updateDescAr(String value) => emit(state.copyWith(descriptionAr: value));
  void updateUnitPrice(String value) => emit(state.copyWith(unitPrice: value));
  void updateDiscount(String value) => emit(state.copyWith(discountRate: value));
  void updateStock(String value) => emit(state.copyWith(stockQuantity: value));
  void updateWeightFinish(String value) =>
      emit(state.copyWith(weightFinish: value));

  Future<void> submitProduct() async {
    emit(state.copyWith(status: ReqState.loading));
    // Simulate submission delay
    await Future.delayed(const Duration(milliseconds: 900));
    emit(state.copyWith(status: ReqState.success));
  }
}
