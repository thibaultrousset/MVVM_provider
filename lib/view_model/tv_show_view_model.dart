import 'dart:convert';

import 'package:test_tech_digital_paca/model/tv_show_model.dart';

class TVShowViewModel {
  final TVShow _tvShow;

  TVShowViewModel({required TVShow tvShow}) : _tvShow = tvShow;

  int get id {
    return _tvShow.id ?? 0;
  }

  String get title {
    return _tvShow.title ?? "";
  }

  String get year {
    return _tvShow.year ?? "";
  }

  String get director {
    return _tvShow.director ?? "";
  }

  int get duration {
    return _tvShow.duration ?? 0;
  }

  int get rate {
    return _tvShow.rate ?? 0;
  }

  String get type {
    return _tvShow.type ?? "";
  }

  String get description {
    return _tvShow.description ?? "";
  }

  String get thumbUrl {
    return _tvShow.thumbUrl ?? "";
  }

  String get bannerUrl {
    return _tvShow.bannerUrl ?? "";
  }

  @override
  String toString() {
    return '$id $title $year $director $duration $rate $type $description $thumbUrl $bannerUrl';
  }
}
