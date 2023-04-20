import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/network_service.dart/dio_network_service.dart';

const String dummyImage = "https://picsum.photos/800";
const String emptyImage =
    "https://assets2.lottiefiles.com/private_files/lf30_e3pteeho.json";
final NetworkService networkService = NetworkService(
  baseUrl: APIKeys.baseUrl,
);
late SharedPreferences globalPrefs;

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
  static const String apiPassword =
      "drV1DHcwSgFE8ebzBUR523Ym9fo9TGrKFKtPX9xSAEHJ90B7DK";

  static const String baseUrl = "https://shreak.net/api/v1/";
  static const String home = "home";
  static const String businessAds = "business-advertisements";

  static const String businessAdsSearch = "search/business-advertisements";
  static const String createBusinessAdComment =
      "create/comment/business-advertisement/";

  //=============================Trip================================
  static const String tripAds = "trip-advertisements";
  static const String tripServicesType = "trip-advertisement/service/types";
  static const String createTripComment = "create/comment/trip-advertisement/";
  static const String tripAdsSearch = "search/$tripAds";
  //============================Comment==============================
  static const String createComment = "create/comment/";
  //============================Auth=================================
  static const String register = "register";
  static const String login = "login";
  static const String otpLogin = "verify/login/code";
  static const String otpRegister = "verify/register/code";
  //===========================Profile===============================
  static const String updateAvatar = "update/avatar";
  static const String updateProfile = "update/profile";
  static const String logout = "logout";
  //=================================================================
  static const String housingAds = "housing-advertisements";
  static const String housingServicesType =
      "housing-advertisement/service/types";
  static const String createhousingComment =
      "create/comment/housing-advertisement/";
  static const String housingAdsSearch = "search/$housingAds";
  //=============================other ads===========================
  static const String otherAds = "another-advertisements";
  static const String createOtherComment =
      "create/comment/another-advertisement/";
  //=================================================================
}
