// ignore_for_file: no_leading_underscores_for_local_identifiers

class BusinessPartnerModel {
  bool? status;
  String? message;
  List<Data>? data;

  BusinessPartnerModel({this.status, this.message, this.data});

  BusinessPartnerModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] is bool) {
      status = json["status"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["data"] is List) {
      data = json["data"] == null
          ? null
          : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Data {
  int? advertisementId;
  int? userId;
  int? serviceTypeId;
  String? type;
  String? location;
  String? neighborhood;
  String? title;
  String? description;
  int? phone;
  String? userName;
  String? createdAt1;
  String? createdAt2;
  List<String>? photos;

  Data(
      {this.advertisementId,
      this.userId,
      this.serviceTypeId,
      this.type,
      this.location,
      this.neighborhood,
      this.title,
      this.description,
      this.phone,
      this.userName,
      this.createdAt1,
      this.createdAt2,
      this.photos});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["advertisement_id"] is int) {
      advertisementId = json["advertisement_id"];
    }
    if (json["user_id"] is int) {
      userId = json["user_id"];
    }
    if (json["service_type_id"] is int) {
      serviceTypeId = json["service_type_id"];
    }
    if (json["type"] is String) {
      type = json["type"];
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
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["phone"] is int) {
      phone = json["phone"];
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
    _data["user_id"] = userId;
    _data["service_type_id"] = serviceTypeId;
    _data["type"] = type;
    _data["location"] = location;
    _data["neighborhood"] = neighborhood;
    _data["title"] = title;
    _data["description"] = description;
    _data["phone"] = phone;
    _data["user_name"] = userName;
    _data["created_at_1"] = createdAt1;
    _data["created_at_2"] = createdAt2;
    if (photos != null) {
      _data["photos"] = photos;
    }
    return _data;
  }
}
