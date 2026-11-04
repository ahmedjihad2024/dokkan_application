import 'package:dokkan/features/checkout/domain/model/address_entity.dart';
import '../response/edit_address_response.dart';

extension EditAddressResponseMapper on EditAddressResponse {
  AddressEntity toDomain() {
    return AddressEntity(
      id: id,
      state: state,
      city: city,
      street: street,
      apartment: apartment,
      phoneNumber: phoneNumber,
      deliveryNotes: notes,
    );
  }
}
