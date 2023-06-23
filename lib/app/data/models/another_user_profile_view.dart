// ignore_for_file: no_leading_underscores_for_local_identifiers

class AnotherUserProfile {
  bool? status;
  String? message;
  Data? data;

  AnotherUserProfile({this.status, this.message, this.data});

  AnotherUserProfile.fromJson(Map<String, dynamic> json) {
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
  User? user;
  List<Advertisement>? advertisement;

  Data({this.user, this.advertisement});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["user"] is Map) {
      user = json["user"] == null ? null : User.fromJson(json["user"]);
    }
    if (json["advertisement"] is List) {
      advertisement = json["advertisement"] == null
          ? null
          : (json["advertisement"] as List)
              .map((e) => Advertisement.fromJson(e))
              .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (user != null) {
      _data["user"] = user?.toJson();
    }
    if (advertisement != null) {
      _data["advertisement"] = advertisement?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Advertisement {
  int? advertisementId;
  int? serviceId;
  String? location;
  String? neighborhood;
  String? title;
  String? userName;
  String? createdAt1;
  String? createdAt2;
  List<String>? photos;

  Advertisement(
      {this.advertisementId,
      this.serviceId,
      this.location,
      this.neighborhood,
      this.title,
      this.userName,
      this.createdAt1,
      this.createdAt2,
      this.photos});

  Advertisement.fromJson(Map<String, dynamic> json) {
    if (json["advertisement_id"] is int) {
      advertisementId = json["advertisement_id"];
    }
    if (json["service_id"] is int) {
      serviceId = json["service_id"];
    }
    if (json["location"] is String) {
      location = json["location"];
    }
    if (json["neighborhood"] is String) {
      neighborhood = json["neighborhood"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["user_name"] is String) {
      userName = json["user_name"];
    }
    if (json["created_at_1"] is String) {
      createdAt1 = json["created_at_1"];
    }
    if (json["created_at_2"] is String) {
      createdAt2 = json["created_at_2"];
    }
    if (json["photos"] is List) {
      photos =
          json["photos"] == null ? null : List<String>.from(json["photos"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["advertisement_id"] = advertisementId;
    _data["service_id"] = serviceId;
    _data["location"] = location;
    _data["neighborhood"] = neighborhood;
    _data["title"] = title;
    _data["user_name"] = userName;
    _data["created_at_1"] = createdAt1;
    _data["created_at_2"] = createdAt2;
    if (photos != null) {
      _data["photos"] = photos;
    }
    return _data;
  }
}

class User {
  int? id;
  dynamic phone;
  String? name;
  dynamic accountVerified;
  dynamic deviceToken;
  String? avatar;
  int? phoneStatus;
  String? createdAt1;
  String? createdAt2;

  User(
      {this.id,
      this.phone,
      this.name,
      this.accountVerified,
      this.deviceToken,
      this.avatar,
      this.phoneStatus,
      this.createdAt1,
      this.createdAt2});

  User.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    phone = json["phone"];
    if (json["name"] is String) {
      name = json["name"];
    }
    accountVerified = json["account_verified"];
    deviceToken = json["device_token"];
    if (json["avatar"] is String) {
      avatar = json["avatar"];
    }
    if (json["phone_status"] is int) {
      phoneStatus = json["phone_status"];
    }
    if (json["created_at_1"] is String) {
      createdAt1 = json["created_at_1"];
    }
    if (json["created_at_2"] is String) {
      createdAt2 = json["created_at_2"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["phone"] = phone;
    _data["name"] = name;
    _data["account_verified"] = accountVerified;
    _data["device_token"] = deviceToken;
    _data["avatar"] = avatar;
    _data["phone_status"] = phoneStatus;
    _data["created_at_1"] = createdAt1;
    _data["created_at_2"] = createdAt2;
    return _data;
  }
}
