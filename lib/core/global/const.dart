import 'package:intl/intl.dart';

import '../services/network_service.dart/dio_network_service.dart';

const String dummyImage = "https://picsum.photos/800";
const String emptyImage =
    "https://assets2.lottiefiles.com/private_files/lf30_e3pteeho.json";
final NetworkService networkService = NetworkService(
  baseUrl: APIKeys.baseUrl,
  httpHeaders: {
    'Accept': 'application/json',
    'api_password': "drV1DHcwSgFE8ebzBUR523Ym9fo9TGrKFKtPX9xSAEHJ90B7DK",
    'Authorization': 'Bearer 1|92Kko8UWf4LO2KvpPlullUjZwY0oX8MMbui0tJFG',
  },
);
String appDateFormate(DateTime date, String locale) {
  String pattern = 'yyyy-MM-dd';
  var format = DateFormat(pattern, locale);
  var dateString = format.format(date);
  return dateString;
}

String appTimeFormate(DateTime time, String locale) {
  String pattern = 'HH:mm';
  var format = DateFormat(pattern, locale);
  var timeString = format.format(time);
  return timeString;
}

class APIKeys {
  static const String baseUrl = "https://api.shreak.net/api/v1/";
  static const String home = "home";
  static const String businessAds = "business-advertisements";

  static const String businessAdsSearch = "search/business-advertisements";
  static const String createBusinessAdComment =
      "create/comment/business-advertisement/";
  static String verifyEmail = "/api/verify/email/code";
  static String forgetPassword = "/api/send/code/reset/password";
  static String receiveResetPasswordOtp = "/api/verify/password/code";
  static String setNewPassword = "/api/reset/password";
  static String resendOtpCode = "/api/resend/code";
  static String getUserData = "/api/user/info";
  static String getHomeOffers = "/api/ads";
  static String getMainServices = "/api/all/main/service";
  static String getMainProducts = "/api/all/main/product";
  static String getAllOffers = "/api/all/offers";
  static String editUserImage = "/api/edit/img";
  static String editName = "/api/edit/name";
  static String editPassword = "/api/edit/password";
  static String editPhone = "/api/edit/phone";
  static String editEmail = "/api/edit/email";
  static String editEmailOtp = "/api/edit/email";
  static String editEmailResendOtp = "/api/check/code/to/change/email";
  static String getSubServices = "/api/all/sub/service/belong/main/service";
  static String getSubProducts = "/api/all/sub/product/belong/main/product";
  static String addProductToFavorite = "/api/add/product/favorite";
  static String getAllFavorites = "/api/all/product/favorites";
  static String removeFavoriteItem = "/api/delete/product/favorite";
  static String logOut = "/api/logout";
  static String getAllSubProducts = "/api/all/sub/product";
  static String getAllSubServices = "/api/all/sub/service";
  static String addToCart = "/api/add/product/cart";
  static String requestServices = "/api/service/request";
  static String addAddress = "/api/add/address";
  static String getAllAddresses = "/api/all/addresses";
  static String getCartItems = "/api/all/product/carts";
  static String removeCartItem = "/api/delete/product/cart";
  static String getAllBranches = "/api/all/company/branch";
  static String getAllNotification = "/api/all/notifications";
  static String deleteAllNotification = "/api/delete/all/notifications";
  static String deleteOneNotification = "/api/delete/one/notification";
  static String numOfNotification = "/api/number/of/notifications";
  static String getCurrentServices = "/api/all/order/services";
  static String getDoneServices = "/api/all/order/services/done";
  static String getCurrentProducts = "/api/all/order/products";
  static String getDoneProducts = "/api/all/order/products/done";
  static String contactUs = "/api/contact/us";
  static String servicesSearch = "/api/search/main/service";
  static String productsSearch = "/api/search/main/product";
  static String resendRejectedService = "/api/resend/service/request";
  static String buyAcceptedService = "/api/buy/service";
  static String applyDiscountCode = "/api/check/cobon";
  static String buyProduct = "/api/buy/products";
  //=============================Trip================================
  static const String tripAds = "trip-advertisements";
  static const String tripServicesType = "trip-advertisement/service/types";
  static const String createTripComment = "create/comment/trip-advertisement/";
  static const String tripAdsSearch = "search/$tripAds";
  //============================Comment==============================
  static const String createComment = "create/comment/";
  //=================================================================
}
