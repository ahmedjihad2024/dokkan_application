import '../../../../core/res/gen/assets.gen.dart';
import '../models/manage_product_item.dart';

abstract class ManageProductsRepository {
  Future<List<ManageProductItem>> getProducts();
}

class ManageProductsRepositoryImpl implements ManageProductsRepository {
  @override
  Future<List<ManageProductItem>> getProducts() async {
    return [
      ManageProductItem(
        id: 'prod_heritage_steel',
        name: 'Heritage Chronograph Steel',
        arabicName: 'ساعة كرونوغراف ستيل',
        price: 149.00,
        stock: 8,
        imageAsset: Assets.images.bannerWatch.path,
        emoji: '⌚',
      ),
      ManageProductItem(
        id: 'prod_italian_tote',
        name: 'Italian Saffiano Tote',
        arabicName: 'حقيبة سافيانو جلد',
        price: 240.00,
        stock: 14,
        imageAsset: Assets.images.bannerBag.path,
        emoji: '👜',
      ),
      ManageProductItem(
        id: 'prod_milanese_mesh',
        name: 'Milanese Gold Mesh',
        arabicName: 'ساعة ميلانيز ذهبية',
        price: 185.00,
        stock: 5,
        imageAsset: Assets.images.bannerWatch.path,
        emoji: '⌚',
      ),
      ManageProductItem(
        id: 'prod_bespoke_ring',
        name: 'Bespoke Gold Signet Ring',
        arabicName: 'خاتم ذهبي مصقول',
        price: 185.00,
        stock: 3,
        imageAsset: Assets.images.bannerRing.path,
        emoji: '💍',
      ),
    ];
  }
}
