class AdsModel {
  bool? status;
  String? message;
  List<Ad>? data;

  AdsModel({this.status, this.message, this.data});

  AdsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Ad>[];
      json['data'].forEach((v) {
        data!.add(Ad.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ad {
  int? advertisementId;
  int? serviceTypeId;
  String? location;
  String? neighborhood;
  String? title;
  String? description;
  int? phone;
  String? userName;
  String? createdAt1;
  String? createdAt2;
  List<String>? photos;

  Ad(
      {this.advertisementId,
      this.serviceTypeId,
      this.location,
      this.neighborhood,
      this.title,
      this.description,
      this.phone,
      this.userName,
      this.createdAt1,
      this.createdAt2,
      this.photos});

  Ad.fromJson(Map<String, dynamic> json) {
    advertisementId = json['advertisement_id'];
    serviceTypeId = json['service_type_id'];
    location = json['location'];
    neighborhood = json['neighborhood'];
    title = json['title'];
    description = json['description'];
    phone = json['phone'];
    userName = json['user_name'];
    createdAt1 = json['created_at_1'];
    createdAt2 = json['created_at_2'];
    photos = json['photos'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['advertisement_id'] = advertisementId;
    data['service_type_id'] = serviceTypeId;
    data['location'] = location;
    data['neighborhood'] = neighborhood;
    data['title'] = title;
    data['description'] = description;
    data['phone'] = phone;
    data['user_name'] = userName;
    data['created_at_1'] = createdAt1;
    data['created_at_2'] = createdAt2;
    data['photos'] = photos;
    return data;
  }
}
