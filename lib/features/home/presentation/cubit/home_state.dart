import '../../../../core/enums/request_state.dart';
import '../../data/models/category_model.dart';
import '../../data/models/product_model.dart';
import '../../data/models/promo_banner_model.dart';

class HomeState {
  final ReqState status;
  final List<PromoBannerModel> banners;
  final List<CategoryModel> categories;
  final List<ProductModel> products;
  final String selectedCategoryId;
  final int activeBannerIndex;
  final int cartCount;
  final int currentNavIndex;
  final String? errorMessage;

  const HomeState({
    this.status = ReqState.idle,
    this.banners = const [],
    this.categories = const [],
    this.products = const [],
    this.selectedCategoryId = 'all',
    this.activeBannerIndex = 0,
    this.cartCount = 2,
    this.currentNavIndex = 0,
    this.errorMessage,
  });


  HomeState copyWith({
    ReqState? status,
    List<PromoBannerModel>? banners,
    List<CategoryModel>? categories,
    List<ProductModel>? products,
    String? selectedCategoryId,
    int? activeBannerIndex,
    int? cartCount,
    int? currentNavIndex,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      banners: banners ?? this.banners,
      categories: categories ?? this.categories,
      products: products ?? this.products,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      activeBannerIndex: activeBannerIndex ?? this.activeBannerIndex,
      cartCount: cartCount ?? this.cartCount,
      currentNavIndex: currentNavIndex ?? this.currentNavIndex,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
