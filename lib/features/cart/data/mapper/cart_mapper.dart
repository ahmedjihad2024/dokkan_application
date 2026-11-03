import '../../domain/model/cart_entity.dart';
import '../../domain/model/decrement_cart_item_entity.dart';
import '../response/decrement_cart_item_response.dart';
import '../response/get_cart_response.dart';

extension GetCartResponseMapper on GetCartResponse {
  CartEntity toDomain() {
    return CartEntity(
      cartId: cartId,
      items: cartItems.map((e) => e.toDomain()).toList(),
    );
  }
}

extension CartItemResponseMapper on CartItemResponse {
  CartItemEntity toDomain() {
    return CartItemEntity(
      itemId: itemId,
      productId: productId,
      productName: productName,
      productCoverUrl: productCoverUrl,
      productStock: productStock,
      weightInGrams: weightInGrams,
      quantity: quantity,
      discountPercentage: discountPercentage,
      basePricePerUnit: basePricePerUnit,
      finalPricePerUnit: finalPricePerUnit,
      totalPrice: totalPrice,
    );
  }
}

extension DecrementCartItemResponseMapper on DecrementCartItemResponse {
  DecrementCartItemEntity toDomain() {
    return DecrementCartItemEntity(
      message: message,
      itemId: itemId,
      productId: productId,
      quantity: quantity,
    );
  }
}

