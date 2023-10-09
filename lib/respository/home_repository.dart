import 'package:test_tech_digital_paca/data/network/base_api_service.dart';
import 'package:test_tech_digital_paca/data/network/network_api_service.dart';
import 'package:test_tech_digital_paca/model/movies_model.dart';
import 'package:test_tech_digital_paca/res/app_url.dart';

class HomeRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<MovieListModel> fetchMoviesList() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.moviesListEndPoint);
      return response = MovieListModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
