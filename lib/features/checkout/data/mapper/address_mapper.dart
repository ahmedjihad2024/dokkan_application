import '../../domain/model/address_entity.dart';
import '../response/address_response.dart';

extension AddressResponseMapper on AddressResponse {
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

extension AddressListResponseMapper on List<AddressResponse> {
  List<AddressEntity> toDomain() {
    return map((response) => response.toDomain()).toList();
  }
}

