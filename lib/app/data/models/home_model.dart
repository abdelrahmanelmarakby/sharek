// ignore_for_file: no_leading_underscores_for_local_identifiers

class HomeModel {
  bool? status;
  String? message;
  Data? data;

  HomeModel({this.status, this.message, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
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
  List<Services>? services;
  List<NewAdvertisements>? newAdvertisements;

  Data({this.services, this.newAdvertisements});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["services"] is List) {
      services = json["services"] == null
          ? null
          : (json["services"] as List)
              .map((e) => Services.fromJson(e))
              .toList();
    }
    if (json["New_advertisements"] is List) {
      newAdvertisements = json["New_advertisements"] == null
          ? null
          : (json["New_advertisements"] as List)
              .map((e) => NewAdvertisements.fromJson(e))
              .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (services != null) {
      _data["services"] = services?.map((e) => e.toJson()).toList();
    }
    if (newAdvertisements != null) {
      _data["New_advertisements"] =
          newAdvertisements?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class NewAdvertisements {
  int? advertisementId;
  int? serviceId;
  String? location;
  String? neighborhood;
  String? title;
  String? userName;
  String? createdAt1;
  String? createdAt2;
  List<String>? photos;
  NewAdvertisements(
      {this.advertisementId,
      this.serviceId,
      this.location,
      this.neighborhood,
      this.title,
      this.userName,
      this.createdAt1,
      this.createdAt2,
      this.photos});

  NewAdvertisements.fromJson(Map<String, dynamic> json) {
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

class Services {
  int? serviceId;
  String? name;
  String? icon;
  List<ServiceType>? serviceType;

  Services({this.serviceId, this.name, this.icon, this.serviceType});

  Services.fromJson(Map<String, dynamic> json) {
    if (json["service_id"] is int) {
      serviceId = json["service_id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["icon"] is String) {
      icon = json["icon"];
    }
    if (json["service_type"] is List) {
      serviceType = json["service_type"] == null
          ? null
          : (json["service_type"] as List)
              .map((e) => ServiceType.fromJson(e))
              .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["service_id"] = serviceId;
    _data["name"] = name;
    _data["icon"] = icon;
    if (serviceType != null) {
      _data["service_type"] = serviceType?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class ServiceType {
  int? serviceTypeId;
  String? name;

  ServiceType({this.serviceTypeId, this.name});

  ServiceType.fromJson(Map<String, dynamic> json) {
    if (json["service_type_id"] is int) {
      serviceTypeId = json["service_type_id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["service_type_id"] = serviceTypeId;
    _data["name"] = name;
    return _data;
  }
}
