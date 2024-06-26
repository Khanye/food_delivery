class AppConstants{
  static const String APP_NAME = "QuickMeal";
  static const int APP_VERSION = 1;

  static const String BASE_URL = "http://10.0.2.2:8000";
  //static const String BASE_URL = "http://mvs.bslmeiyu.com";
  static const String POPULAR_PRODUCT_URI = "/api/v1/products/popular";
  static const String RECOMMENDED_PRODUCT_URI = "/api/v1/products/recommended";
  static const String DRINKS_URI = "/api/v1/products/drinks";
  static const String UPLOAD_URI = "/uploads/";

  //auth end points
  static const String REGISTRATION_URI = "/api/v1/auth/register";

  static const String TOKEN = "DBtoken";
  static const String CART_LIST = "cart-list";
  static const String CART_HISTORY_LIST = "cart-history-list";
}