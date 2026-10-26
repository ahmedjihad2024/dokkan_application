import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/request_state.dart';
import '../../data/models/manage_product_item.dart';
import '../../data/repositories/manage_products_repository.dart';
import 'manage_products_state.dart';

class ManageProductsCubit extends Cubit<ManageProductsState> {
  final ManageProductsRepository _repository;

  ManageProductsCubit({
    ManageProductsRepository? repository,
    List<ManageProductItem>? initialItems,
  })  : _repository = repository ?? ManageProductsRepositoryImpl(),
        super(ManageProductsState(
          status: initialItems != null ? ReqState.success : ReqState.idle,
          products: initialItems ?? const [],
        )) {
    if (initialItems == null) {
      loadProducts();
    }
  }

  Future<void> loadProducts() async {
    emit(state.copyWith(status: ReqState.loading));
    try {
      final items = await _repository.getProducts();
      emit(state.copyWith(
        status: items.isEmpty ? ReqState.empty : ReqState.success,
        products: items,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ReqState.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> refreshProducts() async {
    emit(state.copyWith(isRefreshing: true));
    // Simulated network delay / timer as requested
    await Future.delayed(const Duration(milliseconds: 1200));
    try {
      final items = await _repository.getProducts();
      emit(state.copyWith(
        status: items.isEmpty ? ReqState.empty : ReqState.success,
        products: items,
        isRefreshing: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isRefreshing: false,
        errorMessage: e.toString(),
      ));
    }
  }

  void deleteProduct(ManageProductItem item) {
    final updatedList = state.products.where((p) => p.id != item.id).toList();
    emit(state.copyWith(
      products: updatedList,
      status: updatedList.isEmpty ? ReqState.empty : ReqState.success,
    ));
  }
}
