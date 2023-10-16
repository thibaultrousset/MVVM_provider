import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_tech_digital_paca/model/user_model.dart';
import 'package:test_tech_digital_paca/network/network_api_service.dart';
import 'package:test_tech_digital_paca/respository/auth_repository.dart';
import 'package:test_tech_digital_paca/utils/routes/routes_name.dart';
import 'package:test_tech_digital_paca/utils/utils.dart';
import 'package:test_tech_digital_paca/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  Status loadingStatus = Status.completed;
  Future<UserModel> getUserData() => UserViewModel().getUser();

  Future<void> loginApi(dynamic data, BuildContext context) async {
    loadingStatus = Status.loading;
    notifyListeners();

    _myRepo.loginApi(data).then((value) async {
      final userPreference = Provider.of<UserViewModel>(context, listen: false);

      userPreference.saveUser(UserModel(
          token: value['token'], refreshToken: value['refreshToken']));

      Utils.snackBar('Login Successfully', Colors.green, context);
      Navigator.pushNamed(context, RoutesName.home);
      loadingStatus = Status.completed;
      notifyListeners();
    }).onError((error, stackTrace) {
      Utils.snackBar(error.toString(), Colors.red, context);
      loadingStatus = Status.error;
      notifyListeners();
    });
  }
}
