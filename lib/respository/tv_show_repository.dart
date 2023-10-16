import 'package:test_tech_digital_paca/network/network_api_service.dart';
import 'package:test_tech_digital_paca/res/app_url.dart';

class TVShowhRepository {
  final NetworkApiService _apiServices = NetworkApiService();

  Future<dynamic> populateTVShowsApi() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.tvShowListEndPoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
