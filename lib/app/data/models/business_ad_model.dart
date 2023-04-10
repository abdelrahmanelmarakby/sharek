class BusinessPartnerAdModel {
  bool? status;
  String? message;
  Data? data;

  BusinessPartnerAdModel({this.status, this.message, this.data});

  BusinessPartnerAdModel.fromJson(Map<String, dynamic> json) {
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
  int? advertisementId;
  int? userId;
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
  List<Comments>? comments;

  Data(
      {this.advertisementId,
      this.userId,
      this.serviceTypeId,
      this.location,
      this.neighborhood,
      this.title,
      this.description,
      this.phone,
      this.userName,
      this.createdAt1,
      this.createdAt2,
      this.photos,
      this.comments});

  Data.fromJson(Map<String, dynamic> json) {
    advertisementId = json['advertisement_id'];
    userId = json['user_id'];
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
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['advertisement_id'] = advertisementId;
    data['user_id'] = userId;
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
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comments {
  String? userName;
  String? comment;
  String? avatar;
  String? createdAt;

  Comments({this.userName, this.comment, this.avatar, this.createdAt});

  Comments.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    comment = json['comment'];
    avatar = json['avatar'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_name'] = userName;
    data['comment'] = comment;
    data['avatar'] = avatar;
    data['created_at'] = createdAt;
    return data;
  }
}
