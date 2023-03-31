import 'package:sharek/app/data/models/ads_model.dart';
import 'package:sharek/core/global/const.dart';
import 'package:sharek/core/services/network_service.dart/dio_network_service.dart';

class BusinessPartnerAPI {
  static Future<AdsModel?> getBusinessAds() async {
    const request = NetworkRequest(
      type: NetworkRequestType.GET,
      path: APIKeys.businessAds,
      data: NetworkRequestBody.empty(),
    );
    final response = await networkService.execute(
        request, (json) => AdsModel.fromJson(json));
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      orElse: () {},
    );
    return data;
  }
}
