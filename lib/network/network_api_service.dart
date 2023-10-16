import 'dart:io';

import 'package:test_tech_digital_paca/model/user_model.dart';
import 'package:test_tech_digital_paca/res/app_url.dart';
import 'package:test_tech_digital_paca/view_model/user_view_model.dart';
import 'package:dio/dio.dart';

enum Status { completed, error, loading }

class NetworkApiService {
  final dio = Dio(BaseOptions(
      baseUrl: AppUrl.baseUrl,
      responseType: ResponseType.json,
      contentType: "application/json"));

  Future<UserModel> getUserData() => UserViewModel().getUser();

  NetworkApiService() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        options.headers["Accept"] = "application/json";
        final UserModel userModel = await getUserData();
        final token = userModel.token;
        options.headers["Authorization"] = "Bearer $token";
        return handler.next(options);
      },
      onError: (e, handler) async {
        if (e.response?.statusCode == 401 &&
            e.response?.data["message"].contains("Invalid token")) {
          final newAccessToken = await refreshToken();
          if (newAccessToken != null) {
            dio.options.headers["Authorization"] = "Bearer $newAccessToken";
            return handler.resolve(await dio.fetch(e.requestOptions));
          }
        }
        if (e.response?.statusCode == 401) {
          var ee = DioException(
              requestOptions: e.requestOptions,
              error: e.response?.data["message"],
              message: "");

          return handler.next(ee);
        }

        return handler.next(e);
      },
    ));
  }

  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await dio.get(url);

      responseJson = response.data;
    } on SocketException {
      throw 'No Internet Connection';
    }

    return responseJson;
  }

  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      Response response =
          await dio.post(url, data: data).timeout(const Duration(seconds: 10));

      responseJson = response.data;
    } on SocketException {
      throw 'No Internet Connection';
    }

    return responseJson;
  }

  Future getNoIdentificationPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      Response response =
          await dio.post(url, data: data).timeout(const Duration(seconds: 10));

      responseJson = response.data;
    } on SocketException {
      throw 'No Internet Connection';
    }

    return responseJson;
  }

  Future refreshToken() async {
    try {
      final UserModel userModel = await getUserData();
      final refreshToken = userModel.refreshToken;
      final response = await dio.post(AppUrl.refreshTokenEndPoint,
          data: {'refreshToken': refreshToken});
      final newAccessToken = response.data['token'];

      UserViewModel().saveUser(UserModel(
          token: response.data['token'],
          refreshToken: response.data['refreshToken']));
      return newAccessToken;
    } catch (exception) {
      UserViewModel().remove();
    }
  }
}
