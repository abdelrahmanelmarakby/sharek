// ignore_for_file: no_leading_underscores_for_local_identifiers

class SarificeAdItemModel {
  bool? status;
  String? message;
  Data? data;

  SarificeAdItemModel({this.status, this.message, this.data});

  SarificeAdItemModel.fromJson(Map<String, dynamic> json) {
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
  int? advertisementId;
  int? userId;
  int? serviceTypeId;
  String? location;
  String? neighborhood;
  String? title;
  String? description;
  String? sacrificeType;
  int? phone;
  String? userName;
  String? createdAt1;
  String? createdAt2;
  Quantities? quantities;
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
      this.sacrificeType,
      this.phone,
      this.userName,
      this.createdAt1,
      this.createdAt2,
      this.quantities,
      this.photos,
      this.comments});

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
    if (json["sacrifice_type"] is String) {
      sacrificeType = json["sacrifice_type"];
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
    if (json["quantities"] is Map) {
      quantities = json["quantities"] == null
          ? null
          : Quantities.fromJson(json["quantities"]);
    }
    if (json["photos"] is List) {
      photos =
          json["photos"] == null ? null : List<String>.from(json["photos"]);
    }
    if (json["comments"] is List) {
      comments = json["comments"] == null
          ? null
          : (json["comments"] as List)
              .map((e) => Comments.fromJson(e))
              .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["advertisement_id"] = advertisementId;
    _data["user_id"] = userId;
    _data["service_type_id"] = serviceTypeId;
    _data["location"] = location;
    _data["neighborhood"] = neighborhood;
    _data["title"] = title;
    _data["description"] = description;
    _data["sacrifice_type"] = sacrificeType;
    _data["phone"] = phone;
    _data["user_name"] = userName;
    _data["created_at_1"] = createdAt1;
    _data["created_at_2"] = createdAt2;
    if (quantities != null) {
      _data["quantities"] = quantities?.toJson();
    }
    if (photos != null) {
      _data["photos"] = photos;
    }
    if (comments != null) {
      _data["comments"] = comments?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Comments {
  String? userName;
  String? comment;
  String? avatar;
  String? createdAt;

  Comments({this.userName, this.comment, this.avatar, this.createdAt});

  Comments.fromJson(Map<String, dynamic> json) {
    if (json["user_name"] is String) {
      userName = json["user_name"];
    }
    if (json["comment"] is String) {
      comment = json["comment"];
    }
    if (json["avatar"] is String) {
      avatar = json["avatar"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["user_name"] = userName;
    _data["comment"] = comment;
    _data["avatar"] = avatar;
    _data["created_at"] = createdAt;
    return _data;
  }
}

class Quantities {
  Eighth? eighth;
  Quarter? quarter;
  Third? third;
  Half? half;

  Quantities({this.eighth, this.quarter, this.third, this.half});

  Quantities.fromJson(Map<String, dynamic> json) {
    if (json["eighth"] is Map) {
      eighth = json["eighth"] == null ? null : Eighth.fromJson(json["eighth"]);
    }
    if (json["quarter"] is Map) {
      quarter =
          json["quarter"] == null ? null : Quarter.fromJson(json["quarter"]);
    }
    if (json["third"] is Map) {
      third = json["third"] == null ? null : Third.fromJson(json["third"]);
    }
    if (json["half"] is Map) {
      half = json["half"] == null ? null : Half.fromJson(json["half"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (eighth != null) {
      _data["eighth"] = eighth?.toJson();
    }
    if (quarter != null) {
      _data["quarter"] = quarter?.toJson();
    }
    if (third != null) {
      _data["third"] = third?.toJson();
    }
    if (half != null) {
      _data["half"] = half?.toJson();
    }
    return _data;
  }
}

class Half {
  int? price;
  int? quantity;

  Half({this.price, this.quantity});

  Half.fromJson(Map<String, dynamic> json) {
    if (json["price"] is int) {
      price = json["price"];
    }
    if (json["quantity"] is int) {
      quantity = json["quantity"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["price"] = price;
    _data["quantity"] = quantity;
    return _data;
  }
}

class Third {
  int? price;
  int? quantity;

  Third({this.price, this.quantity});

  Third.fromJson(Map<String, dynamic> json) {
    if (json["price"] is int) {
      price = json["price"];
    }
    if (json["quantity"] is int) {
      quantity = json["quantity"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["price"] = price;
    _data["quantity"] = quantity;
    return _data;
  }
}

class Quarter {
  int? price;
  int? quantity;

  Quarter({this.price, this.quantity});

  Quarter.fromJson(Map<String, dynamic> json) {
    if (json["price"] is int) {
      price = json["price"];
    }
    if (json["quantity"] is int) {
      quantity = json["quantity"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["price"] = price;
    _data["quantity"] = quantity;
    return _data;
  }
}

class Eighth {
  int? price;
  int? quantity;

  Eighth({this.price, this.quantity});

  Eighth.fromJson(Map<String, dynamic> json) {
    if (json["price"] is int) {
      price = json["price"];
    }
    if (json["quantity"] is int) {
      quantity = json["quantity"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["price"] = price;
    _data["quantity"] = quantity;
    return _data;
  }
}
