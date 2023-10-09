import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:test_tech_digital_paca/model/user_model.dart';
import 'package:test_tech_digital_paca/respository/auth_repository.dart';
import 'package:test_tech_digital_paca/utils/routes/routes_name.dart';
import 'package:test_tech_digital_paca/utils/utils.dart';
import 'package:test_tech_digital_paca/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);

    _myRepo.loginApi(data).then((value) {
      setLoading(false);
      final userPreference = Provider.of<UserViewModel>(context, listen: false);
      userPreference.saveUser(UserModel(token: value['token'].toString()));

      Utils.snackBar('Login Successfully', context);
      Navigator.pushNamed(context, RoutesName.home);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.snackBar(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
