import 'package:flutter/material.dart';
import 'package:test_tech_digital_paca/model/tv_show_model.dart';
import 'package:test_tech_digital_paca/network/network_api_service.dart';
import 'package:test_tech_digital_paca/respository/auth_repository.dart';
import 'package:test_tech_digital_paca/respository/tv_show_repository.dart';
import 'package:test_tech_digital_paca/utils/routes/routes_name.dart';
import 'package:test_tech_digital_paca/utils/utils.dart';

import 'package:test_tech_digital_paca/view_model/tv_show_view_model.dart';

class TVShowListViewModel extends ChangeNotifier {
  final _myRepo = TVShowhRepository();

  List<TVShowViewModel> tvShowsVM = <TVShowViewModel>[];

  Status loadingStatus = Status.loading;

  void populateTVShowList(BuildContext context) async {
    loadingStatus = Status.loading;
    notifyListeners();

    Iterable list;
    _myRepo.populateTVShowsApi().then((dynamic responseJson) {
      list = responseJson.map((tvShow) => TVShow.fromJson(tvShow)).toList();
      tvShowsVM = list.map((e) => TVShowViewModel(tvShow: e)).toList();
      loadingStatus = tvShowsVM.isEmpty ? Status.error : Status.completed;
      notifyListeners();
    }).onError((error, stackTrace) {
      if (error.toString().contains("Invalid token")) {
        Navigator.pushNamed(context, RoutesName.login);
      }
      Utils.snackBar(error.toString(), Colors.red, context);
    });
  }
}
