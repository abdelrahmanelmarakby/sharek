class HomeModel {
  bool? status;
  String? message;
  Data? data;

  HomeModel({this.status, this.message, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
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
  List<Services>? services;
  List<NewAdvertisements>? newAdvertisements;

  Data({this.services, this.newAdvertisements});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
    if (json['New_advertisements'] != null) {
      newAdvertisements = <NewAdvertisements>[];
      json['New_advertisements'].forEach((v) {
        newAdvertisements!.add(NewAdvertisements.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    if (newAdvertisements != null) {
      data['New_advertisements'] =
          newAdvertisements!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  int? serviceId;
  String? name;
  String? icon;

  Services({this.serviceId, this.name, this.icon});

  Services.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    name = json['name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_id'] = serviceId;
    data['name'] = name;
    data['icon'] = icon;
    return data;
  }
}

class NewAdvertisements {
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
  String? startingPlace;
  String? endingPlace;
  String? carType;

  NewAdvertisements(
      {this.advertisementId,
      this.serviceId,
      this.serviceTypeId,
      this.location,
      this.neighborhood,
      this.title,
      this.userName,
      this.createdAt1,
      this.createdAt2,
      this.photos,
      this.startingPlace,
      this.endingPlace,
      this.carType});

  NewAdvertisements.fromJson(Map<String, dynamic> json) {
    advertisementId = json['advertisement_id'];
    serviceId = json['service_id'];
    serviceTypeId = json['service_type_id'];
    location = json['location'];
    neighborhood = json['neighborhood'];
    title = json['title'];
    userName = json['user_name'];
    createdAt1 = json['created_at_1'];
    createdAt2 = json['created_at_2'];
    photos = json['photos'].cast<String>();
    startingPlace = json['starting_place'];
    endingPlace = json['ending_place'];
    carType = json['car_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['advertisement_id'] = advertisementId;
    data['service_id'] = serviceId;
    data['service_type_id'] = serviceTypeId;
    data['location'] = location;
    data['neighborhood'] = neighborhood;
    data['title'] = title;
    data['user_name'] = userName;
    data['created_at_1'] = createdAt1;
    data['created_at_2'] = createdAt2;
    data['photos'] = photos;
    data['starting_place'] = startingPlace;
    data['ending_place'] = endingPlace;
    data['car_type'] = carType;
    return data;
  }
}
