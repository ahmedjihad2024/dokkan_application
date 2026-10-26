import '../../../../core/enums/request_state.dart';
import '../../data/models/manage_product_item.dart';

class ManageProductsState {
  final ReqState status;
  final List<ManageProductItem> products;
  final String? errorMessage;
  final bool isRefreshing;

  const ManageProductsState({
    this.status = ReqState.idle,
    this.products = const [],
    this.errorMessage,
    this.isRefreshing = false,
  });

  ManageProductsState copyWith({
    ReqState? status,
    List<ManageProductItem>? products,
    String? errorMessage,
    bool? isRefreshing,
  }) {
    return ManageProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }
}
