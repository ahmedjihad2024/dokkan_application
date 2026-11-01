enum PaymentType {
  paymobCard,
  cashOnDelivery,
  mobileWallet,
}

class PaymentMethodModel {
  final String id;
  final String title;
  final String subtitle;
  final PaymentType type;
  final String icon;
  final List<String> badges;
  final bool isDefault;

  const PaymentMethodModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.icon,
    this.badges = const [],
    this.isDefault = false,
  });

  static List<PaymentMethodModel> mockMethods() {
    return const [
      PaymentMethodModel(
        id: 'pm_paymob',
        title: 'Credit / Debit Card (Paymob)',
        subtitle: 'Instant secure checkout via Visa, Mastercard, and Meeza',
        type: PaymentType.paymobCard,
        icon: '💳',
        badges: ['VISA', 'MASTERCARD', 'MEEZA'],
        isDefault: true,
      ),
      PaymentMethodModel(
        id: 'pm_wallet',
        title: 'Mobile Wallets & InstaPay',
        subtitle: 'Vodafone Cash, Orange Cash, Etisalat, WE, and InstaPay IPA',
        type: PaymentType.mobileWallet,
        icon: '📱',
        badges: ['INSTAPAY', 'VODAFONE', 'ORANGE'],
        isDefault: false,
      ),
      PaymentMethodModel(
        id: 'pm_cod',
        title: 'Cash on Delivery (COD)',
        subtitle: 'Pay in cash upon receipt of order at your doorstep',
        type: PaymentType.cashOnDelivery,
        icon: '💵',
        badges: ['CASH'],
        isDefault: false,
      ),
    ];
  }
}

