class UserModel {
  String? token;
  String? refreshToken;

  UserModel({this.token, this.refreshToken});

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;

    return data;
  }

  Map<String, dynamic> toJsonRefresh() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;

    return data;
  }
}
