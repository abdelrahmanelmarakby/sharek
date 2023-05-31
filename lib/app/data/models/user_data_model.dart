class UserModel {
  bool? status;
  String? message;
  Data? data;

  UserModel({this.status, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
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

  @override
  String toString() =>
      'UserModel(status: $status, message: $message, data: $data)';
}

class Data {
  String? token;
  User? user;

  Data({this.token, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }

  @override
  String toString() => 'Data(token: $token, user: $user)';
}

class User {
  int? id;
  int? phone;
  String? name;
  bool? accountVerified;
  String? deviceToken;
  String? avatar;

  User(
      {this.id,
      this.phone,
      this.name,
      this.accountVerified,
      this.deviceToken,
      this.avatar});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    name = json['name'];
    accountVerified = json['account_verified'];
    deviceToken = json['device_token'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['phone'] = phone;
    data['name'] = name;
    data['account_verified'] = accountVerified;
    data['device_token'] = deviceToken;
    data['avatar'] = avatar;
    return data;
  }

  @override
  String toString() {
    return 'User(id: $id, phone: $phone, name: $name, accountVerified: $accountVerified, deviceToken: $deviceToken, avatar: $avatar)';
  }
}
