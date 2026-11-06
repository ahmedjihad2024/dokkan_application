import 'package:dokkan/core/network/failure_message.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/feedback/custom_snackbar.dart';
import '../../../cart/domain/usecase/get_cart_usecase.dart';
import '../../data/request/address_request.dart';
import '../../domain/model/address_entity.dart';
import '../../domain/usecase/create_address_usecase.dart';
import '../../domain/usecase/delete_address_usecase.dart';
import '../../domain/usecase/get_addresses_usecase.dart';
import 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final GetAddressesUseCase getAddressesUseCase;
  final CreateAddressUseCase createAddressUseCase;
  final DeleteAddressUseCase deleteAddressUseCase;
  final GetCartUseCase getCartUseCase;

  CheckoutCubit({
    required this.getAddressesUseCase,
    required this.createAddressUseCase,
    required this.deleteAddressUseCase,
    required this.getCartUseCase,
  }) : super(const CheckoutState.initial());

  Future<void> getAddresses() async {
    emit(state.asAddressLoading());

    final result = await getAddressesUseCase();

    result.fold(
      (failure) {
        emit(state.asAddressError(failure.message));
      },
      (addresses) {
        String? selectedId = state.selectedAddressId;
        final exists = addresses.any((a) => a.id == selectedId);

        if (!exists) {
          final defaultAddress =
              addresses.where((a) => a.isDefault).firstOrNull;
          selectedId = defaultAddress?.id ?? addresses.firstOrNull?.id;
        }

        emit(
          state.asAddressSuccess(
            addresses: addresses,
            selectedAddressId: selectedId,
          ),
        );
      },
    );
  }

  Future<void> getCart() async {
    emit(state.asCartLoading());

    final result = await getCartUseCase();

    result.fold(
      (failure) {
        emit(state.asCartError(failure.message));
      },
      (cart) {
        emit(state.asCartSuccess(cart));
      },
    );
  }

  void selectAddress(String id) {
    emit(
      state.asAddressSuccess(
        addresses: state.addresses,
        selectedAddressId: id,
      ),
    );
  }

  Future<AddressEntity?> createAddress(
    AddressRequest request, {
    BuildContext? context,
  }) async {
    final result = await createAddressUseCase(request);

    return result.fold(
      (failure) {
        if (context != null && context.mounted) {
          CustomSnackBar.showError(
            context,
            failure.message.isNotEmpty
                ? failure.message
                : 'Failed to add address',
          );
        }
        return null;
      },
      (newAddress) {
        addAddressLocally(newAddress);
        if (context != null && context.mounted) {
          CustomSnackBar.showSuccess(
            context,
            'Delivery address added successfully',
          );
        }
        return newAddress;
      },
    );
  }

  Future<bool> deleteAddress(String id, {BuildContext? context}) async {
    emit(state.asAddressDeleting(id));

    final result = await deleteAddressUseCase(id);

    return result.fold(
      (failure) {
        emit(
          state.asAddressSuccess(
            addresses: state.addresses,
            selectedAddressId: state.selectedAddressId,
          ),
        );
        if (context != null && context.mounted) {
          CustomSnackBar.showError(
            context,
            failure.message.isNotEmpty
                ? failure.message
                : 'Failed to delete address',
          );
        }
        return false;
      },
      (_) {
        final updated =
            state.addresses.where((a) => a.id != id).toList();
        String? newSelectedId = state.selectedAddressId;
        if (newSelectedId == id) {
          newSelectedId = updated.isNotEmpty ? updated.first.id : null;
        }

        emit(
          state.asAddressSuccess(
            addresses: updated,
            selectedAddressId: newSelectedId,
          ),
        );

        if (context != null && context.mounted) {
          CustomSnackBar.showSuccess(
            context,
            'Address deleted successfully',
          );
        }
        return true;
      },
    );
  }

  void addAddressLocally(AddressEntity address) {
    final updated = List<AddressEntity>.from(state.addresses)..add(address);
    emit(
      state.asAddressSuccess(
        addresses: updated,
        selectedAddressId: address.id,
      ),
    );
  }

  void editAddressLocally(AddressEntity updatedAddress) {
    final updated = state.addresses.map((a) {
      return a.id == updatedAddress.id ? updatedAddress : a;
    }).toList();
    emit(
      state.asAddressSuccess(
        addresses: updated,
        selectedAddressId: state.selectedAddressId,
      ),
    );
  }

  void removeAddressLocally(String id) {
    final updated = state.addresses.where((a) => a.id != id).toList();
    String? newSelectedId = state.selectedAddressId;
    if (newSelectedId == id) {
      newSelectedId = updated.isNotEmpty ? updated.first.id : null;
    }
    emit(
      state.asAddressSuccess(
        addresses: updated,
        selectedAddressId: newSelectedId,
      ),
    );
  }
}
