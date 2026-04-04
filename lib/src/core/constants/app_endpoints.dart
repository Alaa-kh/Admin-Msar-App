class AppEndpoints {
  static const base = 'http://qucikk.cloud/api/';

  static const login = 'login';
  static const refresh = 'refresh';
  static const logout = 'logout';
  static const forgotPassword = 'forgot-password';
  static const verifyPassword = 'confirm-forgot-password';
  static const newPassword = 'reset-password';
  static const register = 'register';
  static const verifyAccount = 'confirm-registration';
  static const resendCode = 'resend-otp';
  static const homeAds = 'ads';
  static const profile = 'user/profile';
  static const sections = 'categories';
  static const sectionProducts = 'products';
  static String shopsByCategory(int categoryId) =>
      'stores/category/$categoryId';
  static const storesHomeList = 'stores-list';
  static const shops = 'stores';
  static const shopProducts = 'store/subcategories';
  static const addCart = 'cart/items';
  static const cart = 'cart';
  static const complaint = 'complaint';
  static const cashout = 'checkout/preview?coupon_code=';
  static const validateCoupon = 'checkout/validate-coupon';
  static const checkout = 'checkout';

  static const String allOrders = 'all-orders';
  static const String orders = 'orders';
  static const String customOrders = 'custom-orders';
  static const String adminOffers = 'home/admin-offers';
  static const String storeOffers = 'home/store-offers';
  static const String deviceRegister = 'device/register';

  static String ordersList({String? status, int perPage = 15, int page = 1}) =>
      '$orders?status=${status ?? ""}&per_page=$perPage&page=$page';

  static String customOrdersList({
    String? status,
    int perPage = 15,
    int page = 1,
  }) => '$customOrders?status=${status ?? ""}&per_page=$perPage&page=$page';

  static String orderDetails(int id) => '$orders/$id';
  static String reorder(int id) => '$orders/$id/reorder';

  static String customOrderDetails(int id) => '$customOrders/$id';
  static String cancelCustomOrder(int id) => '$customOrders/$id/cancel';

  static String orderDriverLocation(int id) => '$orders/$id/driver-location';
  static String customOrderDriverLocation(int id) =>
      '$customOrders/$id/driver-location';

  static const String rating = 'ratings';
  static const String calculateDeliveryFee = 'custom-orders/calculate-fee';
}
