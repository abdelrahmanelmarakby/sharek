class UserInfoModel {
  bool? status;
  String? message;
  Data? data;

  UserInfoModel({this.status, this.message, this.data});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? phone;
  String? name;
  String? accountVerified;
  String? deviceToken;
  String? avatar;
  String? createdAt1;
  String? createdAt2;

  Data(
      {this.id,
      this.phone,
      this.name,
      this.accountVerified,
      this.deviceToken,
      this.avatar,
      this.createdAt1,
      this.createdAt2});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    name = json['name'];
    accountVerified = json['account_verified'];
    deviceToken = json['device_token'];
    avatar = json['avatar'];
    createdAt1 = json['created_at_1'];
    createdAt2 = json['created_at_2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['phone'] = phone;
    data['name'] = name;
    data['account_verified'] = accountVerified;
    data['device_token'] = deviceToken;
    data['avatar'] = avatar;
    data['created_at_1'] = createdAt1;
    data['created_at_2'] = createdAt2;
    return data;
  }
}
