
class HousePartnersModel {
  bool? status;
  String? message;
  List<Data>? data;

  HousePartnersModel({this.status, this.message, this.data});

  HousePartnersModel.fromJson(Map<String, dynamic> json) {
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
    // ignore: no_leading_underscores_for_local_identifiers
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
  int? userId;
  int? serviceTypeId;
  String? location;
  String? neighborhood;
  int? numberPartners;
  String? nationality;
  String? title;
  String? description;
  int? phone;
  String? userName;
  String? createdAt1;
  String? createdAt2;
  List<String>? photos;

  Data({this.advertisementId, this.userId, this.serviceTypeId, this.location, this.neighborhood, this.numberPartners, this.nationality, this.title, this.description, this.phone, this.userName, this.createdAt1, this.createdAt2, this.photos});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["advertisement_id"] is int) {
      advertisementId = json["advertisement_id"];
    }
    if(json["user_id"] is int) {
      userId = json["user_id"];
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
    if(json["number_partners"] is int) {
      numberPartners = json["number_partners"];
    }
    if(json["nationality"] is String) {
      nationality = json["nationality"];
    }
    if(json["title"] is String) {
      title = json["title"];
    }
    if(json["description"] is String) {
      description = json["description"];
    }
    if(json["phone"] is int) {
      phone = json["phone"];
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data["advertisement_id"] = advertisementId;
    data["user_id"] = userId;
    data["service_type_id"] = serviceTypeId;
    data["location"] = location;
    data["neighborhood"] = neighborhood;
    data["number_partners"] = numberPartners;
    data["nationality"] = nationality;
    data["title"] = title;
    data["description"] = description;
    data["phone"] = phone;
    data["user_name"] = userName;
    data["created_at_1"] = createdAt1;
    data["created_at_2"] = createdAt2;
    if(photos != null) {
      data["photos"] = photos;
    }
    return data;
  }
}