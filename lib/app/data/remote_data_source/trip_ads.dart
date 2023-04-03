import 'package:dio/dio.dart';
import 'package:sharek/core/global/const.dart';
import 'package:sharek/core/services/network_service.dart/dio_network_service.dart';
import '../models/trip_ads_model.dart';

class TripPartnerAPI {
  static Future<TripAdvertisementsModel?> getTripAds() async {
    const request = NetworkRequest(
      type: NetworkRequestType.GET,
      path: APIKeys.tripAds,
      data: NetworkRequestBody.empty(),
    );
    final response = await networkService.execute(
        request, (json) => TripAdvertisementsModel.fromJson(json));
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      orElse: () {},
    );
    return data;
  }

  static Future<TripAdvertisementsModel?> filterTripAds({
    int? servicesTypeid,
    String? startingPlace,
    int? numberPassengers,
    String? endingPlace,
    String? nationality,
    String? date,
    String? time,
    double? price,
    bool? withPackages,
    String? carType,
  }) async {
    final request = NetworkRequest(
      type: NetworkRequestType.POST,
      path: APIKeys.tripAds,
      data: NetworkRequestBody.fromData(
        FormData.fromMap(
          {
            "service_type_id": servicesTypeid,
          },
        ),
      ),
    );
    final response = await networkService.execute(
        request, (json) => TripAdvertisementsModel.fromJson(json));
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      orElse: () {},
    );
    return data;
  }
}
