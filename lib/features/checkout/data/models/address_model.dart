class AddressModel {
  final String id;
  final String tag;
  final String state;
  final String city;
  final String street;
  final String apartment;
  final String phoneNumber;
  final String? deliveryNotes;
  final bool isDefault;

  const AddressModel({
    required this.id,
    required this.tag,
    required this.state,
    required this.city,
    required this.street,
    required this.apartment,
    required this.phoneNumber,
    this.deliveryNotes,
    this.isDefault = false,
  });

  String get fullAddress => '$street, $apartment, $city, $state';
  String get phone => phoneNumber;
  String? get notes => deliveryNotes;

  AddressModel copyWith({
    String? id,
    String? tag,
    String? state,
    String? city,
    String? street,
    String? apartment,
    String? phoneNumber,
    String? deliveryNotes,
    bool? isDefault,
  }) {
    return AddressModel(
      id: id ?? this.id,
      tag: tag ?? this.tag,
      state: state ?? this.state,
      city: city ?? this.city,
      street: street ?? this.street,
      apartment: apartment ?? this.apartment,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      deliveryNotes: deliveryNotes ?? this.deliveryNotes,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  static List<AddressModel> mockAddresses() {
    return [
      const AddressModel(
        id: 'addr_1',
        tag: 'HOME',
        state: 'Cairo Governorate',
        city: 'New Cairo',
        street: 'El-Teseen St, Building 42',
        apartment: 'Apartment 3, Floor 2',
        phoneNumber: '+20 102 345 6789',
        deliveryNotes: 'Leave with security at main gate',
        isDefault: true,
      ),
      const AddressModel(
        id: 'addr_2',
        tag: 'OFFICE',
        state: 'Giza Governorate',
        city: 'Smart Village',
        street: 'Building B12, Floor 4',
        apartment: 'Suite 402',
        phoneNumber: '+20 114 987 6543',
        deliveryNotes: 'Deliver between 9 AM and 5 PM',
        isDefault: false,
      ),
      const AddressModel(
        id: 'addr_3',
        tag: 'OTHER',
        state: 'Alexandria Governorate',
        city: 'Kafr Abdo',
        street: 'Ismailia Canal St, Villa 8',
        apartment: 'Ground Floor',
        phoneNumber: '+20 128 555 4321',
        deliveryNotes: 'Ring bell twice upon arrival',
        isDefault: false,
      ),
    ];
  }
}

