class EditAddressRequest {
  final String state;
  final String city;
  final String street;
  final String apartment;
  final String phoneNumber;
  final String notes;

  EditAddressRequest({
    required this.state,
    required this.city,
    required this.street,
    required this.apartment,
    required String phoneNumber,
    required this.notes,
  }) : phoneNumber = normalizePhoneNumber(phoneNumber);

  static String normalizePhoneNumber(String phone) {
    var cleaned = phone.trim().replaceAll(' ', '').replaceAll('-', '');
    if (cleaned.startsWith('+20')) {
      cleaned = cleaned.substring(3);
    } else if (cleaned.startsWith('0020')) {
      cleaned = cleaned.substring(4);
    } else if (cleaned.startsWith('20') && cleaned.length > 10) {
      cleaned = cleaned.substring(2);
    }
    if (!cleaned.startsWith('0') && cleaned.isNotEmpty) {
      cleaned = '0$cleaned';
    }
    return cleaned;
  }

  Map<String, dynamic> toJson() => {
    'state': state,
    'city': city,
    'street': street,
    'apartment': apartment,
    'phoneNumber': phoneNumber,
    'notes': notes,
  };
}

