// ignore_for_file: no_leading_underscores_for_local_identifiers

class UserDataModel {
  bool? status;
  String? message;
  Data? data;

  UserDataModel({this.status, this.message, this.data});

  UserDataModel.fromJson(Map<String, dynamic> json) {
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
  int? phone;
  String? name;
  dynamic accountVerified;
  String? deviceToken;
  String? avatar;

  Data(
      {this.phone,
      this.name,
      this.accountVerified,
      this.deviceToken,
      this.avatar});

  Data.fromJson(Map<String, dynamic> json) {
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
