import '../../../../core/network/base_response.dart';

class EditAddressResponse implements BasicResponse {
  final String id;
  final String state;
  final String city;
  final String street;
  final String apartment;
  final String phoneNumber;
  final String notes;

  const EditAddressResponse({
    required this.id,
    required this.state,
    required this.city,
    required this.street,
    required this.apartment,
    required this.phoneNumber,
    required this.notes,
  });

  @override
  bool get success => true;

  @override
  String get message => '';

  factory EditAddressResponse.fromJson(Map<String, dynamic> json) {
    return EditAddressResponse(
      id: json['id'] as String? ?? '',
      state: json['state'] as String? ?? '',
      city: json['city'] as String? ?? '',
      street: json['street'] as String? ?? '',
      apartment: json['apartment'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      notes: json['notes'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'state': state,
    'city': city,
    'street': street,
    'apartment': apartment,
    'phoneNumber': phoneNumber,
    'notes': notes,
  };
}

