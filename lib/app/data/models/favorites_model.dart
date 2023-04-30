
// ignore_for_file: no_leading_underscores_for_local_identifiers

class FavoritesModel {
  bool? status;
  String? message;
  List<Data>? data;

  FavoritesModel({this.status, this.message, this.data});

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    if(json["status"] is bool) {
      status = json["status"];
    }
    if(json["message"] is String) {
      message = json["message"];
    }
    if(json["data"] is List) {
      data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["message"] = message;
    if(data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Data {
  int? advertisementId;
  int? serviceId;
  int? serviceTypeId;
  String? location;
  String? neighborhood;
  String? title;
  String? userName;
  String? createdAt1;
  String? createdAt2;
  List<String>? photos;

  Data({this.advertisementId, this.serviceId, this.serviceTypeId, this.location, this.neighborhood, this.title, this.userName, this.createdAt1, this.createdAt2, this.photos});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["advertisement_id"] is int) {
      advertisementId = json["advertisement_id"];
    }
    if(json["service_id"] is int) {
      serviceId = json["service_id"];
    }
    if(json["service_type_id"] is int) {
      serviceTypeId = json["service_type_id"];
    }
    if(json["location"] is String) {
      location = json["location"];
    }
    if(json["neighborhood"] is String) {
      neighborhood = json["neighborhood"];
    }
    if(json["title"] is String) {
      title = json["title"];
    }
    if(json["user_name"] is String) {
      userName = json["user_name"];
    }
    if(json["created_at_1"] is String) {
      createdAt1 = json["created_at_1"];
    }
    if(json["created_at_2"] is String) {
      createdAt2 = json["created_at_2"];
    }
    if(json["photos"] is List) {
      photos = json["photos"] == null ? null : List<String>.from(json["photos"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["advertisement_id"] = advertisementId;
    _data["service_id"] = serviceId;
    _data["service_type_id"] = serviceTypeId;
    _data["location"] = location;
    _data["neighborhood"] = neighborhood;
    _data["title"] = title;
    _data["user_name"] = userName;
    _data["created_at_1"] = createdAt1;
    _data["created_at_2"] = createdAt2;
    if(photos != null) {
      _data["photos"] = photos;
    }
    return _data;
  }
}