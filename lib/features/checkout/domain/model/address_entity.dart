class AddressEntity {
  final String id;
  final String tag;
  final String state;
  final String city;
  final String street;
  final String apartment;
  final String phoneNumber;
  final String? deliveryNotes;
  final bool isDefault;

  const AddressEntity({
    required this.id,
    this.tag = 'HOME',
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
  String get notes => deliveryNotes ?? '';

  AddressEntity copyWith({
    String? id,
    String? tag,
    String? state,
    String? city,
    String? street,
    String? apartment,
    String? phoneNumber,
    String? deliveryNotes,
    String? notes,
    bool? isDefault,
  }) {
    return AddressEntity(
      id: id ?? this.id,
      tag: tag ?? this.tag,
      state: state ?? this.state,
      city: city ?? this.city,
      street: street ?? this.street,
      apartment: apartment ?? this.apartment,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      deliveryNotes: deliveryNotes ?? notes ?? this.deliveryNotes,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  static List<AddressEntity> mockAddresses() {
    return const [
      AddressEntity(
        id: 'addr_1',
        tag: 'HOME',
        state: 'Cairo Governorate',
        city: 'New Cairo',
        street: 'El-Teseen St, Building 42',
        apartment: 'Apartment 3, Floor 2',
        phoneNumber: '01023456789',
        deliveryNotes: 'Leave with security at main gate',
        isDefault: true,
      ),
      AddressEntity(
        id: 'addr_2',
        tag: 'OFFICE',
        state: 'Giza Governorate',
        city: 'Smart Village',
        street: 'Building B12, Floor 4',
        apartment: 'Suite 402',
        phoneNumber: '01149876543',
        deliveryNotes: 'Deliver between 9 AM and 5 PM',
        isDefault: false,
      ),
      AddressEntity(
        id: 'addr_3',
        tag: 'OTHER',
        state: 'Alexandria Governorate',
        city: 'Kafr Abdo',
        street: 'Ismailia Canal St, Villa 8',
        apartment: 'Ground Floor',
        phoneNumber: '01285554321',
        deliveryNotes: 'Ring bell twice upon arrival',
        isDefault: false,
      ),
    ];
  }
}

typedef AddressModel = AddressEntity;

