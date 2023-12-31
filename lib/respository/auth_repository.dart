import 'package:test_tech_digital_paca/network/network_api_service.dart';
import 'package:test_tech_digital_paca/res/app_url.dart';

class AuthRepository {
  final NetworkApiService _apiServices = NetworkApiService();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getNoIdentificationPostApiResponse(
          AppUrl.loginEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
