import '../../domain/model/cart_entity.dart';

abstract class CartState {}

class CartLoading extends CartState {}

class CartEmpty extends CartState {}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}

class CartActive extends CartState {
  final CartEntity cart;
  final bool isUpdating;

  CartActive(this.cart, {this.isUpdating = false});
}

class CartActionFailed extends CartState {
  final String message;

  CartActionFailed(this.message);
}
