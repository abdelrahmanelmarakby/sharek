// ignore_for_file: no_leading_underscores_for_local_identifiers, duplicate_ignore

class UserModel {
  bool? status;
  String? message;
  Data? data;

  UserModel({this.status, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] is bool) {
      status = json["status"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["data"] is Map) {
      data = json["data"] == null ? null : Data.fromJson(json["data"]);
    }
  }

  Map<String, dynamic> toJson() {
    // ignore: no_leading_underscores_for_local_identifiers
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class Data {
  String? token;
  User? user;

  Data({this.token, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["token"] is String) {
      token = json["token"];
    }
    if (json["user"] is Map) {
      user = json["user"] == null ? null : User.fromJson(json["user"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["token"] = token;
    if (user != null) {
      _data["user"] = user?.toJson();
    }
    return _data;
  }
}

class User {
  int? phone;
  String? name;
  dynamic accountVerified;
  String? deviceToken;
  String? avatar;

  User(
      {this.phone,
      this.name,
      this.accountVerified,
      this.deviceToken,
      this.avatar});

  User.fromJson(Map<String, dynamic> json) {
    if (json["phone"] is int) {
      phone = json["phone"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    accountVerified = json["account_verified"];
    if (json["device_token"] is String) {
      deviceToken = json["device_token"];
    }
    if (json["avatar"] is String) {
      avatar = json["avatar"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["phone"] = phone;
    _data["name"] = name;
    _data["account_verified"] = accountVerified;
    _data["device_token"] = deviceToken;
    _data["avatar"] = avatar;
    return _data;
  }
}
