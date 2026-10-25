import '../../../../core/res/gen/assets.gen.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';
import '../models/promo_banner_model.dart';

abstract class HomeRepository {
  Future<List<PromoBannerModel>> getPromoBanners();
  Future<List<CategoryModel>> getCategories();
  Future<List<ProductModel>> getCuratedArrivals();
}

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<List<PromoBannerModel>> getPromoBanners() async {
    return [
      PromoBannerModel(
        id: 'banner_1',
        badgeText: 'SEASON ATELIER',
        title: 'Italian Saffiano Leather',
        subtitle: 'Up to 40% off bespoke travel bags & wallets',
        visualEmoji: '👜',
        imageAsset: Assets.images.bannerBag.path,
      ),
      PromoBannerModel(
        id: 'banner_2',
        badgeText: 'LIMITED EDITION',
        title: 'Bespoke Chronographs',
        subtitle: 'Swiss-movement artisan timepieces for connoisseurs',
        visualEmoji: '⌚',
        imageAsset: Assets.images.bannerWatch.path,
      ),
      PromoBannerModel(
        id: 'banner_3',
        badgeText: 'ATELIER EXCLUSIVE',
        title: 'Handcrafted Heritage',
        subtitle: 'Custom silver & 18k gold handcrafted jewelry',
        visualEmoji: '💍',
        imageAsset: Assets.images.bannerRing.path,
      ),
    ];
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    return const [
      CategoryModel(id: 'all', name: 'All Items'),
      CategoryModel(id: 'watches', name: 'Watches'),
      CategoryModel(id: 'bags', name: 'Bags'),
      CategoryModel(id: 'eyewear', name: 'Eyewear'),
      CategoryModel(id: 'jewelry', name: 'Jewelry'),
      CategoryModel(id: 'wallets', name: 'Wallets'),
    ];
  }

  @override
  Future<List<ProductModel>> getCuratedArrivals() async {
    return const [
      ProductModel(
        id: 'prod_1',
        name: 'Chronograph Watch',
        categoryId: 'watches',
        currentPrice: 149.00,
        originalPrice: 199.00,
        rating: 4.9,
        reviewsCount: 84,
        emoji: '⌚',
        imageUrl:
            'https://images.unsplash.com/photo-1524805444758-089113d48a6d?auto=format&fit=crop&w=600&q=80',
        discountTag: '-25%',
        isFavorite: false,
      ),
      ProductModel(
        id: 'prod_2',
        name: 'Saffiano Tote Bag',
        categoryId: 'bags',
        currentPrice: 240.00,
        originalPrice: 280.00,
        rating: 4.8,
        reviewsCount: 62,
        emoji: '👜',
        imageUrl:
            'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&w=600&q=80',
        discountTag: '-15%',
        isFavorite: true,
      ),
      ProductModel(
        id: 'prod_3',
        name: 'Classic Aviator',
        categoryId: 'eyewear',
        currentPrice: 110.00,
        originalPrice: 135.00,
        rating: 4.7,
        reviewsCount: 45,
        emoji: '🕶️',
        imageUrl:
            'https://images.unsplash.com/photo-1572635196237-14b3f281503f?auto=format&fit=crop&w=600&q=80',
        discountTag: '-18%',
        isFavorite: false,
      ),
      ProductModel(
        id: 'prod_4',
        name: 'Signet Gold Ring',
        categoryId: 'jewelry',
        currentPrice: 185.00,
        originalPrice: 220.00,
        rating: 4.9,
        reviewsCount: 112,
        emoji: '💍',
        imageUrl:
            'https://images.unsplash.com/photo-1605100804763-247f67b3557e?auto=format&fit=crop&w=600&q=80',
        discountTag: '-15%',
        isFavorite: false,
      ),
      ProductModel(
        id: 'prod_5',
        name: 'Heritage Slim Wallet',
        categoryId: 'wallets',
        currentPrice: 85.00,
        originalPrice: 105.00,
        rating: 4.9,
        reviewsCount: 98,
        emoji: '👛',
        imageUrl:
            'https://images.unsplash.com/photo-1627123424574-724758594e93?auto=format&fit=crop&w=600&q=80',
        discountTag: '-20%',
        isFavorite: false,
      ),
    ];
  }
}
