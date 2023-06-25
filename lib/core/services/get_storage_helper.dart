import 'package:get_storage/get_storage.dart';
import 'package:sharek/app/modules/location_getter_widgets/models/districts_model.dart';

import '../../app/modules/location_getter_widgets/models/cities_model.dart';
import '../../app/modules/location_getter_widgets/models/regions_model.dart';

class CacheHelper {
  //========================================================

  static final GetStorage _appBox = GetStorage();
  static Future<void> init() async => await GetStorage.init();
  //========================================================

  static Future<void> cacheUserId({
    required int id,
  }) async {
    await _cacheUserId(id);
  }

  static Future<void> _cacheUserId(int id) async =>
      await _appBox.write('id', id);
  static String? get getUserId => _appBox.read('id').toString();

  static Future<void> cacheToken({
    required String token,
  }) async {
    await _cacheUserToken(token);
  }

  static Future<void> _cacheUserToken(String token) async =>
      await _appBox.write('token', token);
  static String? get getUserToken => _appBox.read('token');

//=========================================================
  static Future<void> cacheLocale({
    required String langCode,
  }) async {
    await _cacheLocale(langCode);
  }

  static Future<void> _cacheLocale(String langCode) async =>
      await _appBox.write('langCode', langCode);

  static String get getLocale => _appBox.read('langCode') ?? "ar";

  //========================================================
  static Future<void> saveIsFirstTime({
    required bool firstTime,
  }) async {
    return await _saveIsFirstTime(firstTime);
  }

  static Future<void> _saveIsFirstTime(bool firstTime) async {
    return await _appBox.write('FirstTime', firstTime);
  }

  static bool get getFirstTime => _appBox.read('FirstTime') ?? true;
  //========================================================

//=========================================================
  static Future<void> cacheRegion({
    required RegionModel region,
  }) async {
    await _cacheRegion(region);
  }

  static Future<void> _cacheRegion(RegionModel region) async =>
      await _appBox.write('region', region);

  static RegionModel? get getRegion {
    if (_appBox.read('region') != null) {
      return RegionModel.fromJson(_appBox.read('region'));
    }

    return null;
  }

  //========================================================
  static Future<void> cacheCity({
    required CityModel city,
  }) async {
    await _cacheCity(city);
  }

  static Future<void> _cacheCity(CityModel city) async =>
      await _appBox.write('city', city);

  static CityModel? get getCity {
    if (_appBox.read('city') != null) {
      return CityModel.fromJson(_appBox.read('city'));
    }

    return null;
  }
  //========================================================

  static Future<void> cacheDistrict({
    required DistrictModel district,
  }) async {
    await _cacheDistrict(district);
  }

  static Future<void> _cacheDistrict(DistrictModel district) async =>
      await _appBox.write('district', district);

  static DistrictModel? get getDistrict {
    if (_appBox.read('district') != null) {
      return DistrictModel.fromJson(_appBox.read('district'));
    }

    return null;
  }
  //========================================================

  //========================================================
  //========================================================
  //========================================================
  //========================================================

  static Future<void> signOut() async => await _appBox.remove("token");
  //========================================================
}
