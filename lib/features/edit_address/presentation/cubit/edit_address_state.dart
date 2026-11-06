import 'package:dokkan/features/checkout/domain/model/address_entity.dart';

abstract class EditAddressState {
  const EditAddressState();
}

class EditAddressInitial extends EditAddressState {
  const EditAddressInitial();
}

class EditAddressLoading extends EditAddressState {
  const EditAddressLoading();
}

class EditAddressSuccess extends EditAddressState {
  final AddressEntity address;
  final bool isEditing;

  const EditAddressSuccess(this.address, {this.isEditing = false});
}

class EditAddressError extends EditAddressState {
  final String message;

  const EditAddressError(this.message);
}

