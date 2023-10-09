import 'package:test_tech_digital_paca/data/network/base_api_service.dart';
import 'package:test_tech_digital_paca/data/network/network_api_service.dart';
import 'package:test_tech_digital_paca/res/app_url.dart';

class AuthRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.loginEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> refreshTokenApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.refreshTokenEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
