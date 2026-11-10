// import '../../../../core/res/gen/assets.gen.dart';
// import '../models/manage_product_item.dart';

// abstract class ManageProductsRepository {
//   Future<List<ManageProductItem>> getProducts();
// }

// class ManageProductsRepositoryImpl implements ManageProductsRepository {
//   @override
//   Future<List<ManageProductItem>> getProducts() async {
//     return [
//       ManageProductItem(
//         id: 'prod_heritage_steel',
//         name: 'Heritage Chronograph Steel',
//         arabicName: 'ساعة كرونوغراف ستيل',
//         price: 149.00,
//         stock: 8,
//         imageAsset: Assets.images.bannerWatch.path,
//         emoji: '⌚',
//       ),
//       ManageProductItem(
//         id: 'prod_italian_tote',
//         name: 'Italian Saffiano Tote',
//         arabicName: 'حقيبة سافيانو جلد',
//         price: 240.00,
//         stock: 14,
//         imageAsset: Assets.images.bannerBag.path,
//         emoji: '👜',
//       ),
//       ManageProductItem(
//         id: 'prod_milanese_mesh',
//         name: 'Milanese Gold Mesh',
//         arabicName: 'ساعة ميلانيز ذهبية',
//         price: 185.00,
//         stock: 5,
//         imageAsset: Assets.images.bannerWatch.path,
//         emoji: '⌚',
//       ),
//       ManageProductItem(
//         id: 'prod_bespoke_ring',
//         name: 'Bespoke Gold Signet Ring',
//         arabicName: 'خاتم ذهبي مصقول',
//         price: 185.00,
//         stock: 3,
//         imageAsset: Assets.images.bannerRing.path,
//         emoji: '💍',
//       ),
//     ];
//   }
// }

import 'package:dokkan/core/shared/data/data_source/product_remote_data_source.dart';
import 'package:dokkan/core/shared/data/request/products_request.dart';

import '../../../../core/res/gen/assets.gen.dart';
import '../models/manage_product_item.dart';

abstract class ManageProductsRepository {
  Future<List<ManageProductItem>> getProducts();
  Future<void> deleteProduct(String id);
}

class ManageProductsRepositoryImpl implements ManageProductsRepository {
  final ProductRemoteDataSource? remoteDataSource;

  ManageProductsRepositoryImpl({this.remoteDataSource});

  @override
  Future<List<ManageProductItem>> getProducts() async {
    try {
      if (remoteDataSource != null) {
        final response = await remoteDataSource!.getProducts(const ProductsRequest());
        final list = response.items; 
        
        return list.map((model) => ManageProductItem(
          id: model.id.toString(),
          name: model.name,
          arabicName: model.arabicName ?? model.name,
          price: model.price.toDouble(),
          stock: model.stock,
          imageAsset: Assets.images.bannerWatch.path,
        )).toList();
      }
    } catch (_) {}

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
    ];
  }

  @override
  Future<void> deleteProduct(String id) async {
    if (remoteDataSource != null) {
      await remoteDataSource!.deleteProduct(id);
    } else {
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }
}