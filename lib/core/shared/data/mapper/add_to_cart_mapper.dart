import '../../domain/model/add_to_cart_entity.dart';
import '../response/add_to_cart_response.dart';

extension AddToCartResponseMapper on AddToCartResponse {
  AddToCartEntity toDomain() {
    return AddToCartEntity(
      message: message,
      id: id,
      productId: productId,
      quantity: quantity,
    );
  }
}

