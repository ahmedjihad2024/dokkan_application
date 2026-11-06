import 'package:dartz/dartz.dart';
import 'package:dokkan/core/network/failure_message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/error_handler/failure.dart';
import '../../data/request/decrement_cart_item_request.dart';
import '../../data/request/update_cart_item_request.dart';
import '../../domain/model/cart_entity.dart';
import '../../domain/usecase/decrement_cart_item_usecase.dart';
import '../../domain/usecase/delete_cart_item_usecase.dart';
import '../../domain/usecase/get_cart_usecase.dart';
import '../../domain/usecase/update_cart_item_usecase.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartUseCase _getCart;
  final UpdateCartItemUseCase _updateItem;
  final DecrementCartItemUseCase _decrementItem;
  final DeleteCartItemUseCase _deleteItem;

  CartCubit(
    this._getCart,
    this._updateItem,
    this._decrementItem,
    this._deleteItem,
  ) : super(CartLoading());

  Future<void> loadCart() async {
    emit(CartLoading());
    await _refresh();
  }

  Future<void> refreshCart() => _refresh();

  Future<void> increment(CartItemEntity item) async {
    if (!item.canIncrement) return;
    await _runAction(
      () => _updateItem(
        UpdateCartItemRequest(id: item.itemId, quantity: item.quantity + 1),
      ),
    );
  }

  Future<void> decrement(CartItemEntity item) async {
    await _runAction(
      () => _decrementItem(
        DecrementCartItemRequest(itemId: item.itemId, quantity: 1),
      ),
    );
  }

  Future<void> remove(CartItemEntity item) async {
    await _runAction(() => _deleteItem(item.itemId));
  }

  Future<void> clearCart() async {
    final current = state;
    if (current is! CartActive || current.isUpdating) return;

    emit(CartActive(current.cart, isUpdating: true));

    String? errorMessage;
    for (final item in current.cart.items) {
      final result = await _deleteItem(item.itemId);
      final failure = result.fold<Failure?>((f) => f, (_) => null);
      if (failure != null) {
        errorMessage = failure.message;
        break;
      }
    }

    if (isClosed) return;
    if (errorMessage != null) {
      emit(CartActionFailed(errorMessage));
    }
    await _refresh();
  }

  Future<void> _runAction<T>(
    Future<Either<Failure, T>> Function() action,
  ) async {
    final current = state;
    if (current is! CartActive || current.isUpdating) return;

    emit(CartActive(current.cart, isUpdating: true));

    final result = await action();
    if (isClosed) return;

    final failure = result.fold<Failure?>((f) => f, (_) => null);
    if (failure != null) {
      emit(CartActionFailed(failure.message));
    }
    await _refresh();
  }

  Future<void> _refresh() async {
    final result = await _getCart();
    if (isClosed) return;

    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cart) {
        if (cart.isEmpty) {
          emit(CartEmpty());
        } else {
          emit(CartActive(cart));
        }
      },
    );
  }
}
