import 'package:dokkan/core/events/app_event_bus.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/failure_message.dart';
import '../../../../core/shared/data/request/add_to_cart_request.dart';
import '../../../../core/shared/domain/model/product_entity.dart';
import '../../../../core/shared/domain/usecase/add_to_cart_usecase.dart';
import '../../../../core/widgets/feedback/custom_snackbar.dart';
import '../../domain/usecase/get_favorites_usecase.dart';
import '../../domain/usecase/is_favorite_usecase.dart';
import '../../domain/usecase/remove_from_favorites_usecase.dart';
import '../../domain/usecase/toggle_favorite_usecase.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final GetFavoritesUseCase getFavoritesUseCase;
  final RemoveFromFavoritesUseCase removeFromFavoritesUseCase;
  final AddToCartUseCase addToCartUseCase;
  final IsFavoriteUseCase isFavoriteUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  FavoritesCubit({
    required this.getFavoritesUseCase,
    required this.removeFromFavoritesUseCase,
    required this.addToCartUseCase,
    required this.isFavoriteUseCase,
    required this.toggleFavoriteUseCase,
  }) : super(const FavoritesInitial());

  List<ProductEntity> _products = [];
  List<ProductEntity> get products => _products;

  bool isFavorite(String id) {
    final result = isFavoriteUseCase(id);
    return result.fold((failure) => false, (r) => r);
  }

  bool isFavroite(String id) => isFavorite(id);

  Future<void> loadFavorites() async {
    final result = await getFavoritesUseCase();
    result.fold(
      (failure) {
        _products = [];
        emit(const FavoritesEmpty());
      },
      (items) {
        _products = List<ProductEntity>.from(items);
        if (_products.isEmpty) {
          emit(const FavoritesEmpty());
        } else {
          emit(FavoritesLoaded(List.unmodifiable(_products)));
        }
      },
    );
  }

  Future<void> removeFavorite(String productId) async {
    final result = await removeFromFavoritesUseCase(productId);
    result.fold((failure) {}, (_) {
      _products.removeWhere((p) => p.id == productId);
      if (_products.isEmpty) {
        emit(const FavoritesEmpty());
      } else {
        emit(FavoritesLoaded(List.unmodifiable(_products)));
      }
      AppEventBus.instance.fire(ProductFavoriteChanged());
    });
  }

  Future<bool> toggleFavorite(
    ProductEntity product, [
    BuildContext? context,
  ]) async {
    final result = await toggleFavoriteUseCase(product);
    return result.fold(
      (failure) {
        if (context != null && context.mounted) {
          CustomSnackBar.showError(context, failure.message);
        }
        return false;
      },
      (isFav) {
        if (isFav) {
          if (!_products.any((p) => p.id == product.id)) {
            _products.add(product);
          }
        } else {
          _products.removeWhere((p) => p.id == product.id);
        }

        if (_products.isEmpty) {
          emit(const FavoritesEmpty());
        } else {
          emit(FavoritesLoaded(List.unmodifiable(_products)));
        }

        if (context != null && context.mounted) {
          CustomSnackBar.showSuccess(
            context,
            isFav
                ? '${product.name} added to favorites'
                : 'Removed from favorites',
          );
        }
        AppEventBus.instance.fire(ProductFavoriteChanged());
        return isFav;
      },
    );
  }

  Future<void> addToCart(ProductEntity product, BuildContext context) async {
    final result = await addToCartUseCase(
      AddToCartRequest(productId: product.id, quantity: 1),
    );

    if (!context.mounted) return;

    result.fold(
      (failure) {
        CustomSnackBar.showError(context, failure.message);
      },
      (cartEntity) {
        CustomSnackBar.showSuccess(
          context,
          cartEntity.message.isNotEmpty
              ? cartEntity.message
              : '${product.name} added to cart',
        );
      },
    );
  }
}
