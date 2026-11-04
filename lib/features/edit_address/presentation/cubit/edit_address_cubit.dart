import 'package:dokkan/core/network/failure_message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/request/edit_address_request.dart';
import '../../domain/usecase/create_address_usecase.dart';
import '../../domain/usecase/update_address_usecase.dart';
import 'edit_address_state.dart';

class EditAddressCubit extends Cubit<EditAddressState> {
  final CreateAddressUseCase createAddressUseCase;
  final UpdateAddressUseCase updateAddressUseCase;

  EditAddressCubit({
    required this.createAddressUseCase,
    required this.updateAddressUseCase,
  }) : super(const EditAddressInitial());

  Future<void> saveAddress({
    required EditAddressRequest request,
    String? addressId,
  }) async {
    emit(const EditAddressLoading());

    if (addressId != null && addressId.isNotEmpty) {
      final result = await updateAddressUseCase(addressId, request);
      result.fold(
        (failure) => emit(EditAddressError(failure.message)),
        (address) => emit(EditAddressSuccess(address, isEditing: true)),
      );
    } else {
      final result = await createAddressUseCase(request);
      result.fold(
        (failure) => emit(EditAddressError(failure.message)),
        (address) => emit(EditAddressSuccess(address, isEditing: false)),
      );
    }
  }

  Future<void> createAddress(EditAddressRequest request) async {
    return saveAddress(request: request);
  }

  Future<void> updateAddress(String addressId, EditAddressRequest request) async {
    return saveAddress(request: request, addressId: addressId);
  }
}

