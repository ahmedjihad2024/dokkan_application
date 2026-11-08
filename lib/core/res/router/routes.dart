abstract class Routes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String verifyEmailAddress = '/verify-email-address';
  static const String otpVerification = '/otp-verification';
  static const String forgotPassword = '/forgot-password';
  static const String recoveryCode = '/recovery-code';
  static const String createNewPassword = '/create-new-password';
  static const String resetPassword = '/reset-password';
  static const String home = '/home';
  static const String search = '/search';
  static const String productDetails = '/product-details';
  static const String productReviews = '/product-reviews';
  static const String cart = '/cart';
  static const String profile = '/profile';
  static const String changePassword = '/change-password';
  static const String manageProducts = '/manage-products';
  static const String addProduct = '/add-product';
  static const String aboutUs = '/about-us';
  static const String contactUs = '/contact-us';
  static const String privacyPolicy = '/privacy-policy';

  // ─── Checkout & Payment Flow ──────────────────────────────
  static const String checkout = '/checkout';
  static const String checkoutSelectAddress = '/checkout/select-address';
  static const String checkoutAddEditAddress = '/checkout/add-edit-address';
  static const String checkoutPaymentMethod = '/checkout/payment-method';
  static const String checkoutOrderSummary = '/checkout/order-summary';
  static const String checkoutPaymentRedirect = '/checkout/payment-redirect';
  static const String checkoutPaymentSuccess = '/checkout/payment-success';
  static const String checkoutPaymentFailed = '/checkout/payment-failed';
}
