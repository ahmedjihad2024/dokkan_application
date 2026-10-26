import '../../../../core/enums/request_state.dart';

class AddProductState {
  final ReqState status;
  final String? coverImagePath;
  final List<String> galleryImages;
  final String productNameEn;
  final String productNameAr;
  final String descriptionEn;
  final String descriptionAr;
  final String unitPrice;
  final String discountRate;
  final String stockQuantity;
  final String weightFinish;
  final Set<String> selectedCategories;
  final String? errorMessage;

  const AddProductState({
    this.status = ReqState.idle,
    this.coverImagePath,
    this.galleryImages = const [],
    this.productNameEn = '',
    this.productNameAr = '',
    this.descriptionEn = '',
    this.descriptionAr = '',
    this.unitPrice = '',
    this.discountRate = '',
    this.stockQuantity = '',
    this.weightFinish = '',
    this.selectedCategories = const {'Watches'},
    this.errorMessage,
  });

  AddProductState copyWith({
    ReqState? status,
    String? coverImagePath,
    bool clearCoverImage = false,
    List<String>? galleryImages,
    String? productNameEn,
    String? productNameAr,
    String? descriptionEn,
    String? descriptionAr,
    String? unitPrice,
    String? discountRate,
    String? stockQuantity,
    String? weightFinish,
    Set<String>? selectedCategories,
    String? errorMessage,
  }) {
    return AddProductState(
      status: status ?? this.status,
      coverImagePath:
          clearCoverImage ? null : (coverImagePath ?? this.coverImagePath),
      galleryImages: galleryImages ?? this.galleryImages,
      productNameEn: productNameEn ?? this.productNameEn,
      productNameAr: productNameAr ?? this.productNameAr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      unitPrice: unitPrice ?? this.unitPrice,
      discountRate: discountRate ?? this.discountRate,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      weightFinish: weightFinish ?? this.weightFinish,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
